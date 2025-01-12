const admin = require('C:/Users/LENOVO/Documents/GitHub/chat app project/chatapp-83e16-firebase-adminsdk-2xkjz-13fa00574c.json'); // تأكد من مسار ملف التهيئة الخاص بك
const firebase = require('../Firebase/firebase');
require('firebase/auth');

firebase.initializeApp({
  apiKey: "AIzaSyBcHEwO1ebQs7ZW0aeeNwtUwEKHSvAfFYA", // المفتاح الخاص بك
  authDomain: "chatapp-83e16.firebaseapp.com", // النطاق الخاص بك
});

const googleAuthProvider = new firebase.auth.GoogleAuthProvider();

const loginWithGoogle = async (idToken) => {
  try {
    const credential = await firebase.auth().signInWithCredential(googleAuthProvider.credential(idToken));
    const user = credential.user;
    // هنا يمكنك التعامل مع المستخدم (حفظه في قاعدة البيانات، إلخ.)
    return user;
  } catch (error) {
    console.error('Error logging in with Google:', error);
    throw new Error(error.message);
  }
};

module.exports = { loginWithGoogle };
