import 'package:cosmetics/core/common/widgets/app_button.dart';
import 'package:cosmetics/core/common/widgets/app_phone_input.dart';
import 'package:cosmetics/core/helpers/app_navigator.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/auth/create_new_password.dart';
import 'package:cosmetics/views/auth/verify_code.dart';
import 'package:cosmetics/views/auth/widgets/auth_header_section.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),

                  AuthHeaderSection(
                    title: 'Forget Password',
                    subTitle:
                        'Please enter your phone number below to recovery your password.',
                  ),
                  40.h.ph,
                  AppPhoneInput(phoneController: phoneController),
                  55.h.ph,
                  AppButton(
                    onTap: () {
                      AppNavigator.push(
                        context,
                        VerifyCodeView(
                          contact: '+20 1022658997',
                          onTap: () {
                            AppNavigator.push(context, CreateNewPasswordView());
                          },
                        ),
                      );
                    },
                    text: 'Next',
                    width: 270.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
