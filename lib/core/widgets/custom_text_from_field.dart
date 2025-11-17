import 'package:flutter/material.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

import '../utils/app_colors.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.labelText,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.isReadOnly = false,
    this.maxLines,
    this.buildCounter,
    this.iconColor,
    this.textColor,
    this.isObscureText,
  });
  final String labelText;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isReadOnly;
  final int? maxLines;
  final FocusNode? focusNode;
  final Color? iconColor, textColor;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })?
  buildCounter;
  final bool? isObscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText ?? false,
      focusNode: focusNode,
      buildCounter: buildCounter,
      maxLines: maxLines ?? 1,
      readOnly: isReadOnly,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(
        context: context,
        labelText: labelText,
        icon: icon,
        textColor: textColor,
      ),
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
    );
  }

  InputDecoration _inputDecoration({
    required BuildContext context,
    required String labelText,
    required IconData icon,
    Color? textColor,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTextStyles.fontWeight400Size14(
        context,
      ).copyWith(color: textColor ?? AppColors.black),
      prefixIcon: Icon(icon, color: iconColor ?? AppColors.greyDark),
      fillColor: AppColors.wheitDark,
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
        borderSide: const BorderSide(color: AppColors.mainBlue, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}
