import 'package:flutter/material.dart';
import '../../services/authService.dart';
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

  void signIn() async {
    Loading(context);
    dynamic result = await _auth.signInWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (result == null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter your email and password to sign in and start playing!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50)),
                  onPressed: signIn,
                  child: const Text('Sign In')),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Dont have an account? '),
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
