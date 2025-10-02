import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sr.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('sr'),
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Flutter Huevo Pro'**
  String get appName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteMyAccount;

  /// No description provided for @deleteMyAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account forever? It can take up to 60 days.'**
  String get deleteMyAccountConfirmation;

  /// No description provided for @requestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Request submitted'**
  String get requestSubmitted;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to continue'**
  String get signUpTitle;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get errorWrongPassword;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'We have blocked all requests from this device due to unusual activity. Please try again later.'**
  String get errorTooManyRequests;

  /// No description provided for @errorInvalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get errorInvalidEmailAddress;

  /// No description provided for @errorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get errorEmailAlreadyInUse;

  /// No description provided for @errorAccountNotExist.
  ///
  /// In en, this message translates to:
  /// **'Account not exist'**
  String get errorAccountNotExist;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password should be at least 6 characters'**
  String get errorWeakPassword;

  /// No description provided for @errorUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please try again later.'**
  String get errorUnknownError;

  /// No description provided for @listIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'List is empty'**
  String get listIsEmpty;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'Subtitle'**
  String get subtitle;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @addAnArticle.
  ///
  /// In en, this message translates to:
  /// **'Add an Article'**
  String get addAnArticle;

  /// No description provided for @forgotYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotYourPassword;

  /// No description provided for @forgotYourPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you a link to reset your password.'**
  String get forgotYourPasswordDescription;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Reset password email sent'**
  String get resetPasswordEmailSent;

  /// No description provided for @connectivity.
  ///
  /// In en, this message translates to:
  /// **'Connectivity'**
  String get connectivity;

  /// No description provided for @pro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get pro;

  /// No description provided for @unlockPro.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro'**
  String get unlockPro;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get restorePurchase;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @appReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying the app?'**
  String get appReviewTitle;

  /// No description provided for @appReviewDescription.
  ///
  /// In en, this message translates to:
  /// **'If you enjoy using this app, please leave a review. It means a lot to us.'**
  String get appReviewDescription;

  /// No description provided for @leaveYourReview.
  ///
  /// In en, this message translates to:
  /// **'Leave Your Review'**
  String get leaveYourReview;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @pickAnImage.
  ///
  /// In en, this message translates to:
  /// **'Pick an image'**
  String get pickAnImage;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @confirmTheImage.
  ///
  /// In en, this message translates to:
  /// **'Confirm the image'**
  String get confirmTheImage;

  /// No description provided for @imageSaved.
  ///
  /// In en, this message translates to:
  /// **'Image saved'**
  String get imageSaved;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// No description provided for @localNotifications.
  ///
  /// In en, this message translates to:
  /// **'Local Notifications'**
  String get localNotifications;

  /// No description provided for @localNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Shows a local notification.'**
  String get localNotificationsDescription;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @remoteNotifications.
  ///
  /// In en, this message translates to:
  /// **'Remote Notifications'**
  String get remoteNotifications;

  /// No description provided for @remoteNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Shows a remote notification after 10 seconds.'**
  String get remoteNotificationsDescription;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @onboardingExplanationTitle1.
  ///
  /// In en, this message translates to:
  /// **'Launch Your App in Days'**
  String get onboardingExplanationTitle1;

  /// No description provided for @onboardingExplanationSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Build your iOS, Android, and web apps in days, not weeks. Auth, payments, and more ready out of the box.'**
  String get onboardingExplanationSubtitle1;

  /// No description provided for @onboardingExplanationTitle2.
  ///
  /// In en, this message translates to:
  /// **'Scalable by Default'**
  String get onboardingExplanationTitle2;

  /// No description provided for @onboardingExplanationSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Clean architecture, Firebase backend, and modular code built for long-term success.'**
  String get onboardingExplanationSubtitle2;

  /// No description provided for @onboardingExplanationTitle3.
  ///
  /// In en, this message translates to:
  /// **'Focus on What Matters'**
  String get onboardingExplanationTitle3;

  /// No description provided for @onboardingExplanationSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Skip the boilerplate and ship features. All the essentials are already done.'**
  String get onboardingExplanationSubtitle3;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'What can we help you with?'**
  String get onboardingGoalTitle;

  /// No description provided for @goalHaveFun.
  ///
  /// In en, this message translates to:
  /// **'Have Fun'**
  String get goalHaveFun;

  /// No description provided for @goalHaveFunDescription.
  ///
  /// In en, this message translates to:
  /// **'Got it. Let\'s have fun building apps!'**
  String get goalHaveFunDescription;

  /// No description provided for @goalLearnFlutterAndFirebase.
  ///
  /// In en, this message translates to:
  /// **'Learn Flutter and Firebase'**
  String get goalLearnFlutterAndFirebase;

  /// No description provided for @goalLearnFlutterAndFirebaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Perfect. This template has everything you need to learn Flutter and Firebase.'**
  String get goalLearnFlutterAndFirebaseDescription;

  /// No description provided for @goalBuildAppPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Build an App Portfolio'**
  String get goalBuildAppPortfolio;

  /// No description provided for @goalBuildAppPortfolioDescription.
  ///
  /// In en, this message translates to:
  /// **'Awesome! This template will speed up your app portfolio creation.'**
  String get goalBuildAppPortfolioDescription;

  /// No description provided for @goalGetJob.
  ///
  /// In en, this message translates to:
  /// **'Get a Job'**
  String get goalGetJob;

  /// No description provided for @goalGetJobDescription.
  ///
  /// In en, this message translates to:
  /// **'Great. This template will show you how to build a real-world app with Flutter and Firebase.'**
  String get goalGetJobDescription;

  /// No description provided for @canSelectMultipleLabel.
  ///
  /// In en, this message translates to:
  /// **'Select as many as you like'**
  String get canSelectMultipleLabel;

  /// No description provided for @onboardingPreparationTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalizing your experience'**
  String get onboardingPreparationTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Huevo\nPRO'**
  String get welcomeTitle;

  /// No description provided for @welcomeProof1.
  ///
  /// In en, this message translates to:
  /// **'by\n'**
  String get welcomeProof1;

  /// No description provided for @welcomeProof2.
  ///
  /// In en, this message translates to:
  /// **'Flutter Tech Lead and\n\$100K App Founder'**
  String get welcomeProof2;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;
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
      <String>['en', 'sr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'sr':
      {
        switch (locale.scriptCode) {
          case 'Latn':
            return AppLocalizationsSrLatn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
