import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// write wrapper extention for widget
extension WrapPager on Widget {
  Widget withPadding(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Padding(
        padding: deviceType == DeviceScreenType.desktop
            ? const EdgeInsets.all(16)
            : const EdgeInsets.all(8),
        child: this);
  }
}
