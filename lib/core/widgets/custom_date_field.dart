import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

import '../utils/app_colors.dart';

class CustomDateTimeFormField extends StatelessWidget {
  final String labelText;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final Function(DateTime?) onChanged;
  final IconData? suffixIcon;
  final Color? colorIcon;
  const CustomDateTimeFormField({
    super.key,
    required this.labelText,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    required this.onChanged,
    this.suffixIcon,
    this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      pickerPlatform: DateTimeFieldPickerPlatform.material,
      hideDefaultSuffixIcon: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon:
            suffixIcon != null
                ? Icon(suffixIcon, color: colorIcon ?? AppColors.greyDark)
                : null,
        filled: true,
        fillColor: AppColors.greyBorder,
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
          borderSide: const BorderSide(color: AppColors.mainBlue, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      firstDate: firstDate,
      lastDate: lastDate,
      initialPickerDateTime: initialDate ?? firstDate,
      onChanged: onChanged,
    );
  }
}
