import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasha_insurance/config/theme/app_themes.dart';
import 'package:pasha_insurance/constants/strings/local_consts.dart';
import 'package:pasha_insurance/services/API/interceptors/auth_interceptor_wrapper.dart';
import 'package:pasha_insurance/services/service_locator.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:pasha_insurance/states/provider/car_state.dart';
import 'package:pasha_insurance/states/provider/account_state.dart';
import 'package:pasha_insurance/states/provider/report_state.dart';
import 'package:pasha_insurance/states/provider/select_location_state.dart';
import 'package:pasha_insurance/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PashaInsurance extends StatelessWidget {
  const PashaInsurance({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ChangeNotifierProvider<AccountState>(create: (context) => AccountState()),
        ChangeNotifierProvider<CarState>(create: (context) => CarState()),
        ChangeNotifierProvider<ReportState>(create: (context) => ReportState()),
        ChangeNotifierProvider<SelectLocationState>(create: (context) => SelectLocationState()),
      ],
      child: Builder(
        builder: (context) {
          locator<AuthInterceptorsWrapper>().init(context);
          
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: LocalConsts.kAppTitle,
            themeMode: ThemeMode.light,
            theme: AppThemes.light(context),
            darkTheme: AppThemes.dark(context),
            routerConfig: locator<AppRouter>().router(context),
            // routeInformationParser: locator<AppRouter>().router(context).routeInformationParser,
            // routeInformationProvider: locator<AppRouter>().router(context).routeInformationProvider,
          );
        }
      ),
    );
  }
}