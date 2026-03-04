import 'package:cosmetics/core/common/widgets/custom_button.dart';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/app_images.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/features/auth/presentation/screens/login_screen.dart';
import 'package:cosmetics/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/cupertino.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: AppImages.firstOnBoarding,
      title: "WELCOME!",
      description:
          "Makeup has the power to transform your mood and empowers you to be a more confident person.",
    ),
    OnboardingModel(
      image: AppImages.secondOnBoarding,
      title: "SEARCH & PICK",
      description:
          "We have dedicated set of products and routines hand picked for every skin type.",
    ),
    OnboardingModel(
      image: AppImages.notificationImage,
      title: "PUSH NOTIFICATIONS",
      description: "Allow notifications for new makeup & cosmetics offers.",
    ),
  ];

  void nextPage(BuildContext context) {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      AppNavigator.pushAndRemoveUntil(context, LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(onPressed: () {}, child: const Text("Skip")),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: 1),
                        Image.asset(page.image, height: 260.h),
                        24.h.ph,
                        Text(
                          page.title,
                          style: AppTextStyles.font16Bold.copyWith(
                            color: LightAppColors.grey900,
                          ),
                        ),
                        10.h.ph,
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font16SemiBold.copyWith(
                            color: LightAppColors.grey600,
                          ),
                        ),
                        30.h.ph,
                        currentIndex == pages.length - 1
                            ? CustomButton(
                                text: 'let’s start!',
                                border: 60,
                                color: LightAppColors.primary800,
                                onTap: () => nextPage(context),
                              )
                            : CupertinoButton(
                                onPressed: () => nextPage(context),
                                child: Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: LightAppColors.primary800,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: LightAppColors.white,
                                  ),
                                ),
                              ),
                        Spacer(flex: 2),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
