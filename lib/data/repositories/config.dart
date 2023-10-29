// ignore_for_file: unused_local_variable

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

class Config {
  static Future<void> fetchApiKey() async {
    String key = '';
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 10),
        ),
      );
      await remoteConfig.fetchAndActivate();
      key = remoteConfig.getString('API_KEY');
    } catch (e) {
      final logger = Logger();
      logger.e(e);
    }

    const storage = FlutterSecureStorage();
    await storage.write(key: 'API_KEY', value: key);
    String? apiKey = await storage.read(key: 'API_KEY');
  }
}
