import 'package:get_it/get_it.dart';
import 'package:palace_systeam_managment/features/rooms/data/repos/new_room_repo_impl.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/new_room_repo.dart';
import 'package:palace_systeam_managment/features/rooms/domin/repos/rooms_repo.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import '../../features/rooms/data/repos/rooms_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<NewRoomRepo>(NewRoomRepoImpl());
  getIt.registerSingleton<RoomsRepo>(RoomsRepoImpl());
  getIt.registerLazySingleton<RoomsCubit>(
    () => RoomsCubit(getIt<RoomsRepo>(), getIt<NewRoomRepo>()),
  );
}
