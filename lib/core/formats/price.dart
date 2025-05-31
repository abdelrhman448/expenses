import '../shared_pref/shared_pref_helper.dart';
import '../utils/constants/shared_preference_constants.dart';

String? priceViewFormat(String price) {
  String priceWillView=double.parse(price.isNotEmpty?price:"0").toStringAsFixed(2);
  return priceWillView.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[0]},");
}



