import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/my_cart.dart';
import 'package:cosmetics/views/home/categories.dart';
import 'package:cosmetics/views/home/home.dart';
import 'package:cosmetics/views/home/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final _pages = [
    const HomePage(),
    const CategoriesPage(),
    const MyCartPage(),
    const ProfilePage(),
  ];

  Widget buildSvg(String path, bool isSelected) {
    return AppImages(
      imagePath: path,
      width: 20.w,
      height: 20.h,
      colorFilter: ColorFilter.mode(
        isSelected ? LightAppColors.secondary800 : LightAppColors.grey600,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: LightAppColors.grey300,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: GNav(
          gap: 8,
          activeColor: LightAppColors.secondary900,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          duration: const Duration(milliseconds: 400),
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.circle,
              leading: buildSvg('/home.svg', _selectedIndex == 0),
            ),
            GButton(
              icon: Icons.circle,
              leading: buildSvg('/categories.svg', _selectedIndex == 1),
            ),
            GButton(
              icon: Icons.circle,
              leading: buildSvg('/my_cart.svg', _selectedIndex == 2),
            ),
            GButton(
              icon: Icons.circle,
              leading: buildSvg('/profile.svg', _selectedIndex == 3),
            ),
          ],
        ),
      ),
    );
  }
}
