import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:flutter/material.dart';
import '../../services/authService.dart';
import '../../widgets/customDialog.dart';
import '../../widgets/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  void signIn(context) async {
    Loading(context);
    dynamic result = await _auth.signInWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (result == null) {
      showCustomDialog(context,'error', 'Sign In Error',
          'Make sure your credentials are correct.');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: SlideFadeInPage(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign In',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(
                'Enter phone number or email to sign in and start playing!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Phone / Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: obscureText,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: const Icon(Icons.remove_red_eye))),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50)),
                  onPressed: () => signIn(context),
                  child: const Text('Sign In')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Dont have an account? ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white70)),
                  GestureDetector(
                      onTap: () => widget.toggleView!(),
                      child: Text('Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
