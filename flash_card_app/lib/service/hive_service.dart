import 'package:hive/hive.dart';

class HiveService {
  static HiveService? _instance;
  static HiveService get instance {
    _instance ??= HiveService._();
    return _instance!;
  }

  HiveService._();

  _save(String boxKey, String key, dynamic value) async {
    await Hive.box(boxKey).put(key, value);
  }

  dynamic _read(String boxKey, String key) {
    return Hive.box(boxKey).get(key);
  }

  saveLanguageSpeech(String language) {
    _save("user_box", "language", language);
  }

  readLanguageSpeech() {
    return _read("user_box", "language");
  }

  saveEngineSpeech(String engine) {
    _save("user_box", "engine", engine);
  }

  String? readEngineSpeech() {
    return _read("user_box", "engine");
  }
}
