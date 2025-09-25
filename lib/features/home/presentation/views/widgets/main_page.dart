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
          return Expanded(
            flex: 5,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: context.read<PageChangedCubit>().items.length,
              itemBuilder: (context, index) {
                return context
                        .read<PageChangedCubit>()
                        .items[context.read<PageChangedCubit>().activeIndex]
                        .page ??
                    Center(
                      child: Text(
                        'صفحة ${context.read<PageChangedCubit>().items[index].title} قيد التطوير',
                        style: AppTextStyles.fontWeight700Size16(context),
                      ),
                    );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
