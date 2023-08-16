import 'package:card_game_sockets/widgets/errorDialog.dart';
import 'package:flutter/material.dart';
import '../../services/authService.dart';
import '../../widgets/loading.dart';

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
      if (emailController.text.startsWith('+265') || emailController.text.startsWith("0")) {
        await _auth.registerWithPhoneNumber(
            emailController.text, passwordController.text, context);
      } else {
        await _auth.registerWithEmailAndPassword(usernameController.text,
            emailController.text, passwordController.text);
      }
    } else {
      showErrorDialog('Password Length Error',
          "Make sure your password has 6 or more characters", context);
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
                'Enter your phone or email and password to create an account and start playing',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Phone / Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50)),
                  onPressed: () => signUp(context),
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
