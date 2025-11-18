import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class Customdropdownbuttonfield extends StatelessWidget {
  const Customdropdownbuttonfield({
    super.key,
    required this.value,
    required this.labelText,
    this.fillColor,
    this.items,
    this.onChanged,
    this.icon,
  });
  final String value, labelText;
  final Color? fillColor;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String? newValue)? onChanged;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon ?? Icons.info_outline, color: AppColors.greyDark),
        fillColor: fillColor ?? AppColors.wheitDark,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.mainBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      items: items,

      onChanged: onChanged,
    );
  }
}
