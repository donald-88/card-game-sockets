import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("H O M E",
                        style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 20),
                Text("P R O F I L E",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("Y O U R  R E C O R D",
                        style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("W I T H D R A W S",
                        style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Text("L O G O U T",
                        style: Theme.of(context).textTheme.headlineMedium))
              ],
            ),
          ),
          Positioned(
              top: 32,
              right: 32,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 32),
              ))
        ],
      ),
    );
  }
}
