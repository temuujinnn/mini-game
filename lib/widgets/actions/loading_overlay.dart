import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth.dart';

/// Widget that displays a loading indicator overlay
class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthController, bool>(
        (AuthController? value) => value?.isLoading ?? false);
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/loading.gif'),
                const Text('Loading...'),
              ],
            ),
          ),
      ],
    );
  }
}
