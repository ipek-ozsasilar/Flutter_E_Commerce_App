import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class secureStorageSetUp {
  secureStorageSetup(){}

  FlutterSecureStorage? storage;
  Future<void> setUp() async {
     storage = const FlutterSecureStorage();
    
  }
  
}