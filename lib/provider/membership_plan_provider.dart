import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/data/model/response/membership_plan_models.dart';
import 'package:flutter_restaurant/data/repository/membership_plain_repo.dart';

class MembershipPlansProvider extends ChangeNotifier {
  final MembershipPlainRepo membershipPlainRepo;
  MembershipPlansProvider({@required this.membershipPlainRepo});

  List<MembershipPlanModel> _memberPlanList;
  // List<Product> _productList = [];

  List<MembershipPlanModel> get memberPlanList => _memberPlanList;

  Future<void> getMemberPlansList(BuildContext context) async {
    _memberPlanList = [];
    ApiResponse apiResponse = await membershipPlainRepo.getMemberhipPlans();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      apiResponse.response.data.forEach((category) {
        MembershipPlanModel membershipPlanModel =
            MembershipPlanModel.fromJson(category);
        _memberPlanList.add(membershipPlanModel);
      });
      notifyListeners();
    }
  }
}
