import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/membership_plan_models.dart';
import 'package:flutter_restaurant/helper/responsive_helper.dart';
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
        alignment: WrapAlignment.spaceBetween,
        children: [
          if (ResponsiveHelper.isMobile(context))
            Center(
              child: BasicPackage(
                membershipPlanModel: memberPlanList.first,
              ),
            )
          else
            BasicPackage(
              membershipPlanModel: memberPlanList.first,
            ),
          if (ResponsiveHelper.isMobile(context))
            Center(
              child: BestValuePackage(
                membershipPlanModel: memberPlanList[1],
              ),
            )
          else
            BestValuePackage(
              membershipPlanModel: memberPlanList[1],
            ),
          if (ResponsiveHelper.isDesktop(context))
            BusinessPackage(
              membershipPlanModel: memberPlanList.last,
            )
          else
            Center(
              child: BusinessPackage(
                membershipPlanModel: memberPlanList.last,
              ),
            )
        ],
      );
    });
  }
}

class BusinessPackage extends StatelessWidget {
  const BusinessPackage({
    Key key,
    this.membershipPlanModel,
  }) : super(key: key);

  final MembershipPlanModel membershipPlanModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      height: 500,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xff023047),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membershipPlanModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.39,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          r"$" + membershipPlanModel.price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          "/ ${membershipPlanModel.duration} months",
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      membershipPlanModel.des,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: "Unlimited Files"),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: "Unlimited Storage"),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: "Phone Support"),
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
                          "Choose Plan",
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
      height: 500,
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
                child: Text(
                  "Best Value",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membershipPlanModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.39,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          r"$" + membershipPlanModel.price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          "/ ${membershipPlanModel.duration} months",
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      membershipPlanModel.des,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    _CheckboxWithTitle(
                      title: "Unlimited Files",
                      color: Colors.white,
                    ),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(
                      title: "25 GB Storage",
                      color: Colors.white,
                    ),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(
                      title: "Phone Support",
                      color: Colors.white,
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
                          "Choose Plan",
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

class BasicPackage extends StatelessWidget {
  const BasicPackage({
    Key key,
    this.membershipPlanModel,
  }) : super(key: key);

  final MembershipPlanModel membershipPlanModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      height: 500,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xff023047),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membershipPlanModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.39,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          r"$" + membershipPlanModel.price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          "/ ${membershipPlanModel.duration} Months",
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.66,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      membershipPlanModel.des,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: "15 Files"),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: "10 GB Storage"),
                    SizedBox(height: 26),
                    _CheckboxWithTitle(title: " Email Support"),
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
                          "Choose Plan",
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

class _CheckboxWithTitle extends StatelessWidget {
  const _CheckboxWithTitle({
    Key key,
    @required this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff06D6A0),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 12,
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            height: 1.33,
            color: color != null ? color : Colors.white,
          ),
        ),
      ],
    );
  }
}
