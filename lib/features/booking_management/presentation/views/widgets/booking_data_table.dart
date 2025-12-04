import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/core/entites/booking_entity.dart';
import '../../../../../core/di/getit_service_loacator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../cubits/booking_room_cubit.dart';
import 'booking_confirmation_dialog.dart';

class BookingDataTable extends StatelessWidget {
  const BookingDataTable({super.key, required this.bookingEntity});

  final List<BookingEntity> bookingEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),

        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            color: AppColors.wheit,
          ),
          padding: EdgeInsets.all(16.r),
          child: DataTable(
            showCheckboxColumn: false,
            dataRowMaxHeight: 75.h,
            columnSpacing: 24.w,
            headingRowColor: WidgetStateColor.resolveWith(
              (states) => Colors.grey.shade100,
            ),
            border: TableBorder.all(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.r),
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'رقم الحجز',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'رقم الغرفة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'اسم النزيل',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'تاريخ الوصول',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'تاريخ المغادرة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'عدد الليالي',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'الإجمالي',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'المدفوع',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'الحالة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'طريقة الدفع',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'اسم الموظف',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: List<DataRow>.generate(bookingEntity.length, (index) {
              final booking = bookingEntity[index];
              return DataRow(
                onSelectChanged: (_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: getIt<BookingRoomCubit>()),
                        ],
                        child: BookingConfirmationDialog(booking: booking),
                      );
                    },
                  );
                },
                cells: [
                  DataCell(Text(booking.bookingID.toString())),
                  DataCell(Text(booking.roomID.toString())),
                  DataCell(Text(booking.guestName!)),
                  DataCell(
                    Text(booking.checkInDate.toString().split(' ').first),
                  ),
                  DataCell(
                    Text(booking.checkOutDate.toString().split(' ').first),
                  ),
                  DataCell(Text(booking.nightsCount.toString())),
                  DataCell(Text(booking.totalPrice.toStringAsFixed(2))),
                  DataCell(Text(booking.paidAmount.toString())),
                  DataCell(
                    Text(
                      booking.stutasBooking!,
                      style: TextStyle(
                        color: booking.getStatusColor(booking.stutasBooking!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataCell(Text(booking.paidType)),
                  DataCell(Text(booking.employeeName)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
