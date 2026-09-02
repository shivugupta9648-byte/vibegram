import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBgKFIyXTumq-edRfxqm0b36_bWR3oRokM",
        appId: "1:905389659878:web:e55efe4d26d590cb110d27",
        messagingSenderId: "905389659878",
        projectId: "vibegram-f1c94",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  runApp(const VibeGramApp());
}

class VibeGramApp extends StatelessWidget {
  const VibeGramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sriyu build'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to VibeGram Feed!'),
      ),
    );
  }
}