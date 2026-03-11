import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_button.dart';
import 'package:cosmetics/core/common/widgets/app_phone_input.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/app_validators.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/auth/login.dart';
import 'package:cosmetics/views/auth/verify_code.dart';
import 'package:cosmetics/views/auth/widgets/auth_switcher_text.dart';
import 'package:cosmetics/views/auth/widgets/success_dialog.dart';
import 'package:dio/dio.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordContoller.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final request = _RegisterRequest(
        username: nameController.text,
        countryCode: "+20",
        phoneNumber: phoneController.text,
        email: emailController.text,
        password: passwordContoller.text,
      );

      final response = await DioHelper.post(
        "/api/Auth/register",
        data: request.toJson(),
      );

      final message = response.data["message"];

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));

      AppNavigator.push(
        context,
        VerifyCodeView(
          contact: 'your email ${emailController.text}',
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
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ?? "Something went wrong";

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
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
                          controller: nameController,
                        ),
                        38.h.ph,
                        AppInput(
                          labelText: 'Email',
                          validator: AppValidators.email,
                          controller: emailController,
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
                              register();
                            }
                          },
                          text: isLoading ? 'Loading....' : 'Next',
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

class _RegisterRequest {
  final String username;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String password;

  _RegisterRequest({
    required this.username,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };
  }
}
