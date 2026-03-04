import 'dart:async';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/utils/app_images.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/features/onboarding/presentation/screens/onboading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      AppNavigator.pushAndRemoveUntil(context, OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.splashLayer1, height: 200.h, width: 200.w),
            16.h.ph,
            Image.asset(AppImages.splashLayer2, width: 120.w, height: 46.h),
          ],
        ),
      ),
    );
  }
}
