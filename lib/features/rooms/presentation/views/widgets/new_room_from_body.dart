import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../cubits/rooms_cubit.dart';

class NewRoomBody extends StatelessWidget {
  const NewRoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        child: Form(
          key: context.read<RoomsCubit>().formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFromField(
                controller: context.read<RoomsCubit>().roomIdController,
                keyboardType: TextInputType.number,
                labelText: 'رقم الغرفة',
                icon: Icons.meeting_room_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (double.tryParse(value) == null) {
                    return 'ممنوع كتابة نص، فقط أرقام';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // حقل نوع الغرفة
              CustomTextFromField(
                controller: context.read<RoomsCubit>().typeRoomController,
                labelText: 'نوع الغرفة',
                icon: Icons.category_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // حقل الطابق
              CustomTextFromField(
                controller: context.read<RoomsCubit>().floorRoomController,
                keyboardType: TextInputType.number,
                labelText: 'الطابق',
                icon: Icons.apartment_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              // حقل الوصف
              CustomTextFromField(
                controller:
                    context.read<RoomsCubit>().descriptionRoomController,
                labelText: 'وصف الغرفة',
                icon: Icons.description_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // حقل السعر
              CustomTextFromField(
                controller: context.read<RoomsCubit>().priceController,
                keyboardType: TextInputType.number,
                labelText: 'السعر لكل ليلة',
                icon: Icons.attach_money_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (double.tryParse(value) == null) {
                    return 'ممنوع كتابة نص، فقط أرقام';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: context.read<RoomsCubit>().selectedStatus,
                decoration: InputDecoration(
                  labelText: 'الحالة',
                  prefixIcon: Icon(
                    Icons.info_outline,
                    color: AppColors.greyDark,
                  ),
                  fillColor: AppColors.greyBorder,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.mainBlue,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                items:
                    context.read<RoomsCubit>().statuses.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  context.read<RoomsCubit>().setSelectedStatus(newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
