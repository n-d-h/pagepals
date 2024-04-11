import 'package:intl/intl.dart';

class Utils {
  static String formatDate(String date) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
  }

  static String formatDateTime(String dateTime) {
    var date = dateTime.split("-");
    return date.reversed.join("-");
  }

  static String formatPrice(double priceInDong) {
    // Check if priceInDong is in cents or dong
    if (priceInDong < 100) {
      // If priceInDong is less than 100, assume it's already in dong
      priceInDong *= 100; // Convert it to cents
    }

    // Create a NumberFormat instance for formatting the price with thousands separators
    NumberFormat format = NumberFormat("#,##0", "en_US");

    // Format the price with thousands separators
    String formattedPrice = format.format(priceInDong);

    // Add " VND" suffix and replace commas with dots
    formattedPrice += " VND";
    formattedPrice = formattedPrice.replaceAll(',', '.');

    return formattedPrice;
  }
}
