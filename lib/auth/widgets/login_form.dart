import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets/widgets.dart';
import '../auth.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'flutterwithdokind@gmail.com');
  final _passwordController = TextEditingController(text: 'Nogame123');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyInput(
            controller: _emailController,
            inputFormatters: const [
              /// email input formatter
            ],
            label: 'Email',
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          MyInput(
            controller: _passwordController,
            maxLines: 1,
            inputFormatters: const [
              /// email input formatter
            ],
            label: 'Password',
            obscureText: true,
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          SizedBox(height: 3.sh),
          MyPrimaryBtn(
            label: 'Login',
            isLoading: context
                .select((AuthController c) => c.status == AuthStatus.loading),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await context.read<AuthController>().signinWithEmail(
                      _emailController.text,
                      _passwordController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
