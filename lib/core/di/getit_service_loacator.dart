import 'package:get_it/get_it.dart';
import 'package:palace_systeam_managment/features/booking_management/data/repos/booking_repo_impl.dart';
import 'package:palace_systeam_managment/features/booking_management/domin/repos/booking_repo.dart';
import 'package:palace_systeam_managment/features/customers/domin/repos/custmer_repo.dart';
import 'package:palace_systeam_managment/features/rooms/data/repos/new_room_repo_impl.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/booking_room_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../features/customers/data/repos/custmer_repo_impl.dart';
import '../../features/customers/presentation/cubits/custmers_cubit.dart';
import '../../features/rooms/data/repos/rooms_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<NewRoomRepo>(NewRoomRepoImpl());
  getIt.registerSingleton<RoomsRepo>(RoomsRepoImpl());
  getIt.registerSingleton<CustmerRepo>(CustmerRepoImpl());
  getIt.registerSingleton<BookingRepo>(BookingRepoImpl());
  getIt.registerLazySingleton<RoomsCubit>(
    () => RoomsCubit(getIt<RoomsRepo>(), getIt<NewRoomRepo>()),
  );
  getIt.registerLazySingleton<BookingRoomCubit>(
    () => BookingRoomCubit(getIt<BookingRepo>()),
  );

  getIt.registerLazySingleton<CustmersCubit>(
    () => CustmersCubit(getIt<CustmerRepo>()),
  );
}
