import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '/core.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.items,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.selectedValue,
    this.isRequired = false,
    this.dropdownHeight = 100.0,
  }) : super(key: key);

  final FutureOr<List<String>> Function(String, LoadProps?)?
      items; // Function to load items dynamically
  final String labelText;
  final String? hintText;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final bool isRequired;
  final double dropdownHeight;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: TextStyle(
                fontSize: AppSizes.fontSmalle,
                fontWeight: FontWeight.w500,
                // color: AppColor.secondarytextcolor,
                color: AppColor.secondarytextcolor,
                fontFamily: 'Inter',
              ),
            ),
            if (isRequired) // Show asterisk only if isRequired is true
              Text(
                '*',
                style: TextStyle(
                  fontSize: AppSizes.fontSmalle,
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarytextcolor, // Use red color for the asterisk
                  fontFamily: 'Inter',
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        DropdownSearch<String>(
          selectedItem: selectedValue,
          onChanged: onChanged,
          items: items,
          popupProps: PopupProps.menu(
            constraints: BoxConstraints(maxHeight: dropdownHeight),
            containerBuilder: (ctx, popupWidget) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: popupWidget,
              );
            },
          ),
          decoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: AppSizes.fontSmalle,
              fontWeight: FontWeight.w500,
              color: AppColor.primarytextcolor,
              fontFamily: 'Inter',
            ),
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.sp),
                borderSide: const BorderSide(
                    width: 1, color: AppColor.textfieldbordercolor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.sp),
                borderSide:
                    const BorderSide(width: 1, color: AppColor.hintcolor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.sp),
                borderSide: const BorderSide(
                    width: 1, color: AppColor.textfieldbordercolor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.sp),
                borderSide: BorderSide(width: 1.w, color: AppColor.hintcolor),
              ),
              hintStyle: TextStyle(
                  fontSize: AppSizes.fontSmalle,
                  fontWeight: FontWeight.w500,
                  color: AppColor.hintcolor,
                  fontFamily: 'Inter'),
              suffixIcon: suffixIcon, // Adding the suffix icon
            ),
          ),
        ),
      ],
    );
  }
}
