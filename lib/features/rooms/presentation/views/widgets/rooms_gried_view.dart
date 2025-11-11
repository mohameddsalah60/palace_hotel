import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubits/rooms_cubit.dart';
import 'room_item.dart';

class RoomsGriedView extends StatelessWidget {
  const RoomsGriedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.wheit,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: GridViewListBuilder(),
      ),
    );
  }
}

class GridViewListBuilder extends StatelessWidget {
  const GridViewListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        if (state is RoomsSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 14.w,
              childAspectRatio: MediaQuery.of(context).size.width / 900,
            ),
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return RoomItem(roomEntity: state.rooms[index]);
            },
          );
        } else if (state is RoomsLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.blackLight),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
