import '../../../../core/entites/permissions_users.dart';

class PermissionItem {
  final String title;
  final String fieldName;
  bool value;

  PermissionItem({
    required this.title,
    required this.fieldName,
    required this.value,
  });
}

List<PermissionItem> permissionsList(PermissionsUsers permission) => [
  PermissionItem(
    title: 'عرض الغرف',
    fieldName: 'canViewRooms',
    value: permission.canViewRooms,
  ),
  PermissionItem(
    title: 'إضافة غرفة',
    fieldName: 'canAddRoom',
    value: permission.canAddRoom,
  ),
  PermissionItem(
    title: 'تعديل غرفة',
    fieldName: 'canEditRoom',
    value: permission.canEditRoom,
  ),
  PermissionItem(
    title: 'حذف غرفة',
    fieldName: 'canDeleteRoom',
    value: permission.canDeleteRoom,
  ),

  PermissionItem(
    title: 'عرض الحجوزات',
    fieldName: 'canViewBookings',
    value: permission.canViewBookings,
  ),
  PermissionItem(
    title: 'إنشاء حجز',
    fieldName: 'canCreateBooking',
    value: permission.canCreateBooking,
  ),
  PermissionItem(
    title: 'تعديل حجز',
    fieldName: 'canEditBooking',
    value: permission.canEditBooking,
  ),
  PermissionItem(
    title: 'إلغاء حجز',
    fieldName: 'canCancelBooking',
    value: permission.canCancelBooking,
  ),
  PermissionItem(
    title: 'إغلاق حجز',
    fieldName: 'canCloseBooking',
    value: permission.canCloseBooking,
  ),

  PermissionItem(
    title: 'عرض العملاء',
    fieldName: 'canViewGuests',
    value: permission.canViewGuests,
  ),
  PermissionItem(
    title: 'إضافة عميل',
    fieldName: 'canAddGuest',
    value: permission.canAddGuest,
  ),
  PermissionItem(
    title: 'تعديل عميل',
    fieldName: 'canEditGuest',
    value: permission.canEditGuest,
  ),
  PermissionItem(
    title: 'حذف عميل',
    fieldName: 'canDeleteGuest',
    value: permission.canDeleteGuest,
  ),

  PermissionItem(
    title: 'عرض الموظفين',
    fieldName: 'canViewStaff',
    value: permission.canViewStaff,
  ),
  PermissionItem(
    title: 'إضافة موظف',
    fieldName: 'canAddStaff',
    value: permission.canAddStaff,
  ),
  PermissionItem(
    title: 'تعديل موظف',
    fieldName: 'canEditStaff',
    value: permission.canEditStaff,
  ),
  PermissionItem(
    title: 'حذف موظف',
    fieldName: 'canDeleteStaff',
    value: permission.canDeleteStaff,
  ),

  PermissionItem(
    title: 'عرض الفواتير',
    fieldName: 'canViewInvoices',
    value: permission.canViewInvoices,
  ),
  PermissionItem(
    title: 'إنشاء فاتورة',
    fieldName: 'canCreateInvoice',
    value: permission.canCreateInvoice,
  ),
  PermissionItem(
    title: 'تعديل فاتورة',
    fieldName: 'canEditInvoices',
    value: permission.canEditInvoices,
  ),
  PermissionItem(
    title: 'حذف فاتورة',
    fieldName: 'canDeleteInvoices',
    value: permission.canDeleteInvoices,
  ),

  PermissionItem(
    title: 'خدمات النظام',
    fieldName: 'canManageServices',
    value: permission.canManageServices,
  ),
  PermissionItem(
    title: 'صلاحيات النظام',
    fieldName: 'canChangeSettings',
    value: permission.canChangeSettings,
  ),
  PermissionItem(
    title: 'عرض التقارير',
    fieldName: 'canViewReports',
    value: permission.canViewReports,
  ),
];
