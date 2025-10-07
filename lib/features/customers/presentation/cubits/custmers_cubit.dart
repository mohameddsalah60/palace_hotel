import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/customers/domin/repos/custmer_repo.dart';

import '../../domin/entites/customer_entity.dart';

part 'custmers_state.dart';

class CustmersCubit extends Cubit<CustmersState> {
  CustmersCubit(this.custmerRepo) : super(CustmersInitial()) {
    getAllCustmers();
  }
  final CustmerRepo custmerRepo;
  List<CustomerEntity> custmers = [];
  // ============= Controllers and Form Key ============
  final formKey = GlobalKey<FormState>();
  final custmerIdController = TextEditingController();
  final nameCustmerController = TextEditingController();
  final phoneCustmerController = TextEditingController();
  final addressCustmerController = TextEditingController();
  final jobCustmerController = TextEditingController();

  void clearControllers() {
    custmerIdController.clear();
    nameCustmerController.clear();
    phoneCustmerController.clear();
    addressCustmerController.clear();
    jobCustmerController.clear();
  }

  void updateCastomerInfo(CustomerEntity customer) async {
    custmerIdController.text = customer.nationalId;
    nameCustmerController.text = customer.nameCustmer;
    phoneCustmerController.text = customer.phoneCustmer;
    addressCustmerController.text = customer.addressCustmer;
    jobCustmerController.text = customer.jobCustmer;
  }

  void serchCustmer(String query) {
    final filteredCustmers =
        custmers.where((custmer) {
          final nameLower = custmer.nameCustmer.toLowerCase();
          final idLower = custmer.nationalId.toLowerCase();
          final searchLower = query.toLowerCase();
          return nameLower.contains(searchLower) ||
              idLower.contains(searchLower);
        }).toList();
    emit(CustmersLoaded(filteredCustmers));
    if (query.isEmpty) {
      emit(CustmersLoaded(custmers));
    }
  }

  void deleteCustmer(CustomerEntity custmer) async {
    final result = await custmerRepo.deleteCustmer(customerEntity: custmer);
    result.fold(
      (failure) {
        emit(CustmersError(failure.errMessage));
      },
      (_) {
        emit(CustmerDeleted());
        getAllCustmers();
      },
    );
  }

  void insertCustomer() async {
    if (formKey.currentState!.validate()) {
      emit(CustmersLoading());
      final custmerEntity = CustomerEntity(
        nationalId: custmerIdController.text,
        nameCustmer: nameCustmerController.text,
        phoneCustmer: phoneCustmerController.text,
        addressCustmer: addressCustmerController.text,
        jobCustmer: jobCustmerController.text,
      );
      if (custmers.any((custmer) {
        return custmer.nationalId == custmerIdController.text ||
            custmer.phoneCustmer == phoneCustmerController.text;
      })) {
        final result = await custmerRepo.updateCustmer(
          customerEntity: custmerEntity,
        );
        result.fold(
          (failure) {
            emit(CustmersError(failure.errMessage));
          },
          (_) {
            emit(CustmerAdded());
          },
        );
        return;
      }
      final result = await custmerRepo.addNewCustmer(
        customerEntity: custmerEntity,
      );
      result.fold(
        (failure) {
          emit(CustmersError(failure.errMessage));
        },
        (_) {
          emit(CustmerAdded());
        },
      );
    }
  }

  void getAllCustmers() async {
    emit(CustmersLoading());
    final result = await custmerRepo.getAllCustmers();
    result.fold(
      (failure) {
        emit(CustmersError(failure.errMessage));
      },
      (custmers) {
        this.custmers = custmers;
        emit(CustmersLoaded(custmers));
      },
    );
  }
}
