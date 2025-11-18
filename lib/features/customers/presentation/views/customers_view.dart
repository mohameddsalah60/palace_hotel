import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/di/getit_service_loacator.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/custmers_cubit.dart';
import 'widgets/customers_view_body.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CustmersCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        body: CustomersViewBody(),
      ),
    );
  }
}
