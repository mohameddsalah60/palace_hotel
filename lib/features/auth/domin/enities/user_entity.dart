class UserEntity {
  final String name;
  final String phone;
  final String email;
  String token;

  UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.token,
  });
}
