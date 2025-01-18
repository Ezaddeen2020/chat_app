import 'package:chatapp/data/models/preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:mc_utils/mc_utils.dart';

class LocaleController extends GetxController {
  Locale? language;

  changelang(String langcode) {
    Locale locale = Locale(langcode);
    Preferences.setString(Preferences.language, langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = Preferences.getString(Preferences.language);
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
