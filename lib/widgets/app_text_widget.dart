import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextWidget extends StatefulWidget {
  const AppTextWidget(
      {super.key,
      this.text,
      this.fontSize,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.letterSpacing,
      this.textOverflow,
      this.textDecoration,
      this.maxLines,
        this.softWrap,
      });
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? color;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final bool? softWrap;

  @override
  State<AppTextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<AppTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: widget.textAlign,
      widget.text ?? "",
      overflow: widget.textOverflow,
      maxLines: widget.maxLines,
      softWrap: widget.softWrap ?? true,
      style: GoogleFonts.inter(
          decoration: widget.textDecoration,
          fontSize: widget.fontSize ?? 12.sp,
          fontWeight: widget.fontWeight,
          color: widget.color,
          letterSpacing: widget.letterSpacing),
    );
  }
}
