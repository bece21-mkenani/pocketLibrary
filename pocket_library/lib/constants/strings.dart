class AppStrings {
  // API Base URL
  static const String baseUrl = "https://nkenani.onrender.com/api/";

  // App Info
  static const String appName = "Pocket Library";
  static const String appTitle = "Book Store";

  // General Strings
  static const String somethingWentWrong = "Something Went Wrong.";

  // register/login strings
  static const String unExpectedError = "An unexpected error occurred.";
  static const String failedToRegister = "Failed to register";
  static const String logInFailed = "Login failed";
  static const String otpFailedToverify = "Failed to verify OTP";
  static const String serverError = "Server error";

  // regislation screen strings

  static const String registrationSuccessful =
      "Registration Successful! Please check for OTP";
  static const String registrationfailed = "Registration failed";
  static const String createAccount = "Create Account";
  static const String joinUs = "Join Us";
  static const String register = "Register";
  static const String passwordWarning =
      "  Password must be at least 6 characters";
  static const String texFiledWarning = "Please fill in all fields.";

  // otp screen strings

  static const String pleaseEnterOTP = "Please enter a valid 6-digit OTP";
  static const String successfullVerification =
      "Verification Successful! Please log in";
  static const String verificationFailed = "Verification failed.";
  static const String enterVerificationCode = "Enter Verification Code";
  static const String otpSentToPhone = "A 6-digit code has been sent to";
  static const String verify = "Verify";
  static const String verifyAccount = "Verify Account";

  //log in screeen strings

  static const String fillInFields = "Please fill in all fields.";
  static const String successfullLogIn = "Login Successful!";
  static const String login = "Login";
  static const String notHaveAcount = 'Don\'t have an account? Register';
  static const String welcomeBack = "Welcome Please LogIn";

  // homescreen strings
  static const String bookStore = "Book Store";
  static const String retry = "Retry";
  static const String failedToLoadbookData = "Failed to load book data.";

  // book detail screen strings
  static const String aboutThisbook = 'About this book';
  static const String addToFavorites = 'Add to Favorites';
  static const String favoritesNotImplemented =
      'Favorites not yet implemented.';
  static const String readerNotImplemented = 'Reader not yet implemented.';
  static const String readNow = 'Read Now';
  static const String removeToFavorites = 'Remove Favorite';

  // favorite screen
  static const String myfavorite = 'My Favorites';
  static const String notYetMyfavorite = 'No Favorites Yet';
  static const String addToFavoritesToSeeThem =
      'Add books to your favorites to see them here.';

//search screen
  static const String searchBooks = 'Search Books';
  static const String searchHint = 'Search by title or author...';
  static const String noResultsFound = 'No books found matching your search.';
  static const String startTypingToSearch = 'Start typing to search for books.';
}
