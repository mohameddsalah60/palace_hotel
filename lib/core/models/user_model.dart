import 'package:palace_systeam_managment/core/models/permissions_users_model.dart';

import '../entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.token,
    required super.permissions,
    required super.nid,
    required super.jopTitle,
  });
  factory UserModel.fromJsonData(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      email: data['email'] as String? ?? '',
      token: data['token'] as String? ?? '',
      nid: data['nid'] as String? ?? '',
      jopTitle: data['jopTitle'] as String? ?? '',
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
      nid: userEntity.nid,
      jopTitle: userEntity.jopTitle,
      permissions: userEntity.permissions,
    );
  }
  toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'nid': nid,
      'jopTitle': jopTitle,
      'permissionsUsers':
          permissions is PermissionsUsersModel
              ? (permissions as PermissionsUsersModel).toJson()
              : PermissionsUsersModel.fromEntity(permissions).toJson(),
    };
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? token,
    String? nid,
    String? jopTitle,
    PermissionsUsersModel? permissions,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      token: token ?? this.token,
      nid: nid ?? this.nid,
      jopTitle: jopTitle ?? this.jopTitle,
      permissions: permissions ?? this.permissions,
    );
  }
}
