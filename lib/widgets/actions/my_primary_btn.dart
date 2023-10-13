import 'package:flutter/material.dart';

/// write me primary button
class MyPrimaryBtn extends StatelessWidget {
  const MyPrimaryBtn({
    super.key,
    this.onPressed,
    required this.label,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(label),
          ),
        ),
      ),
    );
  }
}
