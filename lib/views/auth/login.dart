import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_button.dart';
import 'package:cosmetics/core/common/widgets/app_phone_input.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/app_validators.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/auth/forget_password.dart';
import 'package:cosmetics/views/auth/register.dart';
import 'package:cosmetics/views/auth/widgets/auth_switcher_text.dart';
import 'package:cosmetics/views/home/nav_bar.dart';
import 'package:flutter/cupertino.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final phoneController = TextEditingController();
  final passwordContoller = TextEditingController();
  bool isPasswordObscure = true;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordContoller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(12.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        AppImages(imagePath: '/login.png'),
                        Text(
                          'Login Now',
                          style: AppTextStyles.font24Bold.copyWith(
                            color: LightAppColors.grey900,
                          ),
                        ),
                        14.h.ph,
                        Text(
                          'Please enter the details below to continue',
                          style: AppTextStyles.font14Regular.copyWith(
                            color: LightAppColors.grey500,
                          ),
                        ),
                        40.h.ph,
                        AppPhoneInput(phoneController: phoneController),
                        8.h.ph,
                        AppInput(
                          labelText: 'Create your password',
                          controller: passwordContoller,
                          isObscureText: isPasswordObscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordObscure = !isPasswordObscure;
                              });
                            },
                          ),
                          validator: AppValidators.password,
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: Text(
                              'Forget Password ?',
                              style: AppTextStyles.font14Regular.copyWith(
                                color: LightAppColors.secondary800,
                              ),
                            ),
                          ),
                          onPressed: () {
                            AppNavigator.push(context, ForgetPasswordView());
                          },
                        ),
                        AppButton(
                          text: 'Login',
                          width: 270.w,
                          onTap: () {
                            AppNavigator.pushAndRemoveUntil(context, NavBar());
                          },
                        ),
                        Spacer(),
                        AuthSwitcherText(
                          normalText: "Don't have an account? ",
                          actionText: " Sign Up",
                          onTap: () {
                            AppNavigator.push(context, RegisterView());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
