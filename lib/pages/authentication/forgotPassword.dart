import 'package:card_game_sockets/widgets/customDialog.dart';
import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      showCustomDialog(context, 'error', e.code.toString(), e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: SizedBox(
            width: 300,
            child: SlideFadeInPage(
              crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('Reset Password', style: width > 375
                      ? Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
            const Text(
                'Enter your email address and we will send you a link to reset your password.'),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Phone / Email',
                hintStyle: width > 375
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey.shade500)
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(400, 50)),
                onPressed: () {
                  passwordReset();
                },
                child: Text('Reset Password',
                    style: width > 375
                        ? Theme.of(context).textTheme.labelLarge
                        : Theme.of(context).textTheme.labelMedium)),
                  ],
                ),
          )),
    );
  }
}
