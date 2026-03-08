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
import 'package:cosmetics/views/auth/login.dart';
import 'package:cosmetics/views/auth/verify_code.dart';
import 'package:cosmetics/views/auth/widgets/auth_switcher_text.dart';
import 'package:cosmetics/views/auth/widgets/success_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final phoneController = TextEditingController();
  final passwordContoller = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordContoller.dispose();
    confirmPasswordController.dispose();
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
                        AppImages(
                          imagePath: '/app_logo.png',
                          height: 52.h,
                          width: 60.w,
                        ),
                        40.h.ph,
                        Text(
                          'Create Account',
                          style: AppTextStyles.font24Bold.copyWith(
                            color: LightAppColors.grey900,
                          ),
                        ),
                        70.h.ph,
                        AppInput(
                          labelText: 'Your Name',
                          validator: AppValidators.name,
                        ),
                        38.h.ph,
                        AppInput(
                          labelText: 'Email',
                          validator: AppValidators.email,
                        ),
                        38.h.ph,
                        AppPhoneInput(
                          phoneController: phoneController,
                          validator: AppValidators.phone,
                        ),
                        16.h.ph,
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
                        16.h.ph,
                        AppInput(
                          labelText: 'Confirm password',
                          controller: confirmPasswordController,
                          isObscureText: isConfirmPasswordObscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordObscure =
                                    !isConfirmPasswordObscure;
                              });
                            },
                          ),
                          validator: (value) => AppValidators.confirmPassword(
                            value,
                            passwordContoller.text,
                          ),
                        ),
                        16.h.ph,
                        AppButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              AppNavigator.push(
                                context,
                                VerifyCodeView(
                                  contact: 'your email amramer522@gmail.com',
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AccountActivatedDialog(
                                        title: 'Account Activated!',
                                        subTitle:
                                            'Congratulations! Your account has been successfully activated',
                                        buttonTitle: 'Go to home',
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                          text: 'Next',
                          width: 270.w,
                        ),
                        Spacer(),
                        AuthSwitcherText(
                          normalText: "Already have an account? ",
                          actionText: "Login",
                          onTap: () {
                            AppNavigator.push(context, LoginView());
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
