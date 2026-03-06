import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/views/products_model.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/widgets/my_cart_product_card.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProducts = [
      ProductsModel(
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
        brandName: 'Note Cosmetics',
        productName: 'Ultra rich mascara for lashes',
        price: 350,
        quantity: 3,
      ),
      ProductsModel(
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
        brandName: 'Note Cosmetics',
        productName: 'Ultra rich mascara for lashes',
        price: 350,
        quantity: 3,
      ),
      ProductsModel(
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
        brandName: 'Note Cosmetics',
        productName: 'Ultra rich mascara for lashes',
        price: 350,
        quantity: 3,
      ),
      ProductsModel(
        image:
            'https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg',
        brandName: 'Note Cosmetics',
        productName: 'Ultra rich mascara for lashes',
        price: 350,
        quantity: 3,
      ),
    ];
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Column(
        children: [
          12.h.ph,
          Row(
            children: [
              const Spacer(),
              Text(
                'My Cart',
                style: AppTextStyles.font24Bold.copyWith(
                  color: LightAppColors.primary800,
                ),
              ),
              const Spacer(),
              AppImages(imagePath: '/add_cart.svg'),
            ],
          ),
          24.h.ph,
          Expanded(
            child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return MyCartProductCard(model: product, onDelete: () {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
