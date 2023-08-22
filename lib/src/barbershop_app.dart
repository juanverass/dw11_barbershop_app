import 'package:dw_barbersho/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbersho/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbersho/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbersho/src/features/adm/home_adm_page.dart';
import 'package:dw_barbersho/src/features/auth/login/login_page.dart';
import 'package:dw_barbersho/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:dw_barbersho/src/features/auth/register/user/user_register_page.dart';
import 'package:dw_barbersho/src/features/employee/employee_register_page.dart';
import 'package:dw_barbersho/src/features/employee/home/home_employee_page.dart';
import 'package:dw_barbersho/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:dw_barbersho/src/features/schedule/schedule_page.dart';

import 'package:dw_barbersho/src/features/splash/splash/splash_page.dart';

import 'package:flutter/material.dart';
import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DW Barbershop',
          theme: BarbershopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.navkey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),

            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const HomeEmployeePage(),

            '/employee/register': (_) => const EmployeeRegisterPage(),
            '/employee/schedule': (_) => const EmployeeSchedulePage(),
            '/schedule': (_) => const SchedurePage(),
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          locale: const Locale('pt', 'BR'),
        );
      },
    );
  }
}
