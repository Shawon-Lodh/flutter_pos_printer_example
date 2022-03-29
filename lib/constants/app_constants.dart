/*
    Created by Shitab Mir on 31 August 2021
    Updated by Shawon Lodh 5 January 2022
 */
class AppConstants {

  static AppConstants instance = AppConstants();

  /// Localization Keys
  // SettingsPage
  String english = 'english';
  String bangla = 'bangla';
  String language = 'language';
  String changePassword = 'changePassword';
  String accessPermission = 'accessPermission';

  // AccountStatusPage
  String get accountStatus => 'accountStatus';
  String get accountUnderReview => 'accountUnderReview';
  String get accountRejected => 'accountRejected';
  String get accountIsUnderReview => 'accountIsUnderReview';
  String get accountIsUnderReviewDesc => 'accountIsUnderReviewDesc';
  String get accountIsRejected => 'accountIsRejected';
  String get accountIsRejectedDesc => 'accountIsRejectedDesc';
  String get callHelpline => 'callHelpline';
  String get howToUseThisApp => 'howToUseThisApp';

  // FaqPage
  String get faq => 'faq';

  /// Contant values
  int get otpResendCountDownTime => 120;
  int get titleFieldStringMaximumLength => 50;
  int get phoneNumberFieldStringMaximumLength => 11;
  int get nidNumberFieldStringMaximumLength => 17;
  int get problemFieldStringMinimumLength => 80;
  int get problemFieldStringMaximumLength => 300;

  /// Regex
  static String get specialCharacterRegex => '[\\=+.,()/!?@><#^&*{}";:_`~%|-]';
  static String get onlyEnglishNumericsRegex => '[0-9]';

  /// Text
  ///Common

  //app title
  String get appTitleBangla => 'AgroTrace Tobacco';

  //logout related
  String get logoutAllCaps => 'LOG OUT';
  String get logout => 'Log Out';
  String get exit => 'Exit';
  String get yes => 'Yes';
  String get no => 'No';
  String get wannaBackToPreviousPage => 'Do you want to go Previous page?';
  String get wannaLogout => 'Do you want to Log Out?';
  String get wannaExit => 'Do you want to Exit the App?';
  String get cancel => 'Cancel';


  //others
  String get poweredBy => 'Powered by';
  String get somethingWentWrong => 'Something went Wrong!';
  String get somethingWentWrongBn => 'প্রযুক্তিক ত্রুটি দেখা দিয়েছে!';
  String get createIssues => 'Create Issues ';
  String get listOfIssues => 'List of Issues';

  //Login page related
  String get signInAllCaps => 'SIGN IN';
  String get loginAllCaps => 'LOG IN';
  String get registerToApp => "Register to the App";

  //Forgot password related
  String get forgotPassword => 'Forgot Password';
  String get requestOtp => 'Request Otp';
  String get sendOtpToPhoneMessage => "Enter your registered phone no below to receive OTP code";

  //Register page related
  String get registerAllCaps => 'REGISTER';
  String get registrationQueryMessage => "Don’t have an account?  ";

  //Otp page related
  String get confirmOtpAllCaps => "CONFIRM OTP";
  String get otpCodeSentConfirmationMessage => "We have sent a OTP code to your phone number";
  String get otpCodeResendQueryMessage => "Didn’t receive the message? Check your message inbox";
  String get resendAllCaps => "RESEND";
  String get bdPhoneNumberPrefix => "+88";

  String get camera => 'Camera';
  String get gallery => 'Gallery';

  // Add Farmer Page related
  String get addFarmer => 'Add Farmer';
  String get updateLocation => 'Update Location';

  // create tp page
  String get createTp => "Create TP";

  // print tp page
  String get deviceManagePermission => "Start Managing Your Permission";
  String get searchingDevices => "Searching for Devices...";
  String get waitingFewSeconds => "It is going to take only few seconds";
  String get totalFoundDevices => "Total Devices Found : ";
  String get selectDevices => "Select device & tap for confirm to print";
  String get noDevicesFound => "No Devices Found";
  String get retry => "Retry";
  String get scanMore => "Scan More Devices";
  String get address => "Address : ";
  String get bluetoothDevice => "BlueTooth Device";
  String get bluetooth => "Bluetooth";
  String get location => "Location";

  // Purchase Input Page related
  String get rejectBell => 'Reject Bell';
  String get purchaseBell => 'Purchase Bell';
  String get updatePurchaseBell => 'Update Purchase Bell';

  // Set Weight Input Page related
  String get setWeight => 'Set Weight';

  ///input field related

  //Registration Type input field
  String get registrationTypeInputFieldLabel => "Registration type";
  String get registrationTypeInputFieldHint => "Select type";
  String get registrationTypeInputFieldNoInputFoundError => "Please select registration type";

  //Area input field
  String get areaInputFieldLabel => "Area";
  String get areaInputFieldHint => "Select area";
  String get areaTypeInputFieldNoInputFoundError => "Please select area";

  //Extension Center input field
  String get extensionCenterInputFieldLabel => "Extension Center";
  String get extensionCenterInputFieldHint => "Select extension center";
  String get extensionCenterInputFieldNoInputFoundError => "Please select extension center";

  //Village Name input field
  String get villageNameInputFieldLabel => "Village Name";
  String get villageNameInputFieldHint => "Select Village Name";
  String get villageNameInputFieldNoInputFoundError => "Please select village name";

  //Image input field
  String get imageInputFieldLabel => "Image";
  String get imageInputFieldHint => "No image Uploaded";
  String get imageInputButtonText => "Upload";
  String get imageInputFieldNoInputFoundError => "Please select Image";

  //Location input field
  String get locationInputFieldLabel => "Location";
  String get locationInputFieldHint => "No location\nSelected";
  String get locationInputButtonText => "Get location";
  String get locationEditButtonText => "Edit";
  String get locationInputFieldNoInputFoundError => "Please select location";
  String get latitudeInputFieldLabel => "Latitude";
  String get longitudeInputFieldLabel => "Longitude";

  //Tobacco Type input field
  String get tobaccoTypeInputFieldLabel => "Tobacco Type";
  String get tobaccoTypeInputFieldHint => "Select tobacco type";
  String get tobaccoTypeInputFieldNoInputFoundError => "Please select tobacco type";

  //Tobacco Variety input field
  String get tobaccoVarietyInputFieldLabel => "Tobacco Variety";
  String get tobaccoVarietyInputFieldHint => "Select tobacco variety";
  String get tobaccoVarietyInputFieldNoInputFoundError => "Please select tobacco variety";

  //Bale Quantity input field
  String get baleQuantityInputFieldLabel => "Bale Quantity";
  String get baleQuantityInputFieldHint => "Allowed Bale";
  String get baleQuantityInputFieldNoInputFoundError => "Please enter bale quantity";

  //Buying Date input field
  String get buyingDateInputFieldLabel => "Buying Date";
  String get buyingDateInputFieldHint => "Buying Date";
  String get buyingDateInputFieldNoInputFoundError => "Please enter buying date";

  //Internal Grade input field
  String get internalGradeInputFieldLabel => "Internal Grade";
  String get internalGradeInputFieldHint => "Select internal grade";
  String get internalGradeInputFieldNoInputFoundError => "Please select internal grade";

  //External Grade input field
  String get externalGradeInputFieldLabel => "External Grade";
  String get externalGradeInputFieldHint => "Select external grade";
  String get externalGradeInputFieldNoInputFoundError => "Please select external grade";

  //Unit Price input field
  String get unitPriceInputFieldLabel => "Unit Price (Per Kg)";
  String get unitPriceInputFieldHint => "Unit Price (Per Kg)";
  String get unitPriceInputFieldNoInputFoundError => "Please enter unit price";

  //Weight amount input field
  String get weightAmountInputFieldLabel => "Weight amount(Kg)";
  String get weightAmountInputFieldHint => "Weight amount";
  String get weightAmountInputFieldNoInputFoundError => "Please enter weight amount";

  //Tare amount input field
  String get tareWeightAmountInputFieldLabel => "Tare amount(Kg)";
  String get tareWeightAmountInputFieldHint => "Weight Less amount";
  String get tareWeightAmountInputFieldNoInputFoundError => "Please enter weight Less amount";

  //farmer name input field
  String get farmerNameInputFieldLabel => "Farmer’s Name";
  String get farmerNameInputFieldHint => "Select Farmers";
  String get farmerNameInputFieldNoInputFoundError => "Please enter farmer name";

  //farmer father name input field
  String get farmerFatherNameInputFieldLabel => "Farmer’s Father Name";
  String get farmerFatherNameInputFieldNoInputFoundError => "Please enter farmer’s father name";

  //NID number input field
  String get nidNumberInputFieldLabel => "NID Number";
  String get nidNumberInputFieldNoInputFoundError => "Please enter NID number";
  String get nidNumberInputFieldMinimumLengthError => "NID Number must be 10 digit";
  String get nidNumberInputFieldMaximumLengthError => "NID Number not greater than 17 digit";

  //phone number input field
  String get phoneNumberInputFieldLabel => "Phone Number";
  String get phoneNumberInputFieldHint => "Phone Number";
  String get phoneNumberInputFieldNoInputFoundError => "No Phone Number Found";
  String get phoneNumberInputFieldLengthError => "Phone Number must be 11 digit";
  String get phoneNumberInputFieldValidationError => "Please enter valid Phone Number";
  String get phoneNumberInputFieldValidationPattern => r'(^(01){1}[123456789]{1}(\d){8})$';

  //password input field
  String get passwordInputFieldLabel => "Password";
  String get passwordInputFieldHint => "******";
  String get passwordInputFieldNoInputFoundError => "No Password Found";

  //repeat password input field
  String get rePasswordInputFieldLabel => "Confirm Password";
  String get rePasswordInputFieldHint => "Enter your Password again";
  String get rePasswordInputFieldNoInputFoundError => "No Password Found";
  String get rePasswordInputFieldNotMatchError => "Password Not Match";

  //name input field
  String get nameInputFieldLabel => "Name";
  String get nameInputFieldHint => "Enter your Name";
  String get nameInputFieldNoInputFoundError => "Please Enter your Name";

  //email input field
  String get emailInputFieldLabel => "Email";
  String get emailInputFieldHint => "Enter your Email";
  String get emailInputFieldNoInputFoundError => 'No Email Found';
  String get emailInputFieldValidationError => 'Please enter valid Email Address';
  String get helplineNumber => 'tel:+8801675359644';


  /// All Access Permissions
  String get tpPermission => "App-Transport-Permit";
  String get registerBalePermission => "App-Register-Bale";
  String get purchaseBalePermission => "App-Purchase-Bale";
  String get weightBalePermission => "App-Weight-Bale";
  String get purchaseHistoryPermission => "App-Purchase-History";
  String get baleTrackerPermission => "App-Bale-Tracker";

}