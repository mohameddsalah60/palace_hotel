import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/views/widgets/custom_drop_down_button_field.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../cubits/rooms_cubit.dart';

class NewRoomBody extends StatelessWidget {
  const NewRoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.read<RoomsCubit>().formController;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        child: Form(
          key: form.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // رقم الغرفة
              CustomTextFromField(
                isReadOnly: context.read<RoomsCubit>().allRooms.any(
                  (room) =>
                      room.roomId.toString() == form.roomIdController.text,
                ),
                controller: form.roomIdController,
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

              // نوع الغرفة
              Customdropdownbuttonfield(
                value: form.selectedType,
                labelText: 'نوع الغرفة',
                items:
                    form.roomTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  form.selectedType = newValue ?? form.selectedType;
                },
                icon: Icons.category_outlined,
              ),
              const SizedBox(height: 16),

              // دور الغرفة
              Customdropdownbuttonfield(
                value: form.selectedFloorRoom,
                labelText: 'دور الغرفة',
                items:
                    form.roomFloors.map((String floor) {
                      return DropdownMenuItem<String>(
                        value: floor,
                        child: Text(floor),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  form.selectedFloorRoom = newValue ?? form.selectedFloorRoom;
                },
                icon: Icons.location_city_outlined,
              ),
              const SizedBox(height: 16),

              // وصف الغرفة
              CustomTextFromField(
                controller: form.descriptionRoomController,
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

              // السعر لكل ليلة
              CustomTextFromField(
                controller: form.priceController,
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

              // حالة الغرفة
              Customdropdownbuttonfield(
                value: form.selectedStatus,
                labelText: 'حالة الغرفة',
                items:
                    form.statuses.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  form.selectedStatus = newValue ?? form.selectedStatus;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
