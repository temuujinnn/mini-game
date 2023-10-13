import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets/uis/uis.dart';
import '../auth.dart';
import '../widgets/register_form.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isRegister = false;

  switchForm() {
    setState(() {
      isRegister = !isRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16.0),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(10, 10), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(4.screenWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isRegister ? const RegisterForm() : const SignInForm(),
                  isRegister
                      ? TextButton(
                          onPressed: switchForm,
                          child: const Text('Already have an account? Sign in'),
                        )
                      : TextButton(
                          onPressed: switchForm,
                          child: const Text('Create an account'),
                        ),
                ],
              ),
            ),
          ),
          context.watch<AuthController>().status == AuthStatus.loading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
