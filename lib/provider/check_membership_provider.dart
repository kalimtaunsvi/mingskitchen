import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/data/model/response/check_membership.dart';
import 'package:flutter_restaurant/data/model/response/coupon_model.dart';
import 'package:flutter_restaurant/data/repository/auth_repo.dart';
import 'package:flutter_restaurant/data/repository/check_membership_repo.dart';
import 'package:flutter_restaurant/helper/api_checker.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckMembershipProvider extends ChangeNotifier {
  final CheckMembershipRepo checkMembershipRepo;
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  CheckMembershipProvider(
      {@required this.checkMembershipRepo,
      @required this.authRepo,
      @required this.sharedPreferences});

  List<CouponModel> _couponList;
  bool _isLoading = false;
  CheckMembership _checkMembership;

  bool get isLoading => _isLoading;
  List<CouponModel> get couponList => _couponList;
  CheckMembership get checkMembership => _checkMembership;

  Future<void> checkUserMembership(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    if (sharedPreferences.containsKey(AppConstants.USER_ID)) {
      final userId = sharedPreferences.getString(AppConstants.USER_ID) ?? "";
      ApiResponse apiResponse =
          await checkMembershipRepo.checkMembership(userId: userId);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        if (apiResponse.response.data["id"] != null) {
          _checkMembership =
              CheckMembership.fromJson(apiResponse.response.data);
        } else {
          _checkMembership = null;
        }
        _isLoading = false;
        notifyListeners();
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
    } else {
      _checkMembership = null;
      _isLoading = false;
      notifyListeners();
    }
  }
}
