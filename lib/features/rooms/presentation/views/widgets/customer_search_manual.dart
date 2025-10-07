import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:palace_systeam_managment/features/customers/presentation/cubits/custmers_cubit.dart';

import '../../../../../core/widgets/custom_text_from_field.dart';

class CustomerSearchManual extends StatelessWidget {
  final TextEditingController controller_;
  final void Function(dynamic)? onSelected;
  const CustomerSearchManual({
    super.key,
    required this.controller_,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      controller: controller_,
      suggestionsCallback: (pattern) async {
        return context
            .read<CustmersCubit>()
            .custmers
            .where(
              (custmer) =>
                  custmer.nameCustmer.contains(pattern) ||
                  custmer.nationalId.contains(pattern),
            )
            .map((e) => e.nameCustmer)
            .take(5)
            .toList();
      },
      builder: (context, controller, focusNode) {
        return CustomTextFromField(
          controller: controller,
          focusNode: focusNode,
          labelText: 'اسم الضيف',
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء ادخال اسم الضيف';
            }
            return null;
          },
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSelected: (suggestion) {
        controller_.text = suggestion;
        if (onSelected != null) onSelected!(suggestion);
      },
      emptyBuilder: (context) {
        return const ListTile(
          leading: Icon(Icons.error_outline, color: Colors.redAccent),
          title: Text("لا يوجد نتائج", style: TextStyle(color: Colors.grey)),
        );
      },
    );
  }
}
