import 'package:palace_systeam_managment/features/customers/domin/entites/customer_entity.dart';

class CustmerModel extends CustomerEntity {
  CustmerModel({
    required super.nationalId,
    required super.nameCustmer,
    required super.phoneCustmer,
    required super.jobCustmer,
    required super.addressCustmer,
  });
  factory CustmerModel.fromEntity(CustomerEntity customerEntity) {
    return CustmerModel(
      nationalId: customerEntity.nationalId,
      nameCustmer: customerEntity.nameCustmer,
      phoneCustmer: customerEntity.phoneCustmer,
      jobCustmer: customerEntity.jobCustmer,
      addressCustmer: customerEntity.addressCustmer,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'nationalId': nationalId,
      'nameCustmer': nameCustmer,
      'phoneCustmer': phoneCustmer,
      'jobCustmer': jobCustmer,
      'addressCustmer': addressCustmer,
    };
  }

  factory CustmerModel.fromMap(Map<String, dynamic> map) {
    return CustmerModel(
      nationalId: map['nationalId'] ?? '',
      nameCustmer: map['nameCustmer'] ?? '',
      phoneCustmer: map['phoneCustmer'] ?? '',
      jobCustmer: map['jobCustmer'] ?? '',
      addressCustmer: map['addressCustmer'] ?? '',
    );
  }
}
