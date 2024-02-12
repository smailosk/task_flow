/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 * 
 * From folder functions: npm run build && firebase emulators:start --only functions

 * Ismail: sudo npm run build && sudo firebase emulators:start 26240578

 */
import { onCall, onRequest, HttpsError } from "firebase-functions/v2/https";
import * as functions from 'firebase-functions';

import { initializeApp } from "firebase-admin/app";
import { FieldValue, Timestamp, getFirestore } from "firebase-admin/firestore";
import { Environment, Project, Task, FunctionsErrorCodes } from "./models";
import { generateRandomColor } from "./utils";
initializeApp();
const firestoreDb = getFirestore();

// export const CreateProject = onRequest(async (request, response) => {
//     const firestore = getFirestore();

//     try {
//         // Define the collection and data to add
//         const collection = firestore.collection('Projects');
//         const data: Environment = {
//             id: "SOmeIDSpqofjhwqpof",
//             color: "X012421412",
//             icon: "Home",
//             name: "Project name"
//         };

//         // Add a new document with an auto-generated ID
//         const docRef = await collection.add(data);

//         logger.info("New document created with ID: " + docRef.id, { structuredData: true });
//         response.send("Hello from Firebase! Document created with ID: " + docRef.id);
//     } catch (error) {
//         logger.error("Error creating document: ", error);
//         response.status(500).send("Error creating document");
//     }
// });


export const PrintBody = onRequest(async (request, response) => {

    try {
        if (typeof request.body.id !== 'string' ||
            typeof request.body.name !== 'string' ||
            typeof request.body.icon !== 'string' ||
            typeof request.body.color !== 'string') {
            throw new Error('Invalid data format');
        }
        const data: Environment = request.body;


        response.send(`Data processed successfully ${JSON.stringify(data)}`);
    } catch (error) {
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});


exports.OnUserCreated = functions.auth.user().onCreate(async (user) => {
    try {

        // Create an example environment
        const environmentData: Environment = {
            id: firestoreDb.collection('Environments').doc().id,
            name: 'Default Environment',
            icon: 'default_icon',
            color: generateRandomColor(),
            admins: [user.uid]
        };
        await firestoreDb.collection('Environments').doc(environmentData.id).set(environmentData);

        // Create an example project
        const projectData: Project = {
            id: firestoreDb.collection('Projects').doc().id,
            name: 'Default Project',
            parentEnvironmentId: environmentData.id,
            members: [user.uid],
            color: generateRandomColor()
        };
        await firestoreDb.collection('Projects').doc(projectData.id).set(projectData);

        // Create example tasks
        const taskData: Task[] = [{
            title: 'Example Task 1',
            id: firestoreDb.collection('Tasks').doc().id,
            details: 'Details of Example Task 1',
            parentProjectId: projectData.id,
            deadline: Timestamp.now().toMillis(),
            assignee: user.uid,
            done: false
        }, {
            title: 'Example Task 2',
            id: firestoreDb.collection('Tasks').doc().id,
            details: 'Details of Example Task 2',
            parentProjectId: projectData.id,
            deadline: Timestamp.now().toMillis(),
            assignee: user.uid,
            done: false
        }];

        for (const task of taskData) {
            await firestoreDb.collection('Tasks').doc(task.id).set(task);
        }

        // You can add additional actions here, such as sending a welcome email

        console.log('User initialization completed successfully for user:', user.uid);
        return null;

    } catch (error) {
        console.error('Error creating initial data for user:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});


export const createEnvironment = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.name !== 'string' ||
        typeof request.data.icon !== 'string' ||
        typeof request.data.color !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }
    // Check if color is a valid hex 16 string
    if (!/^#[0-9A-Fa-f]{6}$/i.test(request.data.color)) {
        throw new HttpsError(FunctionsErrorCodes.INVALID_ARGUMENT, 'Invalid color format:' + request.data.color);
    }

    try {
        const userId = request.auth.uid;

        // Create a new environment with the creator as an admin
        const newEnvironment: Environment = {
            id: firestoreDb.collection('Environments').doc().id,
            name: request.data.name,
            icon: request.data.icon,
            color: request.data.color,
            admins: [userId] // Set the creator as the admin
        };

        // Save the new environment to Firestore
        await firestoreDb.collection('Environments').doc(newEnvironment.id).set(newEnvironment);
        return newEnvironment;
    } catch (error) {
        console.error('Error creating environment:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});

export const deleteEnvironment = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.environmentId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const environmentId = request.data.environmentId;
    const userId = request.auth.uid;

    try {
        // Retrieve the environment to check if the user is an admin
        const environmentRef = firestoreDb.collection('Environments').doc(environmentId);
        const environmentDoc = await environmentRef.get();

        if (!environmentDoc.exists) {
            throw new HttpsError('not-found', 'Environment not found');
        }

        const environmentData = environmentDoc.data() as Environment; // Type assertion
        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError('permission-denied', 'User is not an admin of this environment');
        }

        // User is an admin, proceed with deletion
        await environmentRef.delete();

        return { message: 'Environment deleted successfully' };
    } catch (error) {
        console.error('Error deleting environment:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});


export const createProject = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data for the project
    if (typeof request.data.name !== 'string' ||
        typeof request.data.parentEnvironmentId !== 'string' ||
        typeof request.data.color !== 'string'
    ) {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const userId = request.auth.uid;
    const { name, parentEnvironmentId, color } = request.data; // Destructure the project data from the request

    try {
        // Retrieve the parent environment to check if the user is an admin
        const environmentRef = firestoreDb.collection('Environments').doc(parentEnvironmentId);
        const environmentDoc = await environmentRef.get();

        if (!environmentDoc.exists) {
            throw new HttpsError('not-found', 'Parent environment not found');
        }

        const environmentData = environmentDoc.data() as Environment;
        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError('permission-denied', 'User is not an admin of the parent environment');
        }

        // Create a new project with the provided data
        const newProject: Project = {
            id: firestoreDb.collection('Projects').doc().id,
            name: name,
            parentEnvironmentId: parentEnvironmentId,
            color: color,
            members: [userId] // Set the creator as the first member
        };

        // Save the new project to Firestore
        await firestoreDb.collection('Projects').doc(newProject.id).set(newProject);

        return newProject;
    } catch (error) {
        console.error('Error creating project:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});

export const deleteProject = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.projectId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }


    const projectId = request.data.projectId;
    const userId = request.auth.uid;

    try {
        // Retrieve the project to get the parent environment ID
        const projectRef = firestoreDb.collection('Projects').doc(projectId);
        const projectDoc = await projectRef.get();

        if (!projectDoc.exists) {
            throw new HttpsError('not-found', 'Project not found');
        }

        // Check if the user is an admin of the parent environment
        const parentEnvironmentId = projectDoc.data()?.parentEnvironmentId;
        if (!parentEnvironmentId) {
            throw new HttpsError('not-found', 'Parent environment not found');
        }

        const environmentRef = firestoreDb.collection('Environments').doc(parentEnvironmentId);
        const environmentDoc = await environmentRef.get();
        const environmentData = environmentDoc.data() as Environment;

        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError('permission-denied', 'User is not an admin of the parent environment');
        }

        // User is an admin, proceed with deletion
        await projectRef.delete();

        return { message: 'Project deleted successfully' };
    } catch (error) {
        console.error('Error deleting project:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});


export const addMemberToProject = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.projectId !== 'string' ||
        typeof request.data.memberId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }


    const { projectId, memberId } = request.data;
    const userId = request.auth.uid;

    try {
        // Retrieve the project
        const projectRef = firestoreDb.collection('Projects').doc(projectId);
        const projectDoc = await projectRef.get();

        if (!projectDoc.exists) {
            throw new HttpsError('not-found', 'Project not found');
        }

        // Check if the user is an admin of the parent environment
        const parentEnvironmentId = projectDoc.data()?.parentEnvironmentId;
        if (!parentEnvironmentId) {
            throw new HttpsError('not-found', 'Parent environment not found');
        }

        const environmentRef = firestoreDb.collection('Environments').doc(parentEnvironmentId);
        const environmentDoc = await environmentRef.get();
        const environmentData = environmentDoc.data() as Environment;

        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError(FunctionsErrorCodes.PERMISSION_DENIED, 'User is not an admin of the parent environment');

        }

        // Add the member to the project
        await projectRef.update({
            members: FieldValue.arrayUnion(memberId)
        });

        return { message: 'Member added to project successfully' };
    } catch (error) {
        console.error('Error adding member to project:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});

export const deleteMemberFromProject = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.projectId !== 'string' ||
        typeof request.data.memberId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }


    const { projectId, memberId } = request.data;
    const userId = request.auth.uid;

    try {
        // Retrieve the project
        const projectRef = firestoreDb.collection('Projects').doc(projectId);
        const projectDoc = await projectRef.get();

        if (!projectDoc.exists) {
            throw new HttpsError('not-found', 'Project not found');
        }

        // Check if the user is an admin of the parent environment
        const parentEnvironmentId = projectDoc.data()?.parentEnvironmentId;
        if (!parentEnvironmentId) {
            throw new HttpsError('not-found', 'Parent environment not found');
        }

        const environmentRef = firestoreDb.collection('Environments').doc(parentEnvironmentId);
        const environmentDoc = await environmentRef.get();
        const environmentData = environmentDoc.data() as Environment;

        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError('permission-denied', 'User is not an admin of the parent environment');
        }

        // Remove the member from the project
        await projectRef.update({
            members: FieldValue.arrayRemove(memberId)
        });

        return { message: 'Member removed from project successfully' };
    } catch (error) {
        console.error('Error removing member from project:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});


export const createTask = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data for the task
    if (typeof request.data.title !== 'string' ||
        typeof request.data.details !== 'string' ||
        typeof request.data.parentProjectId !== 'string'
        // Add additional validation as necessary
    ) {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const { title, details, parentProjectId, deadline, } = request.data; // Destructure the task data
    const assignee = request.auth.uid; // Assign task to the creator by default

    try {
        // Create a new task with the provided data
        const newTask: Task = {
            id: firestoreDb.collection('Tasks').doc().id,
            title,
            details,
            parentProjectId,
            deadline, // Convert string to Date object
            assignee,
            done: false // Default to not done
        };

        // Save the new task to Firestore
        await firestoreDb.collection('Tasks').doc(newTask.id).set(newTask);

        return newTask;
    } catch (error) {
        console.error('Error creating task:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});

export const deleteTask = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.taskId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }


    const taskId = request.data.taskId;

    try {
        // Delete the task
        await firestoreDb.collection('Tasks').doc(taskId).delete();

        return { message: 'Task deleted successfully' };
    } catch (error) {
        console.error('Error deleting task:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);
    }
});

export const modifyTask = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.taskId !== 'string' ||
        typeof request.data.newDetails !== 'string' // Add additional checks for other fields you want to modify
    ) {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const { taskId, newDetails } = request.data;

    try {
        // Update the task with new details
        await firestoreDb.collection('Tasks').doc(taskId).update({ details: newDetails });

        return { message: 'Task updated successfully' };
    } catch (error) {
        console.error('Error modifying task:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, error as string);


    }
});

export const markTaskDone = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }
    console.error(request.data);


    // Validate incoming data
    if (typeof request.data.id !== 'string' ||
        typeof request.data.done !== 'boolean') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const { id, done } = request.data;

    try {
        await firestoreDb.collection('Tasks').doc(id).update({ done });

        return {};
    } catch (error) {
        console.error('Error marking task as done/undone:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, 'Unable to mark task as done/undone.');

    }
});

export const assignTask = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.taskId !== 'string' ||
        typeof request.data.newAssigneeId !== 'string') {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const { taskId, newAssigneeId } = request.data;

    try {
        // Update the 'assignee' of the task
        await firestoreDb.collection('Tasks').doc(taskId).update({ assignee: newAssigneeId });

        return { message: 'Task assignee updated successfully' };
    } catch (error) {
        console.error('Error assigning task:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, 'Unable to assign task.');
    }
});


export const modifyEnvironment = onCall(async (request) => {
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    // Validate incoming data
    if (typeof request.data.environmentId !== 'string' ||
        typeof request.data.newTitle !== 'string' ||
        typeof request.data.newColor !== 'string' ||
        !Array.isArray(request.data.admins) ||
        request.data.admins.some((adminId: any) => typeof adminId !== 'string')) {
        throw new HttpsError('invalid-argument', 'Invalid data format');
    }

    const { environmentId, newTitle, newColor, admins } = request.data;
    const userId = request.auth.uid;

    try {
        // Retrieve the environment to check if the user is an admin
        const environmentRef = firestoreDb.collection('Environments').doc(environmentId);
        const environmentDoc = await environmentRef.get();

        if (!environmentDoc.exists) {
            throw new HttpsError('not-found', 'Environment not found');
        }

        const environmentData = environmentDoc.data() as Environment;
        if (!environmentData.admins.includes(userId)) {
            throw new HttpsError('permission-denied', 'User is not an admin of this environment');
        }

        // Update the environment with new details
        await environmentRef.update({
            name: newTitle,
            color: newColor,
            admins: admins
        });

        return { message: 'Environment updated successfully' };
    } catch (error) {
        console.error('Error modifying environment:', error);
        throw new HttpsError(FunctionsErrorCodes.INTERNAL, 'Unable to modify environment.');


    }
});