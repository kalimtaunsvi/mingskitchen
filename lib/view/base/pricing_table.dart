import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/membership_plan_models.dart';
import 'package:flutter_restaurant/provider/membership_plan_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/view/screens/checkout/payment_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:flutter_restaurant/helper/responsive_helper.dart';
import 'package:flutter_restaurant/provider/profile_provider.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:flutter_restaurant/utill/routes.dart';
import 'package:universal_html/html.dart' as html;

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
                    GestureDetector(
                      onTap: () {
                        print("buy plan tap");
                        String hostname = html.window.location.hostname;
                        String protocol = html.window.location.protocol;
                        String port = html.window.location.port;

                        String _url =
                            "customer_id=${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id}"
                            "&&callback=${AppConstants.BASE_URL}${Routes.ORDER_SUCCESS_SCREEN}&&order_amount=${200}";

                        String _webUrl =
                            "customer_id=${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id}"
                            "&&callback=$protocol//$hostname:$port${Routes.ORDER_WEB_PAYMENT}&&order_amount=${200}&&status=";

                        String _tokenUrl = convert.base64Encode(convert.utf8
                            .encode(ResponsiveHelper.isWeb() ? _webUrl : _url));
                        String selectedUrl =
                            '${AppConstants.BASE_URL}/payment-mobile?token=$_tokenUrl';
                        if (ResponsiveHelper.isWeb()) {
                          html.window.open(selectedUrl, "_self");
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                      fromCheckout: true,
                                      url: selectedUrl,
                                      // placeOrderBody: _placeOrderBody,
                                    )),
                          );
                        }
                      },
                      child: Container(
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
