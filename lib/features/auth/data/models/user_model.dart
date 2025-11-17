import '../../domin/enities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.token,
  });
  factory UserModel.fromJsonData(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      email: data['email'] as String? ?? '',
      token: data['token'] as String? ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      phone: userEntity.phone,
      email: userEntity.email,
      token: userEntity.token,
    );
  }
  toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'token': token};
  }
}
