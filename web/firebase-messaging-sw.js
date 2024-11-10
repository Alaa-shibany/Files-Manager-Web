importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyAAIBojjbALrA0QcbWuNU7c6mHbdy6noiU",
  authDomain: "flutter-1cda7.firebaseapp.com",
  databaseURL: "https://flutter-1cda7-default-rtdb.firebaseio.com",
  projectId: "flutter-1cda7",
  storageBucket: "flutter-1cda7.firebasestorage.app",
  messagingSenderId: "838693518963",
  appId: "1:838693518963:web:0f5a0eee9a2a64803eb406",
  measurementId: "G-JY8BYQKVCK"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("Received background message: ", message);

  const notificationTitle = message.notification?.title || "Notification";
  const notificationOptions = {
    body: message.notification?.body || "You have a new message.",
    icon: "assets/images/folder.png", // Optional: path to your icon
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
