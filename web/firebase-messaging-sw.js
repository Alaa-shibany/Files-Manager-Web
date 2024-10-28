  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyAAIBojjbALrA0QcbWuNU7c6mHbdy6noiU",
    authDomain: "flutter-1cda7.firebaseapp.com",
    databaseURL: "https://flutter-1cda7-default-rtdb.firebaseio.com",
    projectId: "flutter-1cda7",
    storageBucket: "flutter-1cda7.appspot.com",
    messagingSenderId: "838693518963",
    appId: "1:838693518963:web:0f5a0eee9a2a64803eb406",
    measurementId: "G-JY8BYQKVCK"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
  const messaging = firebase.messaging();

// Optional:
    messaging.onBackgroundMessage((message) => {
      console.log("onBackgroundMessage", message);
    });
