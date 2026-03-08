import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      _Categories(
        title: 'Bundles',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      _Categories(
        title: 'Perfumes',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      _Categories(
        title: 'Makeup',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      _Categories(
        title: 'Skin Care',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      _Categories(
        title: 'Gifts',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
    ];
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
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(model: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Categories {
  final String title;
  final String image;

  _Categories({required this.title, required this.image});
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.model});

  final _Categories model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppImages(
                imagePath: model.image,
                height: 60.h,
                width: 60.w,
                fit: BoxFit.cover,
              ),
            ),
            12.w.pw,
            Expanded(
              child: Text(
                model.title,
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
