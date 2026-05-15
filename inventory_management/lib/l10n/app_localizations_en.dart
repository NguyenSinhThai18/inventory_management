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
  String get loginDescription => 'Continue with Google to access inventory system.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get loginSuccess => 'Login success';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get inventoryDescription => 'Modern warehouse inventory management powered by Firebase';

  @override
  String get dashboardDescription => 'Inventory Management Dashboard';

  @override
  String get receipts => 'Receipts';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get products => 'Products';

  @override
  String get profile => 'Profile';

  @override
  String get inventoryManager => 'Inventory Manager';

  @override
  String get create => 'Create';

  @override
  String get chooseReceiptType => 'Choose Receipt Type';

  @override
  String get chooseReceiptTypeDescription => 'Select the type of receipt you want to create.';

  @override
  String get inventoryReceipt => 'Inventory Receipt';

  @override
  String get inventoryReceiptDescription => 'Create warehouse import receipt.';

  @override
  String get productsPage => 'Products Page';

  @override
  String get profilePage => 'Profile Page';

  @override
  String get searchReceiptHint => 'Search receipt number...';

  @override
  String get filter => 'Filter';

  @override
  String get upload => 'Upload';

  @override
  String get scan => 'Scan';

  @override
  String get receiptTableComingSoon => 'Receipt table coming soon';

  @override
  String get receiptTableReceiptNo => 'Receipt No';

  @override
  String get receiptTableDate => 'Date';

  @override
  String get receiptTableWarehouse => 'Warehouse';

  @override
  String get receiptTableDeliveredBy => 'Delivered By';

  @override
  String get receiptTableTotal => 'Total';

  @override
  String get receiptTableAction => 'Action';

  @override
  String get receiptTableView => 'View';

  @override
  String receiptTableShowingRange(Object start, Object end, Object total) {
    return 'Showing $start - $end of $total';
  }
}
