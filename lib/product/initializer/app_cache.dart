import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Secure Storage instance set up for caching data
class secureStorageSetUp {
  secureStorageSetup() {}

  FlutterSecureStorage? storage;
  Future<void> setUp() async {
    storage = const FlutterSecureStorage();
  }
}
