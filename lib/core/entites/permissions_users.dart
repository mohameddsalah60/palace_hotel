class PermissionsUsers {
  // Rooms Permissions
  final bool canAddRoom;
  final bool canEditRoom;
  final bool canDeleteRoom;
  final bool canViewRooms;

  // Bookings Permissions
  final bool canCreateBooking;
  final bool canEditBooking;
  final bool canCancelBooking;
  final bool canCloseBooking;
  final bool canViewBookings;

  // Guests Permissions
  final bool canAddGuest;
  final bool canEditGuest;
  final bool canDeleteGuest;
  final bool canViewGuests;

  // Staff Permissions
  final bool canAddStaff;
  final bool canEditStaff;
  final bool canDeleteStaff;
  final bool canViewStaff;

  // Financial Permissions
  final bool canViewInvoices;
  final bool canEditInvoices;
  final bool canDeleteInvoices;
  final bool canCreateInvoice;

  // Services & Extras
  final bool canManageServices; // room service, spa, amenities, etc.

  // Settings Permissions
  final bool canChangeSettings;
  final bool canViewReports;

  const PermissionsUsers({
    // Rooms
    required this.canAddRoom,
    required this.canEditRoom,
    required this.canDeleteRoom,
    required this.canViewRooms,

    // Bookings
    required this.canCreateBooking,
    required this.canEditBooking,
    required this.canCancelBooking,
    required this.canCloseBooking,
    required this.canViewBookings,

    // Guests
    required this.canAddGuest,
    required this.canEditGuest,
    required this.canDeleteGuest,
    required this.canViewGuests,

    // Staff
    required this.canAddStaff,
    required this.canEditStaff,
    required this.canDeleteStaff,
    required this.canViewStaff,

    // Financial
    required this.canViewInvoices,
    required this.canEditInvoices,
    required this.canDeleteInvoices,
    required this.canCreateInvoice,

    // Services
    required this.canManageServices,

    // Settings & Reports
    required this.canChangeSettings,
    required this.canViewReports,
  });

  PermissionsUsers copyWith({
    bool? canAddRoom,
    bool? canEditRoom,
    bool? canDeleteRoom,
    bool? canViewRooms,

    bool? canCreateBooking,
    bool? canEditBooking,
    bool? canCancelBooking,
    bool? canCloseBooking,
    bool? canViewBookings,

    bool? canAddGuest,
    bool? canEditGuest,
    bool? canDeleteGuest,
    bool? canViewGuests,

    bool? canAddStaff,
    bool? canEditStaff,
    bool? canDeleteStaff,
    bool? canViewStaff,

    bool? canViewInvoices,
    bool? canEditInvoices,
    bool? canDeleteInvoices,
    bool? canCreateInvoice,

    bool? canManageServices,
    bool? canChangeSettings,
    bool? canViewReports,
  }) {
    return PermissionsUsers(
      canAddRoom: canAddRoom ?? this.canAddRoom,
      canEditRoom: canEditRoom ?? this.canEditRoom,
      canDeleteRoom: canDeleteRoom ?? this.canDeleteRoom,
      canViewRooms: canViewRooms ?? this.canViewRooms,

      canCreateBooking: canCreateBooking ?? this.canCreateBooking,
      canEditBooking: canEditBooking ?? this.canEditBooking,
      canCancelBooking: canCancelBooking ?? this.canCancelBooking,
      canCloseBooking: canCloseBooking ?? this.canCloseBooking,
      canViewBookings: canViewBookings ?? this.canViewBookings,

      canAddGuest: canAddGuest ?? this.canAddGuest,
      canEditGuest: canEditGuest ?? this.canEditGuest,
      canDeleteGuest: canDeleteGuest ?? this.canDeleteGuest,
      canViewGuests: canViewGuests ?? this.canViewGuests,

      canAddStaff: canAddStaff ?? this.canAddStaff,
      canEditStaff: canEditStaff ?? this.canEditStaff,
      canDeleteStaff: canDeleteStaff ?? this.canDeleteStaff,
      canViewStaff: canViewStaff ?? this.canViewStaff,

      canViewInvoices: canViewInvoices ?? this.canViewInvoices,
      canEditInvoices: canEditInvoices ?? this.canEditInvoices,
      canDeleteInvoices: canDeleteInvoices ?? this.canDeleteInvoices,
      canCreateInvoice: canCreateInvoice ?? this.canCreateInvoice,

      canManageServices: canManageServices ?? this.canManageServices,
      canChangeSettings: canChangeSettings ?? this.canChangeSettings,
      canViewReports: canViewReports ?? this.canViewReports,
    );
  }
}
