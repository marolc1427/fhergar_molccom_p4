import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Creat3D'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterButton.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enterButton;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'~ Bring your ideas to life'**
  String get welcomeMessage;

  /// No description provided for @modelTitle.
  ///
  /// In en, this message translates to:
  /// **'3D Models'**
  String get modelTitle;

  /// No description provided for @customFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom Model Request'**
  String get customFormTitle;

  /// No description provided for @nameField.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get nameField;

  /// No description provided for @emailField.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailField;

  /// No description provided for @dateField.
  ///
  /// In en, this message translates to:
  /// **'Preferred date (optional)'**
  String get dateField;

  /// No description provided for @finishField.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishField;

  /// No description provided for @productField.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productField;

  /// No description provided for @detailsField.
  ///
  /// In en, this message translates to:
  /// **'Details / notes'**
  String get detailsField;

  /// No description provided for @carefulPackaging.
  ///
  /// In en, this message translates to:
  /// **'Careful packaging'**
  String get carefulPackaging;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get submitButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @loadingModels.
  ///
  /// In en, this message translates to:
  /// **'Loading models...'**
  String get loadingModels;

  /// No description provided for @noItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found.'**
  String get noItemsFound;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @customModelButton.
  ///
  /// In en, this message translates to:
  /// **'Custom 3D model order'**
  String get customModelButton;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully'**
  String get requestSent;

  /// No description provided for @categoryLabelJuguete.
  ///
  /// In en, this message translates to:
  /// **'Toy'**
  String get categoryLabelJuguete;

  /// No description provided for @categoryLabelDecorativo.
  ///
  /// In en, this message translates to:
  /// **'Decorative'**
  String get categoryLabelDecorativo;

  /// No description provided for @categoryLabelUtil.
  ///
  /// In en, this message translates to:
  /// **'Useful'**
  String get categoryLabelUtil;

  /// No description provided for @item1Title.
  ///
  /// In en, this message translates to:
  /// **'Optimus Prime'**
  String get item1Title;

  /// No description provided for @item1Description.
  ///
  /// In en, this message translates to:
  /// **'Model with joints and various materials.'**
  String get item1Description;

  /// No description provided for @item1Label.
  ///
  /// In en, this message translates to:
  /// **'Toy'**
  String get item1Label;

  /// No description provided for @item2Title.
  ///
  /// In en, this message translates to:
  /// **'Hollow Knight'**
  String get item2Title;

  /// No description provided for @item2Description.
  ///
  /// In en, this message translates to:
  /// **'Main characters from the game Hollow Knight.'**
  String get item2Description;

  /// No description provided for @item2Label.
  ///
  /// In en, this message translates to:
  /// **'Decorative'**
  String get item2Label;

  /// No description provided for @item3Title.
  ///
  /// In en, this message translates to:
  /// **'Star Wars'**
  String get item3Title;

  /// No description provided for @item3Description.
  ///
  /// In en, this message translates to:
  /// **'Star Wars logo for 3D printed decoration.'**
  String get item3Description;

  /// No description provided for @item3Label.
  ///
  /// In en, this message translates to:
  /// **'Decorative'**
  String get item3Label;

  /// No description provided for @item4Title.
  ///
  /// In en, this message translates to:
  /// **'USB Holder'**
  String get item4Title;

  /// No description provided for @item4Description.
  ///
  /// In en, this message translates to:
  /// **'Vertical holder for disks and memory cards.'**
  String get item4Description;

  /// No description provided for @item4Label.
  ///
  /// In en, this message translates to:
  /// **'Useful'**
  String get item4Label;

  /// No description provided for @finishMate.
  ///
  /// In en, this message translates to:
  /// **'Matte'**
  String get finishMate;

  /// No description provided for @finishBrillante.
  ///
  /// In en, this message translates to:
  /// **'Glossy'**
  String get finishBrillante;

  /// No description provided for @finishAptoParaPintura.
  ///
  /// In en, this message translates to:
  /// **'Paintable'**
  String get finishAptoParaPintura;

  /// No description provided for @finishSuaveAlTacto.
  ///
  /// In en, this message translates to:
  /// **'Soft touch'**
  String get finishSuaveAlTacto;

  /// No description provided for @finishTexturizado.
  ///
  /// In en, this message translates to:
  /// **'Textured'**
  String get finishTexturizado;

  /// No description provided for @finishPulido.
  ///
  /// In en, this message translates to:
  /// **'Polished'**
  String get finishPulido;

  /// No description provided for @finishResistenteUV.
  ///
  /// In en, this message translates to:
  /// **'UV Resistant'**
  String get finishResistenteUV;

  /// No description provided for @formNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get formNameRequired;

  /// No description provided for @formNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid last name'**
  String get formNameInvalid;

  /// No description provided for @formEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get formEmailRequired;

  /// No description provided for @formEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get formEmailInvalid;

  /// No description provided for @formFinishRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a finish'**
  String get formFinishRequired;

  /// No description provided for @formProductRequired.
  ///
  /// In en, this message translates to:
  /// **'Please describe the desired product'**
  String get formProductRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
