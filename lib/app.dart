import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_batch_1/content.dart';
import 'package:firebase_auth_batch_1/login_form.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Batch 1'),
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  final isLoggedIn = snapshot.data?.uid != null;
                  return isLoggedIn ? const Content() : const LoginForm();
                }),
          ),
        ),
      ),
    );
  }
}
