import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/utils/app_colors.dart';
import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DateHeaderPage(),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.wheit,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نظرة عامة',
                        style: AppTextStyles.fontWeight600Size16(
                          context,
                        ).copyWith(
                          color: AppColors.blackLight,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 34.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'مجموع',
                                style: AppTextStyles.fontWeight400Size14(
                                  context,
                                ).copyWith(
                                  color: AppColors.greyDark,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "150",
                                    style: AppTextStyles.fontWeight700Size16(
                                      context,
                                    ).copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "غرفة متاحة",
                                    style: AppTextStyles.fontWeight500Size14(
                                      context,
                                    ).copyWith(
                                      color: AppColors.grey,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DateHeaderPage extends StatelessWidget {
  const DateHeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.wheit),
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      child: Center(
        child: Text(
          'الاثنين ،١١ مارس ٢٠٢٥',
          style: AppTextStyles.fontWeight600Size16(
            context,
          ).copyWith(fontSize: 20.sp),
        ),
      ),
    );
  }
}
