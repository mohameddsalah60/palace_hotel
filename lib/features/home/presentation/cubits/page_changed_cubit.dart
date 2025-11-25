import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/views/booking_management_view.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';

import '../../../customers/presentation/views/customers_view.dart';
import '../../../employee_management/presentation/views/employees_view.dart';
import '../../../rooms/presentation/views/rooms_view.dart';
import '../../domin/entites/drawer_item_entity.dart';
part 'page_changed_state.dart';

class PageChangedCubit extends Cubit<PageChangedState> {
  final AuthRepo authRepo;

  PageChangedCubit(this.authRepo) : super(PageChangedInitial());

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
      page: BookingManagementView(),
    ),
    DrawerItemEntity(
      title: 'إدارة النزلاء',
      icon: Icons.people_alt_outlined,
      page: CustomersView(),
    ),
    DrawerItemEntity(
      title: 'إدارة الموظفين',
      icon: Icons.person_pin,
      page: EmployeesView(),
    ),
    DrawerItemEntity(title: 'حول البرنامج', icon: Icons.info_outline),
    DrawerItemEntity(title: 'الإعدادات', icon: Icons.settings_outlined),
  ];
  int activeIndex = 0;

  void changePage(int index) {
    activeIndex = index;
    emit(PageChangedSuccess());
  }

  Future<void> logout() async {
    emit(PageChangedLogoutLoading());
    final result = await authRepo.signOut();

    result.fold(
      (failure) => emit(PageChangedLogoutFailure(message: failure.errMessage)),
      (_) => emit(PageChangedLogoutSuccess()),
    );
  }
}
