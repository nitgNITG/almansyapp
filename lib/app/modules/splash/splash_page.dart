import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step/app/modules/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = SplashController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.navigate(context);
    });
    Future.wait([
      controller.getDeviceData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/splash/UP1.svg'),
            ],
          ),
          // const Spacer(),
          Flexible(
            child: Image.asset('assets/images/splash/icon.png').animate().scale(
                  begin: const Offset(0, 0), // يبدأ من حجم صغير جدًا
                  end: const Offset(1, 1), // ينتهي بالحجم الطبيعي
                  duration: const Duration(milliseconds: 2000), // مدة التأثير
                  curve: Curves.easeOut,
                ),
          ),
          // const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/splash/DOWN.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
