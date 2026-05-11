// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Inventory Management';

  @override
  String get hello => 'Hello';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginDescription =>
      'Continue with Google to access inventory system.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get loginSuccess => 'Login success';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get inventoryDescription =>
      'Modern warehouse inventory management powered by Firebase';
}
