//! THIS CLASS HANDLES ALL POSSIBLE NETWORK EXCEPTIONS
abstract class NetworkErrors {
  static const String socketException =
      "No internet connection 😑, please try again later";
  static const String httpException =
      "Oh jeez 😱 ... we encountered some problems, we're fixing it, try again please";
  static const String formatException =
      "Oh jeez 🫤 ... we encountered some problems, we're fixing it; kindly retry.";
  static const String defaultException =
      "Something broke 🙈, we're fixing it, could you please try again";

  const NetworkErrors._();
}
