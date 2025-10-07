import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/custmers_cubit.dart';
import 'custmoers_data_table.dart';

class CustomersViewBlocConsumer extends StatelessWidget {
  const CustomersViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustmersCubit, CustmersState>(
      listener: (context, state) {
        if (state is CustmerAdded) {
          customSnackBar(
            context: context,
            message: 'تم اضافة / تعديل بيانات العميل',
            color: AppColors.success,
          );
          Navigator.pop(context);
          context.read<CustmersCubit>().clearControllers();
          context.read<CustmersCubit>().getAllCustmers();
        } else if (state is CustmersError) {
          customSnackBar(context: context, message: state.message);
        } else if (state is CustmerDeleted) {
          customSnackBar(context: context, message: 'تم حذف بيانات العميل');
        }
      },
      builder: (context, state) {
        if (state is CustmersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CustmersLoaded) {
          if (state.custmers.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد نزلاء',
                style: AppTextStyles.fontWeight600Size16(
                  context,
                ).copyWith(color: Colors.grey),
              ),
            );
          }
          return CustmoersDataTable(customerEntity: state.custmers);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
