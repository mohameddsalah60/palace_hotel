import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';

class PasswordTileField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordTileField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 16.r),
        child: CustomTextFromField(
          controller: controller,
          labelText: '***********',
          icon: Icons.password,
          isObscureText: true,
          validator: validator,
        ),
      ),
    );
  }
}
