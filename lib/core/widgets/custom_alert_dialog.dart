import 'package:flutter/material.dart';

void customAlertDialog(
  BuildContext context,
  String text,
  title,
  Color color,
  VoidCallback? onPressed,
) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: color),
              onPressed: onPressed,
              child: const Text('تأكيد', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
  );
}
