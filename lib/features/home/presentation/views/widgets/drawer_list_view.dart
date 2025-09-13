import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';

import 'drawer_item.dart';

class DrawerListView extends StatelessWidget {
  const DrawerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: List.generate(context.read<PageChangedCubit>().items.length, (
        index,
      ) {
        return GestureDetector(
          onTap: () {
            context.read<PageChangedCubit>().changePage(index);
          },
          child: DrawerItem(
            isSelected: context.watch<PageChangedCubit>().activeIndex == index,
            drawerItemEntity: context.read<PageChangedCubit>().items[index],
          ),
        );
      }),
    );
  }
}
