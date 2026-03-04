import 'package:cosmetics/core/common/widgets/custom_text_form_field.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:flutter/cupertino.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController phoneController;
  final Function(String completePhone)? onChanged;

  const CustomPhoneField({
    super.key,
    required this.phoneController,
    this.onChanged,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String countryCode = "+20";

  void _updateFullNumber() {
    final fullNumber = "$countryCode${widget.phoneController.text}";
    widget.onChanged?.call(fullNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                setState(() {
                  countryCode = "+${country.phoneCode}";
                });
                _updateFullNumber();
              },
              countryListTheme: CountryListThemeData(
                flagSize: 24.sp,
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: LightAppColors.grey900,
                ),
                bottomSheetHeight: 500.h,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                searchTextStyle: TextStyle(
                  fontSize: 16.sp,
                  color: LightAppColors.grey600,
                ),
                inputDecoration: InputDecoration(
                  hintText: 'Search country',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: LightAppColors.grey500,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: LightAppColors.grey500,
                  ),
                  filled: true,
                  fillColor: LightAppColors.background,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: LightAppColors.background,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: LightAppColors.grey500),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  countryCode,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: LightAppColors.grey600,
                  ),
                ),
                5.w.pw,
                Icon(
                  CupertinoIcons.chevron_down,
                  size: 16.sp,
                  color: LightAppColors.grey600,
                ),
              ],
            ),
          ),
        ),
        10.w.pw,
        Expanded(
          child: AppTextFormField(
            onChanged: (_) => _updateFullNumber(),
            labelText: 'Phone Number',
            controller: widget.phoneController,
          ),
        ),
      ],
    );
  }
}
