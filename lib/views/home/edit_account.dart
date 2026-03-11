import 'package:cosmetics/core/common/widgets/app_button.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/account.dart';
import '../../core/common/widgets/app_input.dart';

class EditProfileView extends StatefulWidget {
  final UserProfile profile;
  const EditProfileView({super.key, required this.profile});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController photoController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.profile.username);
    emailController = TextEditingController(text: widget.profile.email);
    photoController = TextEditingController(
      text: widget.profile.profilePhotoUrl,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    photoController.dispose();
    super.dispose();
  }

  Future<void> updateProfile() async {
    setState(() => isLoading = true);
    try {
      final request = _UpdateProfileRequest(
        username: usernameController.text,
        email: emailController.text,
        profilePhotoUrl: photoController.text,
      );

      final response = await DioHelper.put(
        "/api/Auth/profile",
        data: request.toJson(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data["message"] ?? "Updated successfully"),
        ),
      );

      final updatedProfile = UserProfile(
        id: widget.profile.id,
        username: usernameController.text,
        email: emailController.text,
        role: widget.profile.role,
        phoneNumber: widget.profile.phoneNumber,
        countryCode: widget.profile.countryCode,
        profilePhotoUrl: photoController.text,
      );

      Navigator.pop(context, updatedProfile);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to update profile")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            AppInput(labelText: "Username", controller: usernameController),
            12.h.ph,
            AppInput(labelText: "Email", controller: emailController),
            12.h.ph,
            AppInput(
              labelText: "Profile Photo URL",
              controller: photoController,
            ),
            30.h.ph,
            AppButton(
              text: isLoading ? "Updating..." : "Update Profile",
              width: 200.w,
              onTap: isLoading ? null : updateProfile,
            ),
          ],
        ),
      ),
    );
  }
}

class _UpdateProfileRequest {
  String username;
  String email;
  String profilePhotoUrl;

  _UpdateProfileRequest({
    required this.username,
    required this.email,
    required this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "profilePhotoUrl": profilePhotoUrl,
    };
  }
}
