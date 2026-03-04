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
import 'package:cosmetics/features/auth/presentation/screens/login_screen.dart';
import 'package:cosmetics/features/auth/presentation/widgets/auth_switcher_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  final passwordContoller = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
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
                        CustomAppImages(
                          imagePath: AppImages.splashLayer1,
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
                        AppTextFormField(
                          labelText: 'Your Name',
                          validator: AppValidators.name,
                        ),
                        38.h.ph,
                        AppTextFormField(
                          labelText: 'Email',
                          validator: AppValidators.email,
                        ),
                        38.h.ph,
                        CustomPhoneField(phoneController: phoneController),
                        16.h.ph,
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
                        16.h.ph,
                        AppTextFormField(
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
                        CustomButton(
                          text: 'Login',
                          border: 60,
                          width: 270.w,
                          isborder: false,
                        ),
                        Spacer(),
                        AuthSwitcherText(
                          normalText: "Already have an account? ",
                          actionText: "Login",
                          onTap: () {
                            AppNavigator.push(context, LoginScreen());
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
