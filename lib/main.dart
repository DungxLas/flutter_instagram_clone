import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_instagram_clone/firebase_options.dart';
import 'package:flutter_instagram_clone/resonsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/resonsive/responsive_layout.dart';
import 'package:flutter_instagram_clone/resonsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';

import 'package:flutter_instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDz7AKNpfNNRQPhhl-hF48-G3HUikjF14Q",
        //authDomain: "flutter-instagram-clone-227f8.firebaseapp.com",
        projectId: "flutter-instagram-clone-227f8",
        storageBucket: "flutter-instagram-clone-227f8.appspot.com",
        messagingSenderId: "868142073986",
        appId: "1:868142073986:web:184822badc6473da414c9b",
        //measurementId: "G-6S591ZVQ5D",
      ),
    );
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
