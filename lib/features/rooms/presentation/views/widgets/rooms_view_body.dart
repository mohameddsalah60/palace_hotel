import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/rooms_cubit.dart';
import 'rooms_gried_view.dart';
import 'search_and_filter_type_bar.dart';

class RoomsViewBody extends StatelessWidget {
  const RoomsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          SearchAndFilterTypeBar(
            onChanged: (value) {
              context.read<RoomsCubit>().search(value);
            },
          ),
          SizedBox(height: 24.h),
          RoomsGriedView(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
