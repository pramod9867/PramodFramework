import 'package:intl/intl.dart';

class CommonAgeValidator {
  static bool isAgeValidate(String birthDateString) {
    String datePattern = "dd/MM/yyyy";

    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 21,
      birthDate.month,
      birthDate.day + 1,
    );

    DateTime oldDate = DateTime(
      birthDate.year + 65,
      birthDate.month,
      birthDate.day,
    );

    print(adultDate.isBefore(today));
    print(oldDate.isAfter(today));

    return adultDate.isBefore(today) && oldDate.isAfter(today);
  }

  static bool isVintageYearValid(String vintageYear) {
    String datePattern = "dd/MM/yyyy";

    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(vintageYear);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 2,
      birthDate.month,
      birthDate.day,
    );

    // DateTime oldDate = DateTime(
    //   birthDate.year + 65,
    //   birthDate.month,
    //   birthDate.day,
    // );

    // print(adultDate.isBefore(today));
    // print(oldDate.isAfter(today));

    return adultDate.isBefore(today);
  }

  static String KmsToMeterst(String km) {
    double kmDouble = double.parse(km);
    return (kmDouble / 1000).toStringAsFixed(2);
  }
}
