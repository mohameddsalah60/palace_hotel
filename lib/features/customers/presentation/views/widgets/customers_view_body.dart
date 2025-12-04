import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/helpers/get_user.dart';
import 'package:palace_systeam_managment/core/widgets/custom_appbar_header_widget.dart';
import 'package:palace_systeam_managment/core/widgets/custom_search_field.dart';
import 'package:palace_systeam_managment/core/widgets/custom_snackbar.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button_with_icon.dart';
import '../../cubits/custmers_cubit.dart';
import 'custmer_details_dialog.dart';
import 'customers_view_bloc_consumer.dart';

class CustomersViewBody extends StatelessWidget {
  const CustomersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbarHeaderWidget(
          title: 'إدارة النزلاء',
          subtitle: 'عرض وإدارة بيانات جميع النزلاء في الفندق',
        ),

        SizedBox(height: 24.h),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.r),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            color: AppColors.wheit,
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'البحث',
                        style: AppTextStyles.fontWeight400Size14(context),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 12.r),
                        child: CustomSearchField(
                          onChanged: (value) {
                            context.read<CustmersCubit>().serchCustmer(value);
                          },
                          hintText: 'ابحث عن اسم نزيل أو رقم هوية',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'الترتيب',
                        style: AppTextStyles.fontWeight400Size14(context),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyBorder),
                            color: AppColors.wheit,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: DropdownButton<String>(
                            value:
                                context.watch<CustmersCubit>().selectedSortType,
                            onChanged: (v) {
                              if (v != null) {
                                context.read<CustmersCubit>().sortCustmers(v);
                                context.read<CustmersCubit>().selectedSortType =
                                    v;
                              }
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black45,
                            ),
                            itemHeight: 50.h > 48.0 ? 50.h : 48.0,
                            items:
                                [
                                  'الاحدث اولآ',
                                  'الاقدم اولآ',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppTextStyles.fontWeight400Size14(
                                        context,
                                      ).copyWith(
                                        color: AppColors.blackLight,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16.w),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        '',
                        style: AppTextStyles.fontWeight400Size14(context),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 12.r),
                        child: CustomButtonWithIcon(
                          text: 'اضافة نزيل جديد',
                          icon: Icons.person_add_alt_1_outlined,
                          onPressed: () {
                            if (getUser().permissions.canAddGuest) {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => const CustmerDetailsDialog(),
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<CustmersCubit>()
                                      .clearControllers();
                                }
                              });
                            } else {
                              customSnackBar(
                                context: context,
                                message: 'عفوا لا تمتلك صلاحية',
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomersViewBlocConsumer(),
            ],
          ),
        ),
      ],
    );
  }
}
