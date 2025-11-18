class CustomerEntity {
  final String nationalId;
  final String nameCustmer;
  final String phoneCustmer;
  final String jobCustmer;
  final String addressCustmer;
  final String relationshipCustmer;

  CustomerEntity({
    required this.relationshipCustmer,
    required this.nationalId,
    required this.nameCustmer,
    required this.phoneCustmer,
    required this.jobCustmer,
    required this.addressCustmer,
  });
}
