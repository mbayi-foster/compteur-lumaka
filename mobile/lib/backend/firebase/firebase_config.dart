import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB1q62M6XTbJG-knMluP70f1-rDK8UvZyE",
            authDomain: "compteur-lumaka.firebaseapp.com",
            projectId: "compteur-lumaka",
            storageBucket: "compteur-lumaka.firebasestorage.app",
            messagingSenderId: "827611641265",
            appId: "1:827611641265:web:809cf42e237b0070773990",
            measurementId: "G-TWRDMY9TFD"));
  } else {
    await Firebase.initializeApp();
  }
}
