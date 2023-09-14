import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/slideFadeInPage.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SlideFadeInPage(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.orangeAccent),
                      padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    radius: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(auth.currentUser?.photoURL ??
                          'assets/avatars/placeholder.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(auth.currentUser!.displayName.toString(), style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 32),
                TextButton(
                    onPressed: () {},
                    child: Text("U S E R N A M E",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("A V A T A R",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("R E C O R D",
                        style: Theme.of(context).textTheme.headlineMedium)),
                 const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("F R I E N D S",
                        style: Theme.of(context).textTheme.headlineMedium)),
              ],
            ),
          ),
          Positioned(
              top: 32,
              right: 32,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 32),
              )),
        ],
      ),
    );
  }
}
