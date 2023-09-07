import 'package:card_game_sockets/widgets/loading.dart';
import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:flutter/material.dart';
import '../../services/authService.dart';
import '../../widgets/customDialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  void signUp(context) async {
    if (passwordController.text.length > 5) {
      Loading(context);
      if (emailController.text.startsWith('+265') ||
          emailController.text.startsWith("0")) {
        await _auth.registerWithPhoneNumber(
            emailController.text, passwordController.text, context);
        Navigator.pop(context);
      } else {
        await _auth.registerWithEmailAndPassword(usernameController.text,
            emailController.text, passwordController.text);
      }
    } else {
      showCustomDialog(context, 'error', 'Password Length Error',
          "Make sure your password has 6 or more characters");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: SlideFadeInPage(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: width > 375
                    ? Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                  'Enter your phone or email and password to create an account and start playing',
                  style: width > 375
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyMedium),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
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
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
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
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
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
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50)),
                  onPressed: () => signUp(context),
                  child: Text('Sign Up',
                      style: width > 375
                          ? Theme.of(context).textTheme.labelLarge
                          : Theme.of(context).textTheme.labelMedium)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () => widget.toggleView!(),
                    child: Text('Sign In',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
