import 'package:universal_html/html.dart' as html;

Future<bool> buyPlain({
  String userId,
  String amount,
  int membershipId,
}) async {
  String selectedUrl =
      "https://admin.mingskitchen.ca/api/v1/buyplan?user_id=$userId&amount=$amount&membership_id=$membershipId";

  html.window.open(selectedUrl, "_self");
}
