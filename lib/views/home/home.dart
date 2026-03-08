import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/widgets/top_rated_product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.h.ph,
            AppInput(
              labelText: 'Search',
              suffixIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Center(child: AppImages(imagePath: '/search.svg')),
              ),
            ),

            12.h.ph,
            AppImages(imagePath: '/poster.png'),
            12.h.ph,
            Text(
              'Top rated products',
              style: AppTextStyles.font16Bold.copyWith(
                color: LightAppColors.primary800,
              ),
            ),
            14.h.ph,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return TopRatedProductCard(
                  imageUrl:
                      'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
                  title: "Face tint / lip tint",
                  price: "\$120",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
