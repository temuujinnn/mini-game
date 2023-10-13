import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Column(
      children: [
        Text(
          title,
          style: deviceType == DeviceScreenType.desktop
              ? Theme.of(context).textTheme.displayMedium
              : Theme.of(context).textTheme.displaySmall,
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }
}
