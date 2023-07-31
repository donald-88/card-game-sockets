import 'package:flutter/material.dart';

import '../../utils/auth.dart';
import '../../widgets/loading.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  void signUp() async {
    Loading(context);
    dynamic result = await _auth.registerWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (result == null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
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
                'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter your email and password to create an account and start playing',
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
                  onPressed: signUp,
                  child: const Text('Sign Up')),
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
