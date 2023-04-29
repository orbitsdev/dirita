


import 'package:get/get.dart';


class LanguageTranslation  extends Translations {
  @override
   Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'world': 'World',
        },
        'fr_FR': {
          'hello': 'Bonjour',
          'world': 'le monde',
        },
      };

}