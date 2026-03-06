import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/views/categories_model.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoriesModel(
        title: 'Bundles',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      CategoriesModel(
        title: 'Perfumes',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      CategoriesModel(
        title: 'Makeup',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      CategoriesModel(
        title: 'Skin Care',
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
      ),
      CategoriesModel(
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
