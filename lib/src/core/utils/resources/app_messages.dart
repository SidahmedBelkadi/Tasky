class AppMessages {
  AppMessages._();

  static const noRouteFound = 'Route not found';
  static const serverFailure = 'Server failure occurred';
  static const cacheFailure = 'Failed to retrieve data from cache';
  static const errorDuringCommunication =
      "There was an error during communication. Please try again.";
  static const badRequest = "Invalid request. Please check your input.";
  static const unauthorized = "You are not authorized to perform this action.";
  static const unprocessable = "Unable to process the request. Please check your input.";
  static const requestedInfoNotFound = "The requested information was not found.";
  static const conflictOccurred = "A conflict occurred. Please try again.";
  static const internalServerError = "An internal server error occurred. Please try again later.";
  static const noInternetConnection = 'No internet connection. Please check your connection.';
  static const communicationErrorWithServer = 'A communication error occurred with the server.';
  static const unexpectedError = 'An unexpected error occurred.';

  static const accountCreated = "Your account has been created, welcome to Tasky";
  static const welcomeBack = "Welcome Back !!";
  static const taskAdded = "Task Added Successfully. !";
  static const inferiorDateError = "The due date cannot be less than today.. !";
}
