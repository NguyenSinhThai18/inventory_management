// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Quản lý nhập kho';

  @override
  String get hello => 'Xin chào';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Huỷ';

  @override
  String get welcomeBack => 'Chào mừng';

  @override
  String get loginDescription =>
      'Tiếp tục với Google để truy cập hệ thống quản lý kho.';

  @override
  String get continueWithGoogle => 'Tiếp tục với Google';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get loginFailed => 'Đăng nhập thất bại';

  @override
  String get inventoryDescription =>
      'Hệ thống quản lý kho hiện đại sử dụng Firebase';
}
