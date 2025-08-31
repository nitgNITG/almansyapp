import 'package:flutter/widgets.dart';

bool isTablet(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= 600 && width < 1024;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1024;
}

Size getResponsiveSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 1024) {
    // Desktop
    return const Size(1440, 1024);
  } else if (width >= 600) {
    // Tablet
    return const Size(768, 1024);
  } else {
    // Mobile
    return const Size(393, 852);
  }
}
