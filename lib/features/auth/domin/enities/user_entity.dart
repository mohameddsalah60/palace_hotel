import 'package:palace_systeam_managment/features/auth/domin/enities/permissions_users.dart';

class UserEntity {
  final String name;
  final String phone;
  final String email;
  final PermissionsUsers permissions;
  String token;

  UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.token,
    required this.permissions,
  });
}
