import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.child,
    this.value,
  });
  final Widget child;
  final void Function()? value;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showRoomDialog(context);
      },
      backgroundColor: AppColors.wheitDark,
      child: Icon(Icons.add, color: AppColors.blackLight, size: 32.r),
    );
  }

  void showRoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return child;
      },
    ).then((_) {
      value?.call();
    });
  }
}
