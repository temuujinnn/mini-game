import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets/widgets.dart';
import '../auth.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'registerForm');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

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
              } else if (!_isValidEmail(p0)) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          MyInput(
            controller: _phoneController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            label: 'Phone',
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Phone is required';
              } else if (p0.length < 8) {
                return 'Phone must be at least 8 characters long';
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
              } else if (p0.length < 8) {
                return 'Password must be at least 8 characters long';
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
                try {
                  await context.read<AuthController>().createUser(
                        name: '+976${_phoneController.text}',
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression pattern for email validation
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
