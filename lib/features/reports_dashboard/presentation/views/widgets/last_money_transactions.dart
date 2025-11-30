import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import 'last_money_transactions_data_table.dart';

class LastMoneyTransactions extends StatelessWidget {
  const LastMoneyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                'اخر المعاملات المالية',
                style: AppTextStyles.fontWeight700Size20(context),
              ),
              SizedBox(width: 28.w),
              SizedBox(
                width: 250.w,
                child: CustomTextFromField(
                  labelText: 'بحث عن آي معاملة',
                  icon: Icons.search,
                ),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          const LastMoneyTransactionsDataTable(),
        ],
      ),
    );
  }
}
