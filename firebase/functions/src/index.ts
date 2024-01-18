/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

initializeApp();

export const helloWorld = onRequest(async (request, response) => {
    const firestore = getFirestore();

    try {
        // Define the collection and data to add
        const collection = firestore.collection('Projects');
        const data = {
            field1: 'value1',
            field2: 'value2',
            // ... other fields
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

