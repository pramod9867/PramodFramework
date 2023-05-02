import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/utils/typeofversion.dart';

class LoanIdFinderGeneric {
  static String blLoanId = MasterDocumentId.builder.getProductIdGetter("BL");

  static String plLoanId = MasterDocumentId.builder.getProductIdGetter("PL");

  static int blLoanIdINT = MasterDocumentId.builder.getMasterProductIDInt("BL");

  static int plLoanIdINT = MasterDocumentId.builder.getMasterProductIDInt("PL");

  static int glLoanIdINT=-10;

  static String glLoanId = "-10";
}
