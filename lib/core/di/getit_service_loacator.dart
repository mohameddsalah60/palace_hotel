import 'package:get_it/get_it.dart';
import 'package:palace_systeam_managment/core/services/auth_service.dart';
import 'package:palace_systeam_managment/core/services/firebase_auth_service.dart';
import 'package:palace_systeam_managment/features/auth/data/repos/auth_repo_impl.dart';
import 'package:palace_systeam_managment/features/auth/domin/repo/auth_repo.dart';
import 'package:palace_systeam_managment/features/booking_management/data/repos/booking_repo_impl.dart';
import 'package:palace_systeam_managment/features/booking_management/domin/repos/booking_repo.dart';
import 'package:palace_systeam_managment/features/customers/domin/repos/custmer_repo.dart';
import 'package:palace_systeam_managment/features/rooms/data/repos/new_room_repo_impl.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/booking_management/presentation/cubits/booking_room_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/extend_the_stay_cubit.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../features/customers/data/repos/custmer_repo_impl.dart';
import '../../features/customers/presentation/cubits/custmers_cubit.dart';
import '../../features/rooms/data/repos/rooms_repo_impl.dart';
import '../services/database_service.dart';
import '../services/firestore_service.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthService>(FirebaseAuthService());
  getIt.registerSingleton<NewRoomRepo>(
    NewRoomRepoImpl(databaseService: getIt<DatabaseService>()),
  );
  getIt.registerSingleton<RoomsRepo>(
    RoomsRepoImpl(databaseService: getIt<DatabaseService>()),
  );
  getIt.registerSingleton<CustmerRepo>(
    CustmerRepoImpl(databaseService: getIt<DatabaseService>()),
  );
  getIt.registerSingleton<BookingRepo>(
    BookingRepoImpl(databaseService: getIt<DatabaseService>()),
  );
  getIt.registerFactory<RoomsCubit>(
    () => RoomsCubit(getIt<RoomsRepo>(), getIt<NewRoomRepo>()),
  );
  getIt.registerLazySingleton<ExtendTheStayCubit>(
    () => ExtendTheStayCubit(getIt<BookingRepo>()),
  );
  getIt.registerLazySingleton<BookingRoomCubit>(
    () => BookingRoomCubit(getIt<BookingRepo>()),
  );

  getIt.registerLazySingleton<CustmersCubit>(
    () => CustmersCubit(getIt<CustmerRepo>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authService: getIt<AuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
