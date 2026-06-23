import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

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
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'CareBridge'**
  String get appName;

  /// No description provided for @caregiverMode.
  ///
  /// In en, this message translates to:
  /// **'Caregiver mode'**
  String get caregiverMode;

  /// No description provided for @parentMode.
  ///
  /// In en, this message translates to:
  /// **'Parent mode'**
  String get parentMode;

  /// No description provided for @switchMode.
  ///
  /// In en, this message translates to:
  /// **'Switch user mode'**
  String get switchMode;

  /// No description provided for @switchProfile.
  ///
  /// In en, this message translates to:
  /// **'Switch care profile'**
  String get switchProfile;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @caregiverDashboard.
  ///
  /// In en, this message translates to:
  /// **'Caregiver dashboard'**
  String get caregiverDashboard;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, Sharif'**
  String get goodMorning;

  /// No description provided for @careSummary.
  ///
  /// In en, this message translates to:
  /// **'Here is today’s family care summary.'**
  String get careSummary;

  /// No description provided for @medicinesDue.
  ///
  /// In en, this message translates to:
  /// **'Medicines due'**
  String get medicinesDue;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get needsAttention;

  /// No description provided for @upcomingVisit.
  ///
  /// In en, this message translates to:
  /// **'Upcoming visit'**
  String get upcomingVisit;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All morning medicines are taken.'**
  String get allCaughtUp;

  /// No description provided for @medicineLibrary.
  ///
  /// In en, this message translates to:
  /// **'Medicine library'**
  String get medicineLibrary;

  /// No description provided for @medicineDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedules, stock, and adherence will live here.'**
  String get medicineDescription;

  /// No description provided for @healthOverview.
  ///
  /// In en, this message translates to:
  /// **'Health overview'**
  String get healthOverview;

  /// No description provided for @healthDescription.
  ///
  /// In en, this message translates to:
  /// **'Vitals, check-ins, and the family timeline will live here.'**
  String get healthDescription;

  /// No description provided for @documentVault.
  ///
  /// In en, this message translates to:
  /// **'Document vault'**
  String get documentVault;

  /// No description provided for @documentDescription.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions and reports will stay securely organized here.'**
  String get documentDescription;

  /// No description provided for @moreCareTools.
  ///
  /// In en, this message translates to:
  /// **'More care tools'**
  String get moreCareTools;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get emergencyContacts;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @designSystem.
  ///
  /// In en, this message translates to:
  /// **'Design system'**
  String get designSystem;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @bangla.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get bangla;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @extraLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra large'**
  String get extraLarge;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @myMedicines.
  ///
  /// In en, this message translates to:
  /// **'My medicines'**
  String get myMedicines;

  /// No description provided for @logVitals.
  ///
  /// In en, this message translates to:
  /// **'Log vitals'**
  String get logVitals;

  /// No description provided for @callCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Call Sharif'**
  String get callCaregiver;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help'**
  String get needHelp;

  /// No description provided for @nextMedicine.
  ///
  /// In en, this message translates to:
  /// **'Next medicine at 8:00 PM'**
  String get nextMedicine;

  /// No description provided for @parentGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning, Father'**
  String get parentGreeting;

  /// No description provided for @parentPrompt.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do?'**
  String get parentPrompt;

  /// No description provided for @backToCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Back to caregiver mode'**
  String get backToCaregiver;

  /// No description provided for @accessibilitySettings.
  ///
  /// In en, this message translates to:
  /// **'Accessibility settings'**
  String get accessibilitySettings;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'This page is not available.'**
  String get pageNotFound;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Care that connects hearts, every day.'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Manage medicines, reminders, appointments, and emergency support for the people who matter most.'**
  String get welcomeBody;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordRequirement.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get passwordRequirement;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get signInTitle;

  /// No description provided for @signInBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue caring for your family.'**
  String get signInBody;

  /// No description provided for @recoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get recoveryTitle;

  /// No description provided for @recoveryBody.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a private reset link if this email belongs to an account.'**
  String get recoveryBody;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists, a reset link has been sent.'**
  String get resetLinkSent;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verificationTitle;

  /// No description provided for @verificationBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your email. For this demo, use 123456.'**
  String get verificationBody;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'That code is invalid or expired.'**
  String get invalidCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent.'**
  String get codeResent;

  /// No description provided for @consentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your care data, your choice'**
  String get consentTitle;

  /// No description provided for @consentBody.
  ///
  /// In en, this message translates to:
  /// **'Review what CareBridge stores and how your family can access it.'**
  String get consentBody;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms and Privacy Policy.'**
  String get acceptTerms;

  /// No description provided for @healthDataConsent.
  ///
  /// In en, this message translates to:
  /// **'I consent to storing health and medicine information.'**
  String get healthDataConsent;

  /// No description provided for @notificationConsent.
  ///
  /// In en, this message translates to:
  /// **'I want reminder and care notifications.'**
  String get notificationConsent;

  /// No description provided for @requiredConsent.
  ///
  /// In en, this message translates to:
  /// **'Accept the required choices to continue.'**
  String get requiredConsent;

  /// No description provided for @finishSetup.
  ///
  /// In en, this message translates to:
  /// **'Finish setup'**
  String get finishSetup;

  /// No description provided for @accountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account and security'**
  String get accountSecurity;

  /// No description provided for @privacyAndData.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data'**
  String get privacyAndData;

  /// No description provided for @twoFactor.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get twoFactor;

  /// No description provided for @twoFactorDescription.
  ///
  /// In en, this message translates to:
  /// **'Require a second verification step when signing in.'**
  String get twoFactorDescription;

  /// No description provided for @biometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Biometric app unlock'**
  String get biometricUnlock;

  /// No description provided for @biometricDescription.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID, Touch ID, or device biometrics.'**
  String get biometricDescription;

  /// No description provided for @yourDevices.
  ///
  /// In en, this message translates to:
  /// **'Your devices'**
  String get yourDevices;

  /// No description provided for @thisDevice.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get thisDevice;

  /// No description provided for @currentDevice.
  ///
  /// In en, this message translates to:
  /// **'Current device'**
  String get currentDevice;

  /// No description provided for @revoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get revoke;

  /// No description provided for @deviceRevoked.
  ///
  /// In en, this message translates to:
  /// **'Device access revoked'**
  String get deviceRevoked;

  /// No description provided for @logoutAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Log out from all devices'**
  String get logoutAllDevices;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This will end every CareBridge session, including this one.'**
  String get logoutConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out everywhere'**
  String get confirmLogout;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export my data'**
  String get exportData;

  /// No description provided for @exportDescription.
  ///
  /// In en, this message translates to:
  /// **'Prepare a secure copy of your CareBridge account data.'**
  String get exportDescription;

  /// No description provided for @requestExport.
  ///
  /// In en, this message translates to:
  /// **'Request export'**
  String get requestExport;

  /// No description provided for @exportQueued.
  ///
  /// In en, this message translates to:
  /// **'Your export request is queued.'**
  String get exportQueued;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccount;

  /// No description provided for @deleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account after a safety review period.'**
  String get deleteDescription;

  /// No description provided for @deleteWarning.
  ///
  /// In en, this message translates to:
  /// **'Account deletion cannot be undone after the review period.'**
  String get deleteWarning;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Request account deletion'**
  String get confirmDelete;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your family care circle'**
  String get onboardingTitle;

  /// No description provided for @onboardingIntro.
  ///
  /// In en, this message translates to:
  /// **'Set up the people you care for and invite someone you trust to help.'**
  String get onboardingIntro;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Family group name'**
  String get familyName;

  /// No description provided for @familyNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example, Sharif Family Care'**
  String get familyNameHint;

  /// No description provided for @whoDoYouCareFor.
  ///
  /// In en, this message translates to:
  /// **'Who do you care for?'**
  String get whoDoYouCareFor;

  /// No description provided for @addFather.
  ///
  /// In en, this message translates to:
  /// **'Add Father'**
  String get addFather;

  /// No description provided for @addMother.
  ///
  /// In en, this message translates to:
  /// **'Add Mother'**
  String get addMother;

  /// No description provided for @inviteCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Invite another caregiver'**
  String get inviteCaregiver;

  /// No description provided for @inviteCaregiverBody.
  ///
  /// In en, this message translates to:
  /// **'They can help with selected care tasks after accepting.'**
  String get inviteCaregiverBody;

  /// No description provided for @inviteEmail.
  ///
  /// In en, this message translates to:
  /// **'Caregiver email (optional)'**
  String get inviteEmail;

  /// No description provided for @secondaryCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Secondary caregiver'**
  String get secondaryCaregiver;

  /// No description provided for @permissionPreview.
  ///
  /// In en, this message translates to:
  /// **'Permission preview'**
  String get permissionPreview;

  /// No description provided for @manageMedicines.
  ///
  /// In en, this message translates to:
  /// **'Manage medicines'**
  String get manageMedicines;

  /// No description provided for @manageDocuments.
  ///
  /// In en, this message translates to:
  /// **'Manage documents'**
  String get manageDocuments;

  /// No description provided for @manageAppointments.
  ///
  /// In en, this message translates to:
  /// **'Manage appointments'**
  String get manageAppointments;

  /// No description provided for @manageEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage emergency contacts'**
  String get manageEmergencyContacts;

  /// No description provided for @reviewFamily.
  ///
  /// In en, this message translates to:
  /// **'Review your care circle'**
  String get reviewFamily;

  /// No description provided for @createFamily.
  ///
  /// In en, this message translates to:
  /// **'Create family'**
  String get createFamily;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(int current, int total);

  /// No description provided for @manageFamily.
  ///
  /// In en, this message translates to:
  /// **'Manage family'**
  String get manageFamily;

  /// No description provided for @membersAndRoles.
  ///
  /// In en, this message translates to:
  /// **'Members and roles'**
  String get membersAndRoles;

  /// No description provided for @pendingInvitations.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get pendingInvitations;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @dependent.
  ///
  /// In en, this message translates to:
  /// **'Dependent'**
  String get dependent;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @revoked.
  ///
  /// In en, this message translates to:
  /// **'Revoked'**
  String get revoked;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @editPermissions.
  ///
  /// In en, this message translates to:
  /// **'Edit permissions'**
  String get editPermissions;

  /// No description provided for @savePermissions.
  ///
  /// In en, this message translates to:
  /// **'Save permissions'**
  String get savePermissions;

  /// No description provided for @acceptDemoInvite.
  ///
  /// In en, this message translates to:
  /// **'Simulate acceptance'**
  String get acceptDemoInvite;

  /// No description provided for @revokeInvitation.
  ///
  /// In en, this message translates to:
  /// **'Revoke invitation'**
  String get revokeInvitation;

  /// No description provided for @revokeInviteWarning.
  ///
  /// In en, this message translates to:
  /// **'This invite link will stop working immediately.'**
  String get revokeInviteWarning;

  /// No description provided for @transferOwnership.
  ///
  /// In en, this message translates to:
  /// **'Transfer ownership'**
  String get transferOwnership;

  /// No description provided for @transferWarning.
  ///
  /// In en, this message translates to:
  /// **'The new owner will control this family group. You will become a secondary caregiver.'**
  String get transferWarning;

  /// No description provided for @transferTo.
  ///
  /// In en, this message translates to:
  /// **'Transfer to {name}'**
  String transferTo(String name);

  /// No description provided for @familyActivity.
  ///
  /// In en, this message translates to:
  /// **'Family activity'**
  String get familyActivity;

  /// No description provided for @noInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations yet'**
  String get noInvitations;

  /// No description provided for @familyCreatedActivity.
  ///
  /// In en, this message translates to:
  /// **'Family group created'**
  String get familyCreatedActivity;

  /// No description provided for @profileAddedActivity.
  ///
  /// In en, this message translates to:
  /// **'Care profile added'**
  String get profileAddedActivity;

  /// No description provided for @inviteSentActivity.
  ///
  /// In en, this message translates to:
  /// **'Caregiver invitation sent'**
  String get inviteSentActivity;

  /// No description provided for @inviteAcceptedActivity.
  ///
  /// In en, this message translates to:
  /// **'Caregiver invitation accepted'**
  String get inviteAcceptedActivity;

  /// No description provided for @inviteRevokedActivity.
  ///
  /// In en, this message translates to:
  /// **'Caregiver invitation revoked'**
  String get inviteRevokedActivity;

  /// No description provided for @permissionsUpdatedActivity.
  ///
  /// In en, this message translates to:
  /// **'Member permissions updated'**
  String get permissionsUpdatedActivity;

  /// No description provided for @ownershipTransferredActivity.
  ///
  /// In en, this message translates to:
  /// **'Family ownership transferred'**
  String get ownershipTransferredActivity;

  /// No description provided for @removeAccess.
  ///
  /// In en, this message translates to:
  /// **'Remove access'**
  String get removeAccess;

  /// No description provided for @removeAccessWarning.
  ///
  /// In en, this message translates to:
  /// **'This person will immediately lose access to this family group.'**
  String get removeAccessWarning;

  /// No description provided for @memberRemovedActivity.
  ///
  /// In en, this message translates to:
  /// **'Member access removed'**
  String get memberRemovedActivity;

  /// No description provided for @careProfiles.
  ///
  /// In en, this message translates to:
  /// **'Care profiles'**
  String get careProfiles;

  /// No description provided for @addCareProfile.
  ///
  /// In en, this message translates to:
  /// **'Add care profile'**
  String get addCareProfile;

  /// No description provided for @editCareProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit care profile'**
  String get editCareProfile;

  /// No description provided for @archiveProfile.
  ///
  /// In en, this message translates to:
  /// **'Archive profile'**
  String get archiveProfile;

  /// No description provided for @archiveProfileWarning.
  ///
  /// In en, this message translates to:
  /// **'This profile will be hidden from active care. Its history will remain available.'**
  String get archiveProfileWarning;

  /// No description provided for @activeProfiles.
  ///
  /// In en, this message translates to:
  /// **'Active profiles'**
  String get activeProfiles;

  /// No description provided for @archivedProfiles.
  ///
  /// In en, this message translates to:
  /// **'Archived profiles'**
  String get archivedProfiles;

  /// No description provided for @noActiveProfiles.
  ///
  /// In en, this message translates to:
  /// **'No active care profiles'**
  String get noActiveProfiles;

  /// No description provided for @profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilePhoto;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get addPhoto;

  /// No description provided for @preferredName.
  ///
  /// In en, this message translates to:
  /// **'Preferred name'**
  String get preferredName;

  /// No description provided for @relationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get relationship;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @bloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood group'**
  String get bloodGroup;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @timezone.
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get timezone;

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred language'**
  String get preferredLanguage;

  /// No description provided for @medicalConditions.
  ///
  /// In en, this message translates to:
  /// **'Medical conditions'**
  String get medicalConditions;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @mobilityNotes.
  ///
  /// In en, this message translates to:
  /// **'Mobility notes'**
  String get mobilityNotes;

  /// No description provided for @doctorNotes.
  ///
  /// In en, this message translates to:
  /// **'Doctor notes'**
  String get doctorNotes;

  /// No description provided for @emergencyInstructions.
  ///
  /// In en, this message translates to:
  /// **'Emergency instructions'**
  String get emergencyInstructions;

  /// No description provided for @primaryCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Primary caregiver'**
  String get primaryCaregiver;

  /// No description provided for @secondaryCaregiverLabel.
  ///
  /// In en, this message translates to:
  /// **'Secondary caregiver'**
  String get secondaryCaregiverLabel;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get saveProfile;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Care profile saved'**
  String get profileSaved;

  /// No description provided for @profileArchived.
  ///
  /// In en, this message translates to:
  /// **'Care profile archived'**
  String get profileArchived;

  /// No description provided for @contactAndLocation.
  ///
  /// In en, this message translates to:
  /// **'Contact and location'**
  String get contactAndLocation;

  /// No description provided for @healthAndSafety.
  ///
  /// In en, this message translates to:
  /// **'Health and safety'**
  String get healthAndSafety;

  /// No description provided for @careTeam.
  ///
  /// In en, this message translates to:
  /// **'Care team'**
  String get careTeam;

  /// No description provided for @dashboardFor.
  ///
  /// In en, this message translates to:
  /// **'Care overview for {name}'**
  String dashboardFor(String name);

  /// No description provided for @documentsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Documents this week'**
  String get documentsThisWeek;

  /// No description provided for @nextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Next appointment'**
  String get nextAppointment;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @addMedicine.
  ///
  /// In en, this message translates to:
  /// **'Add medicine'**
  String get addMedicine;

  /// No description provided for @uploadReport.
  ///
  /// In en, this message translates to:
  /// **'Upload report'**
  String get uploadReport;

  /// No description provided for @addEmergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get addEmergencyContact;

  /// No description provided for @viewTimeline.
  ///
  /// In en, this message translates to:
  /// **'View timeline'**
  String get viewTimeline;

  /// No description provided for @careProfileTimezone.
  ///
  /// In en, this message translates to:
  /// **'Care time: {timezone}'**
  String careProfileTimezone(String timezone);

  /// No description provided for @partialProfile.
  ///
  /// In en, this message translates to:
  /// **'Some profile details still need attention'**
  String get partialProfile;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete profile'**
  String get completeProfile;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @medicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine name'**
  String get medicineName;

  /// No description provided for @genericName.
  ///
  /// In en, this message translates to:
  /// **'Generic name'**
  String get genericName;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'Brand name'**
  String get brandName;

  /// No description provided for @strength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get strength;

  /// No description provided for @medicineForm.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get medicineForm;

  /// No description provided for @dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get dosage;

  /// No description provided for @quantityPerDose.
  ///
  /// In en, this message translates to:
  /// **'Quantity per dose'**
  String get quantityPerDose;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @onceDaily.
  ///
  /// In en, this message translates to:
  /// **'Once daily'**
  String get onceDaily;

  /// No description provided for @twiceDaily.
  ///
  /// In en, this message translates to:
  /// **'Twice daily'**
  String get twiceDaily;

  /// No description provided for @threeTimesDaily.
  ///
  /// In en, this message translates to:
  /// **'Three times daily'**
  String get threeTimesDaily;

  /// No description provided for @fourTimesDaily.
  ///
  /// In en, this message translates to:
  /// **'Four times daily'**
  String get fourTimesDaily;

  /// No description provided for @everyXHours.
  ///
  /// In en, this message translates to:
  /// **'Every X hours'**
  String get everyXHours;

  /// No description provided for @specificDays.
  ///
  /// In en, this message translates to:
  /// **'Specific days'**
  String get specificDays;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @asNeeded.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get asNeeded;

  /// No description provided for @doseTimes.
  ///
  /// In en, this message translates to:
  /// **'Dose times'**
  String get doseTimes;

  /// No description provided for @addTime.
  ///
  /// In en, this message translates to:
  /// **'Add time'**
  String get addTime;

  /// No description provided for @daysOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Days of week'**
  String get daysOfWeek;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get endDate;

  /// No description provided for @longTermMedicine.
  ///
  /// In en, this message translates to:
  /// **'Long-term medicine'**
  String get longTermMedicine;

  /// No description provided for @foodInstruction.
  ///
  /// In en, this message translates to:
  /// **'Food instruction'**
  String get foodInstruction;

  /// No description provided for @beforeFood.
  ///
  /// In en, this message translates to:
  /// **'Before food'**
  String get beforeFood;

  /// No description provided for @afterFood.
  ///
  /// In en, this message translates to:
  /// **'After food'**
  String get afterFood;

  /// No description provided for @withFood.
  ///
  /// In en, this message translates to:
  /// **'With food'**
  String get withFood;

  /// No description provided for @emptyStomach.
  ///
  /// In en, this message translates to:
  /// **'Empty stomach'**
  String get emptyStomach;

  /// No description provided for @prescriptionAndDoctor.
  ///
  /// In en, this message translates to:
  /// **'Prescription and doctor'**
  String get prescriptionAndDoctor;

  /// No description provided for @prescribedBy.
  ///
  /// In en, this message translates to:
  /// **'Prescribed by'**
  String get prescribedBy;

  /// No description provided for @linkedDoctor.
  ///
  /// In en, this message translates to:
  /// **'Linked doctor'**
  String get linkedDoctor;

  /// No description provided for @linkedPrescription.
  ///
  /// In en, this message translates to:
  /// **'Linked prescription'**
  String get linkedPrescription;

  /// No description provided for @stockAndNotes.
  ///
  /// In en, this message translates to:
  /// **'Stock and notes'**
  String get stockAndNotes;

  /// No description provided for @stockCount.
  ///
  /// In en, this message translates to:
  /// **'Stock count'**
  String get stockCount;

  /// No description provided for @lowStockThreshold.
  ///
  /// In en, this message translates to:
  /// **'Low-stock threshold'**
  String get lowStockThreshold;

  /// No description provided for @medicineNotes.
  ///
  /// In en, this message translates to:
  /// **'Medicine notes'**
  String get medicineNotes;

  /// No description provided for @sideEffectNotes.
  ///
  /// In en, this message translates to:
  /// **'Side-effect notes'**
  String get sideEffectNotes;

  /// No description provided for @saveMedicine.
  ///
  /// In en, this message translates to:
  /// **'Save medicine'**
  String get saveMedicine;

  /// No description provided for @editMedicine.
  ///
  /// In en, this message translates to:
  /// **'Edit medicine'**
  String get editMedicine;

  /// No description provided for @medicineDetails.
  ///
  /// In en, this message translates to:
  /// **'Medicine details'**
  String get medicineDetails;

  /// No description provided for @lowStock.
  ///
  /// In en, this message translates to:
  /// **'Low stock'**
  String get lowStock;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @stopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get stopped;

  /// No description provided for @allMedicines.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allMedicines;

  /// No description provided for @noMedicines.
  ///
  /// In en, this message translates to:
  /// **'No medicines in this view'**
  String get noMedicines;

  /// No description provided for @tabletsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String tabletsLeft(int count);

  /// No description provided for @pauseMedicine.
  ///
  /// In en, this message translates to:
  /// **'Pause medicine'**
  String get pauseMedicine;

  /// No description provided for @resumeMedicine.
  ///
  /// In en, this message translates to:
  /// **'Resume medicine'**
  String get resumeMedicine;

  /// No description provided for @completeMedicine.
  ///
  /// In en, this message translates to:
  /// **'Complete medicine'**
  String get completeMedicine;

  /// No description provided for @stopMedicine.
  ///
  /// In en, this message translates to:
  /// **'Stop medicine'**
  String get stopMedicine;

  /// No description provided for @schedulePreview.
  ///
  /// In en, this message translates to:
  /// **'Upcoming dose preview'**
  String get schedulePreview;

  /// No description provided for @schedulePreviewBody.
  ///
  /// In en, this message translates to:
  /// **'Reminders will use {timezone} care-profile time.'**
  String schedulePreviewBody(String timezone);

  /// No description provided for @nextDosePreview.
  ///
  /// In en, this message translates to:
  /// **'Next: {date} at {time}'**
  String nextDosePreview(String date, String time);

  /// No description provided for @medicineSaved.
  ///
  /// In en, this message translates to:
  /// **'Medicine saved'**
  String get medicineSaved;

  /// No description provided for @scheduleChangeWarning.
  ///
  /// In en, this message translates to:
  /// **'Changing this schedule will update future reminders after confirmation.'**
  String get scheduleChangeWarning;

  /// No description provided for @confirmSchedule.
  ///
  /// In en, this message translates to:
  /// **'Confirm schedule'**
  String get confirmSchedule;

  /// No description provided for @timeForMedicine.
  ///
  /// In en, this message translates to:
  /// **'Time for your medicine'**
  String get timeForMedicine;

  /// No description provided for @takenAction.
  ///
  /// In en, this message translates to:
  /// **'I took it'**
  String get takenAction;

  /// No description provided for @snooze15.
  ///
  /// In en, this message translates to:
  /// **'Remind me in 15 minutes'**
  String get snooze15;

  /// No description provided for @skipDose.
  ///
  /// In en, this message translates to:
  /// **'Skip this dose'**
  String get skipDose;

  /// No description provided for @needHelpAction.
  ///
  /// In en, this message translates to:
  /// **'I need help'**
  String get needHelpAction;

  /// No description provided for @reminderHistory.
  ///
  /// In en, this message translates to:
  /// **'Reminder history'**
  String get reminderHistory;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @dueNow.
  ///
  /// In en, this message translates to:
  /// **'Due now'**
  String get dueNow;

  /// No description provided for @takenStatus.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get takenStatus;

  /// No description provided for @snoozed.
  ///
  /// In en, this message translates to:
  /// **'Snoozed'**
  String get snoozed;

  /// No description provided for @skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get skipped;

  /// No description provided for @missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missed;

  /// No description provided for @escalated.
  ///
  /// In en, this message translates to:
  /// **'Escalated'**
  String get escalated;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @queuedOffline.
  ///
  /// In en, this message translates to:
  /// **'Saved offline — this action will sync when connected.'**
  String get queuedOffline;

  /// No description provided for @offlineDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo offline mode'**
  String get offlineDemo;

  /// No description provided for @offlineDemoBody.
  ///
  /// In en, this message translates to:
  /// **'Actions are kept safely on this device until connection returns.'**
  String get offlineDemoBody;

  /// No description provided for @reminderPermissionHealth.
  ///
  /// In en, this message translates to:
  /// **'Reminder readiness'**
  String get reminderPermissionHealth;

  /// No description provided for @notificationsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Notifications allowed'**
  String get notificationsAllowed;

  /// No description provided for @batteryGuidance.
  ///
  /// In en, this message translates to:
  /// **'Battery and Focus settings can affect alarms.'**
  String get batteryGuidance;

  /// No description provided for @deliveryLimitation.
  ///
  /// In en, this message translates to:
  /// **'CareBridge cannot guarantee alarm delivery. Call your caregiver or emergency contact if help is urgent.'**
  String get deliveryLimitation;

  /// No description provided for @noReminderDue.
  ///
  /// In en, this message translates to:
  /// **'No medicine is due right now'**
  String get noReminderDue;

  /// No description provided for @viewReminderHistory.
  ///
  /// In en, this message translates to:
  /// **'View reminder history'**
  String get viewReminderHistory;

  /// No description provided for @actionRecorded.
  ///
  /// In en, this message translates to:
  /// **'Action recorded'**
  String get actionRecorded;

  /// No description provided for @helpRequested.
  ///
  /// In en, this message translates to:
  /// **'Help request sent to your caregiver'**
  String get helpRequested;

  /// No description provided for @filterStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter status'**
  String get filterStatus;

  /// No description provided for @allStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get allStatuses;

  /// No description provided for @showingDemoRecords.
  ///
  /// In en, this message translates to:
  /// **'Showing {count} realistic local demo records'**
  String showingDemoRecords(int count);

  /// No description provided for @demoDatasetSummary.
  ///
  /// In en, this message translates to:
  /// **'Demo data: {profiles} profiles · {medicines} medicines · {reminders} reminders'**
  String demoDatasetSummary(int profiles, int medicines, int reminders);

  /// No description provided for @caregiverAlerts.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alerts'**
  String get caregiverAlerts;

  /// No description provided for @missedReminderAlert.
  ///
  /// In en, this message translates to:
  /// **'Missed medicine reminder'**
  String get missedReminderAlert;

  /// No description provided for @remoteRing.
  ///
  /// In en, this message translates to:
  /// **'Ring now'**
  String get remoteRing;

  /// No description provided for @sendReminder.
  ///
  /// In en, this message translates to:
  /// **'Send reminder'**
  String get sendReminder;

  /// No description provided for @callParent.
  ///
  /// In en, this message translates to:
  /// **'Call parent'**
  String get callParent;

  /// No description provided for @notifyLocalContact.
  ///
  /// In en, this message translates to:
  /// **'Notify local contact'**
  String get notifyLocalContact;

  /// No description provided for @resolveAlert.
  ///
  /// In en, this message translates to:
  /// **'Resolve alert'**
  String get resolveAlert;

  /// No description provided for @alertResolved.
  ///
  /// In en, this message translates to:
  /// **'Alert resolved'**
  String get alertResolved;

  /// No description provided for @deliveryTracking.
  ///
  /// In en, this message translates to:
  /// **'Delivery tracking'**
  String get deliveryTracking;

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @opened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get opened;

  /// No description provided for @actioned.
  ///
  /// In en, this message translates to:
  /// **'Actioned'**
  String get actioned;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @parentLocalTime.
  ///
  /// In en, this message translates to:
  /// **'Parent time ({timezone}): {time}'**
  String parentLocalTime(String timezone, String time);

  /// No description provided for @caregiverLocalTime.
  ///
  /// In en, this message translates to:
  /// **'Your time (Europe/London): {time}'**
  String caregiverLocalTime(String time);

  /// No description provided for @remoteRingSent.
  ///
  /// In en, this message translates to:
  /// **'Remote ring delivered to the parent device.'**
  String get remoteRingSent;

  /// No description provided for @reminderSent.
  ///
  /// In en, this message translates to:
  /// **'Reminder delivered to the parent device.'**
  String get reminderSent;

  /// No description provided for @ringRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Please wait before sending another alarm.'**
  String get ringRateLimited;

  /// No description provided for @remoteDeliveryWarning.
  ///
  /// In en, this message translates to:
  /// **'Remote ringing is not guaranteed. The phone may be offline, muted, low on battery, or restricted by the operating system.'**
  String get remoteDeliveryWarning;

  /// No description provided for @fallbackActions.
  ///
  /// In en, this message translates to:
  /// **'Fallback actions'**
  String get fallbackActions;

  /// No description provided for @missedAt.
  ///
  /// In en, this message translates to:
  /// **'Missed at {time}'**
  String missedAt(String time);

  /// No description provided for @noCaregiverAlerts.
  ///
  /// In en, this message translates to:
  /// **'No caregiver alerts need attention'**
  String get noCaregiverAlerts;

  /// No description provided for @alarmRequestHistory.
  ///
  /// In en, this message translates to:
  /// **'Alarm request history'**
  String get alarmRequestHistory;

  /// No description provided for @editEmergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Edit emergency contact'**
  String get editEmergencyContact;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact name'**
  String get contactName;

  /// No description provided for @contactType.
  ///
  /// In en, this message translates to:
  /// **'Contact type'**
  String get contactType;

  /// No description provided for @primaryPhone.
  ///
  /// In en, this message translates to:
  /// **'Primary phone'**
  String get primaryPhone;

  /// No description provided for @secondaryPhone.
  ///
  /// In en, this message translates to:
  /// **'Secondary phone'**
  String get secondaryPhone;

  /// No description provided for @whatsappNumber.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp number'**
  String get whatsappNumber;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance from care recipient'**
  String get distance;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @preferredContactMethod.
  ///
  /// In en, this message translates to:
  /// **'Preferred contact method'**
  String get preferredContactMethod;

  /// No description provided for @priorityLevel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLevel;

  /// No description provided for @contactNotes.
  ///
  /// In en, this message translates to:
  /// **'Contact notes'**
  String get contactNotes;

  /// No description provided for @emergencyPermissions.
  ///
  /// In en, this message translates to:
  /// **'Emergency permissions'**
  String get emergencyPermissions;

  /// No description provided for @permissionWarning.
  ///
  /// In en, this message translates to:
  /// **'Share only the minimum information this person needs.'**
  String get permissionWarning;

  /// No description provided for @receiveEmergencyAlert.
  ///
  /// In en, this message translates to:
  /// **'Receives emergency alerts'**
  String get receiveEmergencyAlert;

  /// No description provided for @receiveMissedMedicineAlert.
  ///
  /// In en, this message translates to:
  /// **'Receives missed-medicine alerts'**
  String get receiveMissedMedicineAlert;

  /// No description provided for @viewBasicProfile.
  ///
  /// In en, this message translates to:
  /// **'Can view basic profile'**
  String get viewBasicProfile;

  /// No description provided for @viewMedicalSummary.
  ///
  /// In en, this message translates to:
  /// **'Can view medical summary'**
  String get viewMedicalSummary;

  /// No description provided for @viewDocumentsPermission.
  ///
  /// In en, this message translates to:
  /// **'Can view documents'**
  String get viewDocumentsPermission;

  /// No description provided for @viewLocation.
  ///
  /// In en, this message translates to:
  /// **'Can view location'**
  String get viewLocation;

  /// No description provided for @saveContact.
  ///
  /// In en, this message translates to:
  /// **'Save contact'**
  String get saveContact;

  /// No description provided for @contactAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get contactAdded;

  /// No description provided for @contactInvited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get contactInvited;

  /// No description provided for @contactVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get contactVerified;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @removed.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get removed;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @callingContact.
  ///
  /// In en, this message translates to:
  /// **'Calling {phone}'**
  String callingContact(String phone);

  /// No description provided for @openingWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Opening WhatsApp for {phone}'**
  String openingWhatsapp(String phone);

  /// No description provided for @emergencyAlerts.
  ///
  /// In en, this message translates to:
  /// **'Emergency help alerts'**
  String get emergencyAlerts;

  /// No description provided for @noEmergencyAlerts.
  ///
  /// In en, this message translates to:
  /// **'No emergency alerts'**
  String get noEmergencyAlerts;

  /// No description provided for @emergencyAlertDetail.
  ///
  /// In en, this message translates to:
  /// **'Emergency alert'**
  String get emergencyAlertDetail;

  /// No description provided for @triggeredBy.
  ///
  /// In en, this message translates to:
  /// **'Triggered by'**
  String get triggeredBy;

  /// No description provided for @acceptedBy.
  ///
  /// In en, this message translates to:
  /// **'Accepted by'**
  String get acceptedBy;

  /// No description provided for @alertTimeline.
  ///
  /// In en, this message translates to:
  /// **'Alert timeline'**
  String get alertTimeline;

  /// No description provided for @notifyPriorityOne.
  ///
  /// In en, this message translates to:
  /// **'Notify Priority 1 contacts'**
  String get notifyPriorityOne;

  /// No description provided for @goingToHelp.
  ///
  /// In en, this message translates to:
  /// **'I am going to help'**
  String get goingToHelp;

  /// No description provided for @resolveEmergency.
  ///
  /// In en, this message translates to:
  /// **'Resolve emergency'**
  String get resolveEmergency;

  /// No description provided for @uploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload document'**
  String get uploadDocument;

  /// No description provided for @searchDocuments.
  ///
  /// In en, this message translates to:
  /// **'Search title, doctor, or tag'**
  String get searchDocuments;

  /// No description provided for @filterDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Filter by document type'**
  String get filterDocumentType;

  /// No description provided for @allDocuments.
  ///
  /// In en, this message translates to:
  /// **'All documents'**
  String get allDocuments;

  /// No description provided for @includeArchived.
  ///
  /// In en, this message translates to:
  /// **'Include archived documents'**
  String get includeArchived;

  /// No description provided for @noDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents match these filters'**
  String get noDocuments;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed. The local draft is safe.'**
  String get uploadFailed;

  /// No description provided for @retryUpload.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryUpload;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @bloodTestReport.
  ///
  /// In en, this message translates to:
  /// **'Blood test report'**
  String get bloodTestReport;

  /// No description provided for @urineTestReport.
  ///
  /// In en, this message translates to:
  /// **'Urine test report'**
  String get urineTestReport;

  /// No description provided for @ultrasound.
  ///
  /// In en, this message translates to:
  /// **'Ultrasound'**
  String get ultrasound;

  /// No description provided for @dischargeSummary.
  ///
  /// In en, this message translates to:
  /// **'Discharge summary'**
  String get dischargeSummary;

  /// No description provided for @doctorNote.
  ///
  /// In en, this message translates to:
  /// **'Doctor note'**
  String get doctorNote;

  /// No description provided for @medicinePhoto.
  ///
  /// In en, this message translates to:
  /// **'Medicine photo'**
  String get medicinePhoto;

  /// No description provided for @hospitalBill.
  ///
  /// In en, this message translates to:
  /// **'Hospital bill'**
  String get hospitalBill;

  /// No description provided for @insuranceDocument.
  ///
  /// In en, this message translates to:
  /// **'Insurance document'**
  String get insuranceDocument;

  /// No description provided for @followUpNote.
  ///
  /// In en, this message translates to:
  /// **'Follow-up note'**
  String get followUpNote;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a PDF or image'**
  String get chooseFile;

  /// No description provided for @choosePdf.
  ///
  /// In en, this message translates to:
  /// **'Choose PDF'**
  String get choosePdf;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose image'**
  String get chooseImage;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission was denied. Enable it in Settings or choose an existing file.'**
  String get cameraPermissionDenied;

  /// No description provided for @simulateCameraDenied.
  ///
  /// In en, this message translates to:
  /// **'Test camera denied'**
  String get simulateCameraDenied;

  /// No description provided for @simulateInvalidFile.
  ///
  /// In en, this message translates to:
  /// **'Test invalid file'**
  String get simulateInvalidFile;

  /// No description provided for @unsupportedFileType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file type. Use PDF, JPG, or PNG.'**
  String get unsupportedFileType;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File is too large. The maximum size is 20 MB.'**
  String get fileTooLarge;

  /// No description provided for @chooseFileFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose a valid file before uploading.'**
  String get chooseFileFirst;

  /// No description provided for @documentTitle.
  ///
  /// In en, this message translates to:
  /// **'Document title'**
  String get documentTitle;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get documentType;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Doctor name'**
  String get doctorName;

  /// No description provided for @hospitalClinic.
  ///
  /// In en, this message translates to:
  /// **'Hospital or clinic'**
  String get hospitalClinic;

  /// No description provided for @documentDate.
  ///
  /// In en, this message translates to:
  /// **'Document date'**
  String get documentDate;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @linkedMedicine.
  ///
  /// In en, this message translates to:
  /// **'Linked medicine'**
  String get linkedMedicine;

  /// No description provided for @linkedAppointment.
  ///
  /// In en, this message translates to:
  /// **'Linked appointment'**
  String get linkedAppointment;

  /// No description provided for @linkedCondition.
  ///
  /// In en, this message translates to:
  /// **'Linked condition'**
  String get linkedCondition;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @visibilityPermissions.
  ///
  /// In en, this message translates to:
  /// **'Visibility permissions'**
  String get visibilityPermissions;

  /// No description provided for @documentPermissionWarning.
  ///
  /// In en, this message translates to:
  /// **'Only selected family members can open this document. Emergency access does not grant document access.'**
  String get documentPermissionWarning;

  /// No description provided for @ownerRequired.
  ///
  /// In en, this message translates to:
  /// **'Owner access is required'**
  String get ownerRequired;

  /// No description provided for @uploadAndSave.
  ///
  /// In en, this message translates to:
  /// **'Upload and save'**
  String get uploadAndSave;

  /// No description provided for @secureDocumentViewer.
  ///
  /// In en, this message translates to:
  /// **'Secure document viewer'**
  String get secureDocumentViewer;

  /// No description provided for @localSecurePreview.
  ///
  /// In en, this message translates to:
  /// **'Protected local demo preview'**
  String get localSecurePreview;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @downloadedSecurely.
  ///
  /// In en, this message translates to:
  /// **'Secure download prepared.'**
  String get downloadedSecurely;

  /// No description provided for @sharePermissionChecked.
  ///
  /// In en, this message translates to:
  /// **'Permission checked; secure share recorded.'**
  String get sharePermissionChecked;

  /// No description provided for @uploadedBy.
  ///
  /// In en, this message translates to:
  /// **'Uploaded by'**
  String get uploadedBy;

  /// No description provided for @documentHistory.
  ///
  /// In en, this message translates to:
  /// **'Document access history'**
  String get documentHistory;

  /// No description provided for @archiveDocument.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveDocument;

  /// No description provided for @deleteDocument.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteDocument;

  /// No description provided for @deleteDocumentWarning.
  ///
  /// In en, this message translates to:
  /// **'Delete this document? Access will be removed and the action recorded.'**
  String get deleteDocumentWarning;

  /// No description provided for @documentHiddenForPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Document hidden while CareBridge is inactive'**
  String get documentHiddenForPrivacy;
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
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
