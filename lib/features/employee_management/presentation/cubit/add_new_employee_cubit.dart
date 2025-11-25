import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/employee_management/domain/repositories/employee_repo.dart';

import '../../../../core/entites/permissions_users.dart';
import '../../../../core/entites/user_entity.dart';

part 'add_new_employee_state.dart';

class AddNewEmployeeCubit extends Cubit<AddNewEmployeeState> {
  AddNewEmployeeCubit(this.employeeRepo) : super(AddNewEmployeeInitial());

  final EmployeeRepo employeeRepo;
  final fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nidController = TextEditingController();
  final jobTitleController = TextEditingController();

  PermissionsUsers permissionsUsers = PermissionsUsers(
    canAddRoom: false,
    canEditRoom: false,
    canDeleteRoom: false,
    canViewRooms: true,
    canCreateBooking: false,
    canEditBooking: false,
    canCancelBooking: false,
    canCloseBooking: false,
    canViewBookings: true,
    canAddGuest: false,
    canEditGuest: false,
    canDeleteGuest: false,
    canViewGuests: true,
    canAddStaff: false,
    canEditStaff: false,
    canDeleteStaff: false,
    canViewStaff: true,
    canViewInvoices: true,
    canEditInvoices: false,
    canDeleteInvoices: false,
    canCreateInvoice: false,
    canManageServices: false,
    canChangeSettings: false,
    canViewReports: true,
  );

  void updatePermissionByField(String fieldName, bool value) {
    switch (fieldName) {
      case 'canViewRooms':
        permissionsUsers = permissionsUsers.copyWith(canViewRooms: value);
        break;
      case 'canAddRoom':
        permissionsUsers = permissionsUsers.copyWith(canAddRoom: value);
        break;
      case 'canEditRoom':
        permissionsUsers = permissionsUsers.copyWith(canEditRoom: value);
        break;
      case 'canDeleteRoom':
        permissionsUsers = permissionsUsers.copyWith(canDeleteRoom: value);
        break;
      case 'canViewBookings':
        permissionsUsers = permissionsUsers.copyWith(canViewBookings: value);
        break;
      case 'canCreateBooking':
        permissionsUsers = permissionsUsers.copyWith(canCreateBooking: value);
        break;
      case 'canEditBooking':
        permissionsUsers = permissionsUsers.copyWith(canEditBooking: value);
        break;
      case 'canCancelBooking':
        permissionsUsers = permissionsUsers.copyWith(canCancelBooking: value);
        break;
      case 'canCloseBooking':
        permissionsUsers = permissionsUsers.copyWith(canCloseBooking: value);
        break;
      case 'canViewGuests':
        permissionsUsers = permissionsUsers.copyWith(canViewGuests: value);
        break;
      case 'canAddGuest':
        permissionsUsers = permissionsUsers.copyWith(canAddGuest: value);
        break;
      case 'canEditGuest':
        permissionsUsers = permissionsUsers.copyWith(canEditGuest: value);
        break;
      case 'canDeleteGuest':
        permissionsUsers = permissionsUsers.copyWith(canDeleteGuest: value);
        break;
      case 'canViewStaff':
        permissionsUsers = permissionsUsers.copyWith(canViewStaff: value);
        break;
      case 'canAddStaff':
        permissionsUsers = permissionsUsers.copyWith(canAddStaff: value);
        break;
      case 'canEditStaff':
        permissionsUsers = permissionsUsers.copyWith(canEditStaff: value);
        break;
      case 'canDeleteStaff':
        permissionsUsers = permissionsUsers.copyWith(canDeleteStaff: value);
        break;
      case 'canViewInvoices':
        permissionsUsers = permissionsUsers.copyWith(canViewInvoices: value);
        break;
      case 'canCreateInvoice':
        permissionsUsers = permissionsUsers.copyWith(canCreateInvoice: value);
        break;
      case 'canEditInvoices':
        permissionsUsers = permissionsUsers.copyWith(canEditInvoices: value);
        break;
      case 'canDeleteInvoices':
        permissionsUsers = permissionsUsers.copyWith(canDeleteInvoices: value);
        break;
      case 'canManageServices':
        permissionsUsers = permissionsUsers.copyWith(canManageServices: value);
        break;
      case 'canChangeSettings':
        permissionsUsers = permissionsUsers.copyWith(canChangeSettings: value);
        break;
      case 'canViewReports':
        permissionsUsers = permissionsUsers.copyWith(canViewReports: value);
        break;
    }
    emit(UpdateUI());
  }

  void updatePermission(String key, bool value) {
    switch (key) {
      case 'عرض الغرف':
        permissionsUsers = permissionsUsers.copyWith(canViewRooms: value);
        break;
      case 'إضافة غرفة':
        permissionsUsers = permissionsUsers.copyWith(canAddRoom: value);
        break;
      case 'تعديل غرفة':
        permissionsUsers = permissionsUsers.copyWith(canEditRoom: value);
        break;
      case 'حذف غرفة':
        permissionsUsers = permissionsUsers.copyWith(canDeleteRoom: value);
        break;

      case 'عرض الحجوزات':
        permissionsUsers = permissionsUsers.copyWith(canViewBookings: value);
        break;
      case 'إنشاء حجز':
        permissionsUsers = permissionsUsers.copyWith(canCreateBooking: value);
        break;
      case 'تعديل حجز':
        permissionsUsers = permissionsUsers.copyWith(canEditBooking: value);
        break;
      case 'إلغاء حجز':
        permissionsUsers = permissionsUsers.copyWith(canCancelBooking: value);
        break;
      case 'إغلاق حجز':
        permissionsUsers = permissionsUsers.copyWith(canCloseBooking: value);
        break;

      case 'عرض العملاء':
        permissionsUsers = permissionsUsers.copyWith(canViewGuests: value);
        break;
      case 'إضافة عميل':
        permissionsUsers = permissionsUsers.copyWith(canAddGuest: value);
        break;
      case 'تعديل عميل':
        permissionsUsers = permissionsUsers.copyWith(canEditGuest: value);
        break;
      case 'حذف عميل':
        permissionsUsers = permissionsUsers.copyWith(canDeleteGuest: value);
        break;

      case 'عرض الموظفين':
        permissionsUsers = permissionsUsers.copyWith(canViewStaff: value);
        break;
      case 'إضافة موظف':
        permissionsUsers = permissionsUsers.copyWith(canAddStaff: value);
        break;
      case 'تعديل موظف':
        permissionsUsers = permissionsUsers.copyWith(canEditStaff: value);
        break;
      case 'حذف موظف':
        permissionsUsers = permissionsUsers.copyWith(canDeleteStaff: value);
        break;

      case 'عرض الفواتير':
        permissionsUsers = permissionsUsers.copyWith(canViewInvoices: value);
        break;
      case 'إنشاء فاتورة':
        permissionsUsers = permissionsUsers.copyWith(canCreateInvoice: value);
        break;
      case 'تعديل فاتورة':
        permissionsUsers = permissionsUsers.copyWith(canEditInvoices: value);
        break;
      case 'حذف فاتورة':
        permissionsUsers = permissionsUsers.copyWith(canDeleteInvoices: value);
        break;

      case 'خدمات النظام':
        permissionsUsers = permissionsUsers.copyWith(canManageServices: value);
        break;
      case 'صلاحيات النظام':
        permissionsUsers = permissionsUsers.copyWith(canChangeSettings: value);
        break;
      case 'عرض التقارير':
        permissionsUsers = permissionsUsers.copyWith(canViewReports: value);
        break;
    }

    emit(UpdateUI());
  }

  Future<void> addNewEmployee() async {
    if (!fromKey.currentState!.validate()) return;

    emit(AddNewEmployeeLoading());
    log('loading');
    final employee = UserEntity(
      name: nameController.text,
      email: emailController.text.toLowerCase(),
      phone: phoneController.text,
      nid: nidController.text,
      jopTitle: jobTitleController.text,
      permissions: permissionsUsers,
    );
    final result = await employeeRepo.addEmployee(employee);
    result.fold(
      (failure) {
        emit(AddNewEmployeeFailure(message: failure.errMessage));
      },
      (_) {
        emit(AddNewEmployeeSuccess());
      },
    );
  }

  Future<void> updateEmployee(UserEntity user) async {
    emit(AddNewEmployeeLoading());
    final employee = UserEntity(
      name: user.name,
      email: user.email,
      phone: user.phone,
      nid: user.nid,
      jopTitle: user.jopTitle,
      permissions: permissionsUsers,
    );
    final result = await employeeRepo.updateEmployee(employee);
    result.fold(
      (failure) {
        emit(AddNewEmployeeFailure(message: failure.errMessage));
      },
      (_) {
        emit(AddNewEmployeeSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nidController.dispose();
    jobTitleController.dispose();
    return super.close();
  }
}
