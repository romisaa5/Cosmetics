import 'package:cosmetics/views/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';

class MyCartProductCard extends StatefulWidget {
  const MyCartProductCard({
    super.key,
    required this.onDelete,
    required this.model,
  });

  final ProductsModel model;
  final VoidCallback onDelete;

  @override
  State<MyCartProductCard> createState() => _MyCartProductCardState();
}

class _MyCartProductCardState extends State<MyCartProductCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.model.quantity;
  }

  void addQuantity() {
    setState(() {
      quantity++;
    });
  }

  void removeQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: AppImages(
                    imagePath: widget.model.image,
                    height: 70.h,
                    width: 70.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: const Icon(
                        Icons.delete,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            12.w.pw,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.brandName,
                    style: AppTextStyles.font16SemiBold.copyWith(
                      color: LightAppColors.primary800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  4.h.ph,

                  Text(
                    widget.model.productName,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: LightAppColors.grey700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  8.h.ph,

                  Text(
                    "${widget.model.price.toStringAsFixed(0)} EGP",
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: LightAppColors.primary800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: LightAppColors.grey400),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: removeQuantity,
                    child: Icon(
                      Icons.remove,
                      size: 18,
                      color: LightAppColors.primary800,
                    ),
                  ),

                  10.w.pw,

                  Text(
                    quantity.toString(),
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: LightAppColors.primary800,
                    ),
                  ),
                  10.w.pw,
                  GestureDetector(
                    onTap: addQuantity,
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: LightAppColors.primary800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        14.h.ph,
        Divider(
          thickness: 1,
          color: LightAppColors.grey500.withValues(alpha: .5),
        ),

        14.h.ph,
      ],
    );
  }
}
