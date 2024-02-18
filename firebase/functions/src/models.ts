
export interface Environment {
    id: string;
    name: string;
    icon: number;
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
    deadline: number;
    assignee: string;
}

export interface User {
    id: string;
    username: string;
    displayName: string;
    email: string;
}

export const FunctionsErrorCodes = {
    OK: "ok",
    CANCELLED: "cancelled",
    UNKNOWN: "unknown",
    INVALID_ARGUMENT: "invalid-argument",
    DEADLINE_EXCEEDED: "deadline-exceeded",
    NOT_FOUND: "not-found",
    ALREADY_EXISTS: "already-exists",
    PERMISSION_DENIED: "permission-denied",
    RESOURCE_EXHAUSTED: "resource-exhausted",
    FAILED_PRECONDITION: "failed-precondition",
    ABORTED: "aborted",
    OUT_OF_RANGE: "out-of-range",
    UNIMPLEMENTED: "unimplemented",
    INTERNAL: "internal",
    UNAVAILABLE: "unavailable",
    DATA_LOSS: "data-loss",
    UNAUTHENTICATED: "unauthenticated"
} as const;