import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/constants/strings/app_router_consts.dart';
import 'package:pasha_insurance/models/data/car_model.dart';
import 'package:pasha_insurance/models/data/report_model.dart';
import 'package:pasha_insurance/states/bloc/auth/auth_bloc.dart';
import 'package:pasha_insurance/ui/screens/auth/sign_in_screen.dart';
import 'package:pasha_insurance/ui/screens/auth/sign_up_screen.dart';
import 'package:pasha_insurance/ui/screens/car_details_screen.dart';
import 'package:pasha_insurance/ui/screens/home/home_screen.dart';
import 'package:pasha_insurance/ui/screens/error/no_route_defined_screen.dart';
import 'package:pasha_insurance/ui/screens/report_damage_screen.dart';
import 'package:pasha_insurance/ui/screens/report_results_screen.dart';
import 'package:pasha_insurance/ui/screens/select_accident_location_screen.dart';
import 'package:pasha_insurance/utils/helpers/app_router_refresh_stream.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GoRouter router(BuildContext context) {
    return GoRouter(
      navigatorKey: navigatorKey,
      refreshListenable: _refreshListenable(context),
      redirect: _redirect,
      initialLocation: AppRouterConsts.homePath,
      routes: [
        GoRoute(
          path: AppRouterConsts.homePath,
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomeScreen());
          },
        ),
        GoRoute(
          path: AppRouterConsts.signInPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SignInScreen());
          },
        ),
        GoRoute(
          path: AppRouterConsts.signUpPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SignUpScreen());
          },
        ),
        GoRoute(
          path: AppRouterConsts.carDetailsPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: CarDetailsScreen(carModel: CarModel.fromJson(state.extra as Map<String, dynamic>)));
          },
        ),
        GoRoute(
          path: AppRouterConsts.reportDamagedCarPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: ReportDamageScreen(file: state.extra as File));
          },
        ),
        GoRoute(
          path: AppRouterConsts.selectAccidentLocationPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SelectAccidentLocationScreen(needToCallEvacuator: (state.extra as Map<String, dynamic>)['needToCallEvacuator']));
          },
        ),
        GoRoute(
          path: AppRouterConsts.reportResultsPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: ReportResultsScreen(reportModel: ReportModel.fromJson((state.extra as Map<String, dynamic>)['reportModel']), carModel: CarModel.fromJson((state.extra as Map<String, dynamic>)['carModel'])));
          },
        ),
      ],
      errorPageBuilder: _errorPageBuilder,
    );
  }

  AppRouterRefreshStream<AuthState> _refreshListenable(BuildContext context) {
    // refresh only if:
    //  1) Authorized
    //  2) NotAuthorized, only when:
    //    - caused by sign-out
    //    - caused by refresh-token
    return AppRouterRefreshStream<AuthState>(
      context.read<AuthBloc>().stream, 
      initValue: context.read<AuthBloc>().state,
      shouldNotify: (prevState, curState) => curState is AuthorizedState 
        || (curState is NotAuthorizedState && (prevState is AuthorizedState || (prevState is FailedAuthorizationState)))
    );
  }

  Page<dynamic> _errorPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(child: NoRouteDefinedScreen(state: state));
  }

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final bool shouldWorry = context.read<AuthBloc>().state is AuthorizedState || context.read<AuthBloc>().state is NotAuthorizedState;
    if (!shouldWorry) return null;

    final bool isLoggedIn = context.read<AuthBloc>().state is AuthorizedState;
    final bool isOnAuthPath = [AppRouterConsts.signInPath, AppRouterConsts.signUpPath].contains(state.fullPath); //? or matchedLocation

    if (isOnAuthPath) {
      if (isLoggedIn) {
        // if the user is on the auth path and logged in, redirect to main screen
        return AppRouterConsts.homePath;
      } else {
        // if the user is on auth path but not logged in, no need to redirect
        return null;
      }
    } else {
      if (isLoggedIn) {
        // if the user is not on auth path but logged in, no need for redirect
        return null;
      } else {
        // if the user is not on auth path and not logged in, redirect to sin-in screen
        return AppRouterConsts.signInPath;
      }
    }
  }
}