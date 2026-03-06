import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/views/categories_model.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.model});

  final CategoriesModel model;

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

            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: LightAppColors.primary800,
            ),
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
