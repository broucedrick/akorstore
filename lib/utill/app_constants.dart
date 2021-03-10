import 'package:sixvalley_ui_kit/data/repository/language_model.dart';

class AppConstants {
  static const String BASE_URL = 'http://dev.6amtech.com/api/';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';

  // sharePreference
  static const String TOKEN = 'token';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';

  // order status
  static const String PENDING = 'pending';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
