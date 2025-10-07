import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    this.tooltip,
    this.onPressed,
    required this.icon,
  });
  final Color backgroundColor, iconColor;
  final String? tooltip;
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: IconButton(
          tooltip: tooltip,
          icon: Icon(icon, color: iconColor, size: 22),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
