import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palace_systeam_managment/core/utils/app_text_styles.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageChangedCubit, PageChangedState>(
      builder: (context, state) {
        if (state is PageChangedSuccess) {
          final cubit = context.read<PageChangedCubit>();

          return Expanded(
            flex: 5,
            child: IndexedStack(
              index: cubit.activeIndex,
              children:
                  cubit.items.map((item) {
                    return item.page ??
                        Center(
                          child: Text(
                            'صفحة ${item.title} قيد التطوير',
                            style: AppTextStyles.fontWeight700Size16(context),
                          ),
                        );
                  }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
