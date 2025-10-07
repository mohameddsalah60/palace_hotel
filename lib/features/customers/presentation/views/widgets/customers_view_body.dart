import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customers_view_bloc_consumer.dart';
import 'customers_view_header.dart';

class CustomersViewBody extends StatelessWidget {
  const CustomersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 24.r),
      child: Column(
        children: [
          CustomersViewHeader(),

          SizedBox(height: 24.h),

          CustomersViewBlocConsumer(),
        ],
      ),
    );
  }
}
