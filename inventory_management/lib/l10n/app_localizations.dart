import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management'**
  String get appName;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google to access inventory system.'**
  String get loginDescription;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login success'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @inventoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Modern warehouse inventory management powered by Firebase'**
  String get inventoryDescription;

  /// No description provided for @dashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management Dashboard'**
  String get dashboardDescription;

  /// No description provided for @receipts.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get receipts;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @inventoryManager.
  ///
  /// In en, this message translates to:
  /// **'Inventory Manager'**
  String get inventoryManager;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @chooseReceiptType.
  ///
  /// In en, this message translates to:
  /// **'Choose Receipt Type'**
  String get chooseReceiptType;

  /// No description provided for @chooseReceiptTypeDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the type of receipt you want to create.'**
  String get chooseReceiptTypeDescription;

  /// No description provided for @inventoryReceipt.
  ///
  /// In en, this message translates to:
  /// **'Inventory Receipt'**
  String get inventoryReceipt;

  /// No description provided for @inventoryReceiptDescription.
  ///
  /// In en, this message translates to:
  /// **'Create warehouse import receipt.'**
  String get inventoryReceiptDescription;

  /// No description provided for @productsPage.
  ///
  /// In en, this message translates to:
  /// **'Products Page'**
  String get productsPage;

  /// No description provided for @profilePage.
  ///
  /// In en, this message translates to:
  /// **'Profile Page'**
  String get profilePage;

  /// No description provided for @searchReceiptHint.
  ///
  /// In en, this message translates to:
  /// **'Search receipt number...'**
  String get searchReceiptHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @receiptTableComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Receipt table coming soon'**
  String get receiptTableComingSoon;

  /// No description provided for @receiptTableReceiptNo.
  ///
  /// In en, this message translates to:
  /// **'Receipt No'**
  String get receiptTableReceiptNo;

  /// No description provided for @receiptTableDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get receiptTableDate;

  /// No description provided for @receiptTableWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get receiptTableWarehouse;

  /// No description provided for @receiptTableDeliveredBy.
  ///
  /// In en, this message translates to:
  /// **'Delivered By'**
  String get receiptTableDeliveredBy;

  /// No description provided for @receiptTableTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get receiptTableTotal;

  /// No description provided for @receiptTableAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get receiptTableAction;

  /// No description provided for @receiptTableView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get receiptTableView;

  /// No description provided for @receiptTableShowingRange.
  ///
  /// In en, this message translates to:
  /// **'Showing {start} - {end} of {total}'**
  String receiptTableShowingRange(Object start, Object end, Object total);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
