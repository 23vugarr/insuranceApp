import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pasha_insurance/constants/strings/local_storage_consts.dart';
import 'package:pasha_insurance/services/service_locator.dart';
import 'package:pasha_insurance/states/custom_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

class MainConfigurations {
  MainConfigurations._();

  static Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    await dotenv.load(fileName: ".env");
    await GetStorage.init(LocalStorageWrapper.userDataContainerName);

    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
    Bloc.observer = CustomBlocObserver();

    ServiceLocator.setup();
  }
}