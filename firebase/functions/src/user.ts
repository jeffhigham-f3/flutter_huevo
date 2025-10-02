import {logger} from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";
import {getAuth, UserRecord} from "firebase-admin/auth";
import {firestore} from "firebase-admin";
import {CallableRequest} from "firebase-functions/v2/https";
import {sendNotificationToUser} from "./notification";
import {isEnumArray, isNonEmptyString} from "./common";
import FieldValue = firestore.FieldValue;
import DocumentData = firestore.DocumentData;

enum UserGoal {
    haveFun = "have_fun",
    learnFlutterAndFirebase = "learn_flutter_and_firebase",
    buildAppPortfolio = "build_app_portfolio",
    getJob = "get_job",
}

// Creates a new /users Firestore document when a Firebase Auth user is created.
export const onUserCreated = async (userRecord: UserRecord) => {
    const user = {
        email: userRecord.email,
        name: userRecord.displayName,
        imageUrl: userRecord.photoURL,
        createdAt: FieldValue.serverTimestamp(),
    };

    await getFirestore().collection("users").doc(userRecord.uid).set(user);
    logger.info("User created", user);
};

export const setUserPhoto = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const imageUrl = request.data.imageUrl;
    if (!isNonEmptyString(imageUrl)) {
        return {
            status: 400,
            error: "no imageUrl",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        imageUrl: imageUrl,
    });

    return {
        status: 200,
        data: {},
    };
};

export const addUserFcmToken = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const token = request.data.token;
    if (!isNonEmptyString(token)) {
        return {
            status: 400,
            error: "no token",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        fcmTokens: FieldValue.arrayUnion(token),
    });

    return {
        status: 200,
        data: {},
    };
};

export const removeUserFcmToken = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const token = request.data.token;
    if (!isNonEmptyString(token)) {
        return {
            status: 400,
            error: "no token",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        fcmTokens: FieldValue.arrayRemove(token),
    });

    return {
        status: 200,
        data: {},
    };
};

export const sendUserNotification = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const error = await sendNotificationToUser({
        userId: userId,
        title: "Remote Notification",
        body: "This is a remote notification. Click to open Feedback Page.",
        data: {
            type: "feedback",
        },
    });

    if (error) {
        return error;
    }

    return {
        status: 200,
        data: {},
    };
};

export const deleteAccount = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    logger.log(`User ${userId} delete account started...`);
    const db = getFirestore();
    const batch = db.batch();

    // Delete users document
    batch.delete(db.collection("users").doc(userId));
    logger.log(`Deleting /users/${userId} doc...`);

    // Delete feedbackMessages documents
    const feedbackSnapshot = await db.collection("feedbackMessages")
        .where("userId", "==", userId).get();
    feedbackSnapshot.forEach((doc) => batch.delete(doc.ref));
    logger.log(`Deleting ${feedbackSnapshot.size} feedbackMessages docs...`);

    // Delete articles
    const articlesSnapshot = await db.collection("articles")
        .where("authorId", "==", userId).get();
    articlesSnapshot.forEach((doc) => batch.delete(doc.ref));
    logger.log(`Deleting ${articlesSnapshot.size} articles docs...`);

    await batch.commit();
    logger.log(`User ${userId} Firebase documents deleted.`);

    // Delete auth user
    try {
        await getAuth().deleteUser(userId);
        logger.log(`User ${userId} auth record deleted.`);
    } catch (error) {
        logger.error(`Failed to delete auth user ${userId}:`, error);
    }

    return {
        status: 200,
        data: {},
    };
};


export const userSetTimezone = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const timezone = request.data.timezone;
    if (!isNonEmptyString(timezone)) {
        return {
            status: 400,
            error: "no timezone",
        };
    }

    const userRef = getFirestore().collection("users").doc(userId);
    return getFirestore().runTransaction(async (t) => {
        const userDoc = await t.get(userRef);
        const user = userDoc.data();
        if (!user) {
            return {
                status: 404,
                error: "user not found",
            };
        }

        const currentTimezone = user.timezone;
        if (currentTimezone === timezone) {
            logger.log(`User ${userId} timezone is already set to ${timezone}`);
            return {
                status: 200,
                data: {},
            };
        }

        t.update(userRef, {timezone: timezone});

        return {
            status: 200,
            data: {},
        };
    });
};

export const userSetOnboardingCompleted = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const goals = request.data.goals;
    if (!isEnumArray(goals, UserGoal)) {
        return {
            status: 400,
            error: "invalid goals",
        };
    }

    const userData: DocumentData = {
        isOnboardingCompleted: true,
        goals: goals,
    };

    await getFirestore().collection("users").doc(userId).set(
        userData,
        {merge: true},
    );

    return {
        status: 200,
        data: {},
    };
};
