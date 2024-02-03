export interface Environment {
    id: string;
    name: string;
    icon: string;
    color: string;
    admins: string[];
}

export interface Project {
    id: string;
    name: string;
    parentEnvironmentId: string;
    members: string[]; // List of User IDs
    color: string; // RGB color code
}

export interface Task {
    title: string;
    id: string;
    done: boolean;
    details: string;
    parentProjectId: string;
    deadline: Date; // or firebase.firestore.Timestamp if using Firestore
    assignee: string; // User ID from project members
}

export interface User {
    id: string;
    username: string;
    displayName: string;
    email: string;
}
