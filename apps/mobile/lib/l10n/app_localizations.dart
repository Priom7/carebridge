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
