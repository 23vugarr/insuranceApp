import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pasha_insurance/mappers/car_mapper.dart';
import 'package:pasha_insurance/mappers/report_mapper.dart';
import 'package:pasha_insurance/mappers/tokens_mapper.dart';
import 'package:pasha_insurance/mappers/user_mapper.dart';
import 'package:pasha_insurance/services/API/authentication_service.dart';
import 'package:pasha_insurance/services/API/user_service.dart';
import 'package:pasha_insurance/services/API/account_service.dart';
import 'package:pasha_insurance/services/API/interceptors/auth_interceptor_wrapper.dart';
import 'package:pasha_insurance/services/file_picker_service.dart';
import 'package:pasha_insurance/services/local/local_storage.dart';
import 'package:pasha_insurance/utils/app_router.dart';

final locator = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  
  static void setup() {
    locator.registerLazySingleton<Dio>(() => Dio());
    locator.registerLazySingleton<AuthInterceptorsWrapper>(() => AuthInterceptorsWrapper());
    locator.registerLazySingleton<LocalStorage>(() => LocalStorage());
    locator.registerLazySingleton<AppRouter>(() => AppRouter());
    locator.registerLazySingleton<FilePickerService>(() => FilePickerService());
    
    locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
    locator.registerLazySingleton<AccountService>(() => AccountService());
    locator.registerLazySingleton<UserService>(() => UserService());

    locator.registerLazySingleton<TokensMapper>(() => TokensMapper());
    locator.registerLazySingleton<UserMapper>(() => UserMapper());
    locator.registerLazySingleton<CarMapper>(() => CarMapper());
    locator.registerLazySingleton<ReportMapper>(() => ReportMapper());
  }
}