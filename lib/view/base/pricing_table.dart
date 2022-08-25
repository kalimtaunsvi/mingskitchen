import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/membership_plan_models.dart';
import 'package:flutter_restaurant/provider/membership_plan_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PricingTable extends StatelessWidget {
  const PricingTable({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MembershipPlansProvider>(
        builder: (context, membershipPlansProvider, _) {
      final List<MembershipPlanModel> memberPlanList =
          membershipPlansProvider.memberPlanList;
      if (memberPlanList.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Wrap(
        alignment: WrapAlignment.center,
        children: memberPlanList
            .map(
              (membershipPlanModel) => BestValuePackage(
                membershipPlanModel: membershipPlanModel,
              ),
            )
            .toList(),
      );
    });
  }
}

class BestValuePackage extends StatelessWidget {
  const BestValuePackage({
    Key key,
    this.membershipPlanModel,
  }) : super(key: key);

  final MembershipPlanModel membershipPlanModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 285,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: ColorResources.APPBAR_HEADER_COL0R,
                ),
                // child: Text(
                //   "Best Value",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w700,
                //     fontSize: 16,
                //     height: 1.5,
                //     color: Colors.white,
                //   ),
                // ),
              ),
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  color: Color(0xff023047),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      membershipPlanModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        height: 1.30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      r"$" + membershipPlanModel.price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        height: 1.66,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "${membershipPlanModel.duration} months",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        height: 1.39,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      membershipPlanModel.des,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Discount : " + membershipPlanModel.discount + "%",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        height: 1.33,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 35),
                    Container(
                      width: 220,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: ColorResources.APPBAR_HEADER_COL0R,
                      ),
                      child: Center(
                        child: Text(
                          "Buy Plan",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            height: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              "assets/svgs/pricing_table_card.svg",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
