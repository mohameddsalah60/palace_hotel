import 'package:palace_systeam_managment/core/entites/permissions_users.dart';

class UserEntity {
  final String name;
  final String phone;
  final String email;
  final String nid;
  final String jopTitle;
  final PermissionsUsers permissions;
  String? token;

  UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.nid,
    required this.jopTitle,
    this.token,
    required this.permissions,
  });
}
