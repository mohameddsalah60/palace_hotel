import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:palace_systeam_managment/features/rooms/presentation/cubits/rooms_cubit.dart';

import 'core/di/getit_service_loacator.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/services/observer_bloc.dart';
import 'core/utils/app_colors.dart';
import 'features/rooms/domin/repos/new_room_repo.dart';
import 'features/rooms/domin/repos/rooms_repo.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await setup();
  await findSystemLocale();
  runApp(const PalaceSysteamManagment());
}

class PalaceSysteamManagment extends StatelessWidget {
  const PalaceSysteamManagment({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageChangedCubit()),
            BlocProvider(
              create:
                  (context) =>
                      RoomsCubit(getIt<RoomsRepo>(), getIt<NewRoomRepo>())
                        ..fetchRooms(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale('ar'),
            supportedLocales: S.delegate.supportedLocales,
            initialRoute: AppRoutes.mainView,
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            title: 'Palace Systeam Managment',
            themeMode: ThemeMode.light,
            theme: ThemeData(
              fontFamily: 'Cairo',
              primaryColor: AppColors.mainBlue,
              scaffoldBackgroundColor: AppColors.wheit,
            ),
          ),
        );
      },
    );
  }
}
