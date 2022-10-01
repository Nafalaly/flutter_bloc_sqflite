import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite/pages/dashboard/bloc/dashboard_page_bloc.dart';
import 'package:flutter_bloc_sqflite/pages/pages.dart';
import 'package:flutter_bloc_sqflite/services/connectivity_controller/connectivity_state.dart';
import 'package:flutter_bloc_sqflite/services/services.dart';
import 'package:flutter_bloc_sqflite/services/sqflite/memo/bloc/memo_db_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(
      connection: Connectivity(),
    ));
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.connection}) : super(key: key);
  final Connectivity connection;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ConnectivityCubit(internetAdaptor: connection)),
        BlocProvider(create: (context) => MemoDbBloc()),
        // BlocProvider(create: (context) => EmployeDataCubit()),
        // BlocProvider(create: (context) => CompanyInformationCubit()),
      ],
      child: MaterialApp(
        initialRoute: '/Dashboard',
        routes: {
          // '/SplashScreen': (context) => const SplashScreen(),
          '/Dashboard': (context) => BlocProvider(
                create: (context) => DashboardPageBloc(),
                child: const DashboardPage(),
              ),
          // '/AttendanceDashboard': (context) => const AttendanceMainMenu(),
          // '/AttendanceSubmitPage': (context) => const AttendanceSubmitPage(),
          // '/ProfilePage': (context) => const ProfilePage(),
          // '/LoginPage': (context) => BlocProvider(
          //       create: (context) => LoginPageBloc(
          //           connection: context.read<ConnectivityCubit>(),
          //           accountCubit: context.read<UserAccountCubit>()),
          //       child: const LoginPage(),
          //     ),
        },
        theme: ThemeData(primarySwatch: Colors.blue),
        builder: (context, child) {
          DeviceScreen.setup(context: context);
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            child: child!,
          );
        },
        title: 'Flutter BLOC SQFLITE',
      ),
    );
  }
}
