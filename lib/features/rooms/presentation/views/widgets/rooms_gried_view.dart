import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubits/rooms_cubit.dart';
import 'room_item.dart';

class GridViewListBuilder extends StatelessWidget {
  const GridViewListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        if (state is RoomsSuccess) {
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 14.w,
              childAspectRatio: MediaQuery.of(context).size.width / 1300,
            ),

            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return RoomCard(roomEntity: state.rooms[index]);
            },
          );
        } else if (state is RoomsLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(color: AppColors.blackLight),
            ),
          );
        }
        return SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
