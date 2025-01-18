// sendNotification.js
const admin = require("firebase-admin");
const serviceAccount = require("C:/Users/LENOVO/Documents/projects keys/nodejs_chat/chatapp-83e16-firebase-adminsdk-2xkjz-4cbd573e6e.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});


const sendNotification = async (deviceToken, title, body) => {
    // إذا كانت الرسالة مشفرة بصيغة JSON، نقوم بتحليلها
    let messageBody = body;
    try {
        const parsedMessage = JSON.parse(body);  // محاولة فك تشفير الرسالة
        messageBody = parsedMessage.msg || body;  // إذا كانت موجودة، نستخدم النص الفعلي للرسالة
    } catch (error) {
        console.log("Error parsing message JSON:", error);
    }

    const message = {
        notification: {
            title: title,
            body: messageBody,  // استخدام الرسالة الحقيقية
        },
        token: deviceToken,
    };

    try {
        const response = await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
    } catch (error) {
        console.log("Error sending message:", error);
    }
};

module.exports = sendNotification;
