import 'package:cosmetics/core/common/widgets/custom_app_images.dart';
import 'package:cosmetics/core/common/widgets/custom_button.dart';
import 'package:cosmetics/core/common/widgets/custom_phone_field.dart';
import 'package:cosmetics/core/common/widgets/custom_text_form_field.dart';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/app_validators.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/app_images.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/features/auth/presentation/screens/register_screen.dart';
import 'package:cosmetics/features/auth/presentation/widgets/auth_switcher_text.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordContoller = TextEditingController();
  bool isPasswordObscure = true;
  final formKey = GlobalKey<FormState>();
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
                        CustomAppImages(imagePath: AppImages.loginImg),
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
                        CustomPhoneField(phoneController: phoneController),
                        8.h.ph,
                        AppTextFormField(
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
                          onPressed: () {},
                        ),
                        CustomButton(
                          text: 'Login',
                          border: 60,
                          width: 270.w,
                          isborder: false,
                        ),
                        Spacer(),
                        AuthSwitcherText(
                          normalText: "Don't have an account? ",
                          actionText: " Sign Up",
                          onTap: () {
                            AppNavigator.push(context, RegisterScreen());
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
