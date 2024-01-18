/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 * 
 * From folder functions: npm run build && firebase emulators:start --only functions
 */
import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { Environment } from "./models";
initializeApp();

export const CreateProject = onRequest(async (request, response) => {
    const firestore = getFirestore();

    try {
        // Define the collection and data to add
        const collection = firestore.collection('Projects');
        const data: Environment = {
            id: "SOmeIDSpqofjhwqpof",
            color: "X012421412",
            icon: "Home",
            name: "Project name"
        };

        // Add a new document with an auto-generated ID
        const docRef = await collection.add(data);

        logger.info("New document created with ID: " + docRef.id, { structuredData: true });
        response.send("Hello from Firebase! Document created with ID: " + docRef.id);
    } catch (error) {
        logger.error("Error creating document: ", error);
        response.status(500).send("Error creating document");
    }
});


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
        response.status(400).send("Invalid data format");
    }
});
