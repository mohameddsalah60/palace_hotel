class Employee {
  final String name;
  final String phone;
  final String password;
  final String email;
  final String role;
  final DateTime createdAt;

  Employee({
    required this.password,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
  });
}
