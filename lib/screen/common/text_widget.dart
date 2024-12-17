import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? color;
  const TextWidget(
      {super.key,
      required this.text,
      this.maxLines,
      this.overflow,
      this.color,
      this.decoration,
      this.textAlign,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          decoration: decoration,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
