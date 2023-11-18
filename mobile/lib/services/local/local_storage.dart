import 'package:get_storage/get_storage.dart';
import 'package:pasha_insurance/constants/strings/local_storage_consts.dart';

class LocalStorage extends LocalStorageWrapper {
  late final GetStorage _userDataContainer;

  LocalStorage() {
    _userDataContainer = GetStorage(LocalStorageWrapper.userDataContainerName);
  }

  Future<void> writeAccessToken(String value) async => await _userDataContainer.write(KEY_ACCESS_TOKEN, value);
  String? _readAccessToken() => _userDataContainer.read(KEY_ACCESS_TOKEN);

  Future<void> clearAllData() async {
    await clearUserData();
  }
  Future<void> clearUserData() async => await _userDataContainer.erase();

  String? get accessToken => _readAccessToken();
}