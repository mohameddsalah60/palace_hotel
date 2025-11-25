import '../entites/permissions_users.dart';

class PermissionsUsersModel extends PermissionsUsers {
  PermissionsUsersModel({
    required super.canAddRoom,
    required super.canEditRoom,
    required super.canDeleteRoom,
    required super.canViewRooms,
    required super.canCreateBooking,
    required super.canEditBooking,
    required super.canCancelBooking,
    required super.canCloseBooking,
    required super.canViewBookings,
    required super.canAddGuest,
    required super.canEditGuest,
    required super.canDeleteGuest,
    required super.canViewGuests,
    required super.canAddStaff,
    required super.canEditStaff,
    required super.canDeleteStaff,
    required super.canViewStaff,
    required super.canViewInvoices,
    required super.canEditInvoices,
    required super.canDeleteInvoices,
    required super.canCreateInvoice,
    required super.canManageServices,
    required super.canChangeSettings,
    required super.canViewReports,
  });

  factory PermissionsUsersModel.fromJson(Map<String, dynamic> json) {
    return PermissionsUsersModel(
      // Rooms
      canAddRoom: json['canAddRoom'] ?? false,
      canEditRoom: json['canEditRoom'] ?? false,
      canDeleteRoom: json['canDeleteRoom'] ?? false,
      canViewRooms: json['canViewRooms'] ?? false,

      // Bookings
      canCreateBooking: json['canCreateBooking'] ?? false,
      canEditBooking: json['canEditBooking'] ?? false,
      canCancelBooking: json['canCancelBooking'] ?? false,
      canCloseBooking: json['canCloseBooking'] ?? false,
      canViewBookings: json['canViewBookings'] ?? false,

      // Guests
      canAddGuest: json['canAddGuest'] ?? false,
      canEditGuest: json['canEditGuest'] ?? false,
      canDeleteGuest: json['canDeleteGuest'] ?? false,
      canViewGuests: json['canViewGuests'] ?? false,

      // Staff
      canAddStaff: json['canAddStaff'] ?? false,
      canEditStaff: json['canEditStaff'] ?? false,
      canDeleteStaff: json['canDeleteStaff'] ?? false,
      canViewStaff: json['canViewStaff'] ?? false,

      // Financial
      canViewInvoices: json['canViewInvoices'] ?? false,
      canEditInvoices: json['canEditInvoices'] ?? false,
      canDeleteInvoices: json['canDeleteInvoices'] ?? false,
      canCreateInvoice: json['canCreateInvoice'] ?? false,

      // Services & Extras
      canManageServices: json['canManageServices'] ?? false,

      // Settings
      canChangeSettings: json['canChangeSettings'] ?? false,
      canViewReports: json['canViewReports'] ?? false,
    );
  }

  factory PermissionsUsersModel.fromEntity(PermissionsUsers entity) {
    return PermissionsUsersModel(
      canAddRoom: entity.canAddRoom,
      canEditRoom: entity.canEditRoom,
      canDeleteRoom: entity.canDeleteRoom,
      canViewRooms: entity.canViewRooms,

      canCreateBooking: entity.canCreateBooking,
      canEditBooking: entity.canEditBooking,
      canCancelBooking: entity.canCancelBooking,
      canCloseBooking: entity.canCloseBooking,
      canViewBookings: entity.canViewBookings,

      canAddGuest: entity.canAddGuest,
      canEditGuest: entity.canEditGuest,
      canDeleteGuest: entity.canDeleteGuest,
      canViewGuests: entity.canViewGuests,

      canAddStaff: entity.canAddStaff,
      canEditStaff: entity.canEditStaff,
      canDeleteStaff: entity.canDeleteStaff,
      canViewStaff: entity.canViewStaff,

      canViewInvoices: entity.canViewInvoices,
      canEditInvoices: entity.canEditInvoices,
      canDeleteInvoices: entity.canDeleteInvoices,
      canCreateInvoice: entity.canCreateInvoice,

      canManageServices: entity.canManageServices,

      canChangeSettings: entity.canChangeSettings,
      canViewReports: entity.canViewReports,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Rooms
      'canAddRoom': canAddRoom,
      'canEditRoom': canEditRoom,
      'canDeleteRoom': canDeleteRoom,
      'canViewRooms': canViewRooms,

      // Bookings
      'canCreateBooking': canCreateBooking,
      'canEditBooking': canEditBooking,
      'canCancelBooking': canCancelBooking,
      'canCloseBooking': canCloseBooking,
      'canViewBookings': canViewBookings,

      // Guests
      'canAddGuest': canAddGuest,
      'canEditGuest': canEditGuest,
      'canDeleteGuest': canDeleteGuest,
      'canViewGuests': canViewGuests,

      // Staff
      'canAddStaff': canAddStaff,
      'canEditStaff': canEditStaff,
      'canDeleteStaff': canDeleteStaff,
      'canViewStaff': canViewStaff,

      // Financial
      'canViewInvoices': canViewInvoices,
      'canEditInvoices': canEditInvoices,
      'canDeleteInvoices': canDeleteInvoices,
      'canCreateInvoice': canCreateInvoice,

      // Services & Extras
      'canManageServices': canManageServices,

      // Settings
      'canChangeSettings': canChangeSettings,
      'canViewReports': canViewReports,
    };
  }
}
