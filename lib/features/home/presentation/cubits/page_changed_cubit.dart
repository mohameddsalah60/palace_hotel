import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../rooms/presentation/views/rooms_view.dart';
import '../../domin/entites/drawer_item_entity.dart';
part 'page_changed_state.dart';

class PageChangedCubit extends Cubit<PageChangedState> {
  PageChangedCubit() : super(PageChangedInitial());
  final List<DrawerItemEntity> items = [
    // DrawerItemEntity(
    //   title: 'اللوحة الرئيسية',
    //   icon: Icons.dashboard_outlined,
    //   page: DashboardView(),
    // ),
    DrawerItemEntity(
      title: 'إدارة الغرف',
      icon: Icons.bookmark_border,
      page: RoomsView(),
    ),
    DrawerItemEntity(
      title: 'إدارة الحجوزات',
      icon: Icons.receipt_long_outlined,
    ),
    DrawerItemEntity(title: 'العملاء', icon: Icons.people_alt_outlined),
    DrawerItemEntity(title: 'حول البرنامج', icon: Icons.info_outline),
    DrawerItemEntity(title: 'الإعدادات', icon: Icons.settings_outlined),
  ];
  int activeIndex = 0;
  void changePage(int index) {
    activeIndex = index;
    emit(PageChangedSuccess());
  }
}
