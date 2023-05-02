class ProductIdFetcher {
  static String getPorductName(int index) {
    switch (index) {
      case 3:
        return "Personal";
      case 9:
        return "Business";
      case 13:
        return "Business";
      case 7:
        return "Personal";
      case 16:
        return "Personal";
      case -10:
        return "Gold";
      default:
        return "Personal";
    }
  }
}
