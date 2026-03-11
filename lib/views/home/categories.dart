import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/core/network/dio_helper.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<_Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await DioHelper.get("/api/Categories");
      final data = response.data as List;
      setState(() {
        categories = data.map((json) => _Category.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Column(
        children: [
          12.h.ph,
          Align(
            alignment: Alignment.center,
            child: Text(
              'Categories',
              style: AppTextStyles.font24Bold.copyWith(
                color: LightAppColors.primary800,
              ),
            ),
          ),
          24.h.ph,
          AppInput(
            labelText: 'Search',
            suffixIcon: SizedBox(
              height: 24.h,
              width: 24.w,
              child: Center(child: AppImages(imagePath: '/search.svg')),
            ),
          ),
          30.h.ph,
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        title: category.title,
                        imageUrl: category.imageUrl,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppImages(
                imagePath: imageUrl,
                height: 60.h,
                width: 60.w,
                fit: BoxFit.cover,
              ),
            ),
            12.w.pw,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font16SemiBold.copyWith(
                  color: LightAppColors.primary800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AppImages(imagePath: '/forward.svg'),
          ],
        ),
        12.h.ph,
        Divider(
          thickness: 1,
          color: LightAppColors.grey500.withValues(alpha: .5),
        ),
        12.h.ph,
      ],
    );
  }
}

class _Category {
  final int id;
  final String title;
  final String imageUrl;

  _Category({required this.id, required this.title, required this.imageUrl});

  factory _Category.fromJson(Map<String, dynamic> json) {
    return _Category(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "imageUrl": imageUrl};
  }
}
