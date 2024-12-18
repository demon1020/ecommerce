import 'package:flutter/services.dart';

import '/core.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.title,
    required this.hintText,
    required this.inputFormatter,
    required this.enabled,
    required this.maxLines,
    this.maxLength,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixText,
    this.onChanged,
    this.validator,
    this.onTap,
    this.showCursor = true,
    this.readOnly = false,
    this.cursorColor = AppColor.primary,
    this.isRequired = false, // New property
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final List<TextInputFormatter> inputFormatter;
  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? suffixText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool showCursor;
  final bool readOnly;
  final Color cursorColor;
  final bool isRequired;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText; // Local state for handling obscure text

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: AppSizes.fontSmalle,
                fontWeight: FontWeight.w500,
                color: AppColor.secondarytextcolor,
                fontFamily: 'Inter',
              ),
            ),
            if (widget.isRequired) // Show asterisk if required
              Text(
                '*',
                style: TextStyle(
                  fontSize: AppSizes.fontSmalle,
                  fontWeight: FontWeight.w500,
                  color: Colors.red, // Use red color for the asterisk
                  fontFamily: 'Inter',
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          inputFormatters: widget.inputFormatter,
          enabled: widget.enabled,
          validator: widget.validator,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          showCursor: widget.showCursor,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          cursorColor: widget.cursorColor,
          maxLength: widget.maxLength,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: AppSizes.fontMedium,
            fontWeight: FontWeight.w500,
            color: AppColor.primarytextcolor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.sp),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.textcolornew),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.sp),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.textcolornew),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.sp),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.textcolornew),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.sp),
              borderSide: BorderSide(width: 1.w, color: AppColor.textcolornew),
            ),
            hintStyle: TextStyle(
              fontSize: AppSizes.fontSmalle,
              fontWeight: FontWeight.w500,
              color: AppColor.hintcolor,
              fontFamily: 'Inter',
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColor.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Toggle visibility
                      });
                    },
                  )
                : widget.suffixIcon,
            suffixText: widget.suffixText,
            suffixStyle: TextStyle(
              color: AppColor.hintcolor,
              fontSize: AppSizes.fontSmall,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
