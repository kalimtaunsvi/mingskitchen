import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/data/model/response/check_membership.dart';
import 'package:flutter_restaurant/data/model/response/coupon_model.dart';
import 'package:flutter_restaurant/data/repository/auth_repo.dart';
import 'package:flutter_restaurant/data/repository/check_membership_repo.dart';
import 'package:flutter_restaurant/helper/api_checker.dart';

class CheckMembershipProvider extends ChangeNotifier {
  final CheckMembershipRepo checkMembershipRepo;
  final AuthRepo authRepo;

  CheckMembershipProvider(
      {@required this.checkMembershipRepo, @required this.authRepo});

  List<CouponModel> _couponList;
  CouponModel _coupon;
  double _discount = 0.0;
  String _code = '';
  bool _isLoading = false;
  CheckMembership _checkMembership;

  CouponModel get coupon => _coupon;
  double get discount => _discount;
  String get code => _code;
  bool get isLoading => _isLoading;
  List<CouponModel> get couponList => _couponList;
  CheckMembership get checkMembership => _checkMembership;

  Future<void> checkUserMembership(BuildContext context) async {
    if (authRepo.isLoggedIn()) {
      _isLoading = true;
      ApiResponse apiResponse = await checkMembershipRepo.checkMembership();
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _checkMembership = CheckMembership.fromJson(apiResponse.response.data);
        _isLoading = false;
        notifyListeners();
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
    } else {}
  }
}
