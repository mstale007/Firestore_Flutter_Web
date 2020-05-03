# Firestore_Flutter_Web
Basics Queries in Firestore with Flutter Web
<ol>
  <li>To get started Create your project in Firebase and get the API keys and other meta-data</li>
  <p></p>
  <li>Next open <strong> web/index.html</strong> and replace the meta-data:</li>
  
  ```
  <script>
    // Your web app's Firebase configuration
    var firebaseConfig = {
      apiKey: "XXX",
      authDomain: "XXX",
      databaseURL: "XXX",
      projectId: "XXX",
      storageBucket: "XXX",
      messagingSenderId: "XXX",
      appId: "XXX",
      measurementId: "XXX"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();
  </script> 
  ```
  
</ol>