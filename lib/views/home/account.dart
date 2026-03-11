import 'package:cosmetics/core/common/widgets/app_button.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/edit_account.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<AccountView> {
  UserProfile? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await DioHelper.get("/api/Auth/profile");
      setState(() {
        userProfile = UserProfile.fromJson(response.data);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load profile")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    if (userProfile == null)
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(child: Text("No profile data")),
      );

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                userProfile!.profilePhotoUrl,
                height: 100.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            12.h.ph,
            Text(userProfile!.username, style: TextStyle(fontSize: 20.sp)),
            Text(userProfile!.email),
            Text(userProfile!.phoneNumber),
            Text(userProfile!.countryCode),
            Text(userProfile!.role),
            Spacer(),
            AppButton(
              text: "Edit Profile",
              width: 200.w,
              onTap: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileView(profile: userProfile!),
                  ),
                );
                if (updated != null) {
                  setState(() {
                    userProfile = updated;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  final int id;
  String username;
  String email;
  final String role;
  final String phoneNumber;
  final String countryCode;
  String profilePhotoUrl;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.countryCode,
    required this.profilePhotoUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      role: json["role"],
      phoneNumber: json["phoneNumber"],
      countryCode: json["countryCode"],
      profilePhotoUrl: json["profilePhotoUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "profilePhotoUrl": profilePhotoUrl,
    };
  }
}
