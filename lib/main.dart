import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_systeam_managment/features/home/presentation/cubits/page_changed_cubit.dart';

import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/utils/app_colors.dart';
import 'generated/l10n.dart';

void main() {
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
        return BlocProvider(
          create: (context) => PageChangedCubit(),
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
