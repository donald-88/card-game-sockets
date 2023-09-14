import 'package:card_game_sockets/providers/themeProvider.dart';
import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SlideFadeInPage(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("H O M E",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 20),
                TextButton(
                  child: Text("R E C O R D",
                      style: width > 375
                          ? Theme.of(context).textTheme.headlineLarge
                          : Theme.of(context).textTheme.headlineSmall),
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("L E A D E R B O A R D",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child: Text("W I T H D R A W A L S",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Text("L O G O U T",
                        style: width > 375
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineSmall))
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
          Positioned(
              top: 32,
              left: 32,
              child: IconButton(
                onPressed: () => context.read<ThemeProvider>().changeTheme(),
                icon: Icon(
                    context.read<ThemeProvider>().isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    size: 32),
              ))
        ],
      ),
    );
  }
}
