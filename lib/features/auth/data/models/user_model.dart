import 'package:palace_systeam_managment/features/auth/data/models/permissions_users_model.dart';

import '../../domin/enities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.token,
    required super.permissions,
  });
  factory UserModel.fromJsonData(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      email: data['email'] as String? ?? '',
      token: data['token'] as String? ?? '',
      permissions: PermissionsUsersModel.fromJson(
        data['permissionsUsers'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      phone: userEntity.phone,
      email: userEntity.email,
      token: userEntity.token,
      permissions: userEntity.permissions,
    );
  }
  toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'permissionsUsers':
          (permissions is PermissionsUsersModel
              ? permissions
              : PermissionsUsersModel.fromEntity(permissions).toJson()),
    };
  }
}
