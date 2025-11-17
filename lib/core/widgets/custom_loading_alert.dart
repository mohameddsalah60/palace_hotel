import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

void customLoadingAlert(
  BuildContext context, {
  String title = "جاري التحميل",
  String message = "يرجى الانتظار...",
  Color color = AppColors.mainBlue,
  bool showCancel = false,
  VoidCallback? onConfirm,
}) {
  showGeneralDialog(
    barrierDismissible: false,
    context: context,
    barrierLabel: "Loading",
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink(); // dummy
    },
    transitionBuilder: (context, anim1, anim2, child) {
      final curvedValue = Curves.easeInOut.transform(anim1.value);
      return Opacity(
        opacity: curvedValue,
        child: Transform.scale(
          scale: curvedValue,
          child: Center(
            child: Dialog(
              backgroundColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CircularProgressIndicator
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: .15),
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          color: color,
                          strokeWidth: 4.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Message
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 16,
                      ),
                    ),

                    // Optional Actions
                    if (showCancel || onConfirm != null) ...[
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (showCancel)
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.wheitSecondary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'إلغاء',
                                style: TextStyle(
                                  color: AppColors.greyDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          if (onConfirm != null) ...[
                            if (showCancel) const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: color,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'تأكيد',
                                style: TextStyle(
                                  color: AppColors.wheit,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
