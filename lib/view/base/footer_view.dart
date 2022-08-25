import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/routes.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/base/on_hover.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_restaurant/helper/email_checker.dart';
import 'package:flutter_restaurant/provider/news_letter_controller.dart';
import 'package:flutter_restaurant/provider/splash_provider.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/view/base/custom_snackbar.dart';
import 'package:provider/provider.dart';

class FooterView extends StatelessWidget {
  const FooterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _newsLetterController = TextEditingController();
    return Theme(
      data: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: ColorResources.COLOR_WHITE,
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: ColorResources.COLOR_WHITE),
        child: Container(
          color: ColorResources.getFooterColor(context),
          width: double.maxFinite,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: Dimensions.WEB_SCREEN_WIDTH,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE * 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated('company', context),
                                    style: dancingScriptRegular,
                                  ),
                                  Text(
                                    " __",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize:
                                          Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                                      color: ColorResources.APPBAR_HEADER_COL0R,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.getAboutUsRoute()),
                                    child: Text(
                                        ">   " +
                                            getTranslated('about_us', context),
                                        style: hovered
                                            ? robotoRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                              )
                                            : rubikRegular.copyWith(
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT)));
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.getSupportRoute()),
                                  child: Text(
                                    ">   " +
                                        getTranslated(
                                          'contact_us',
                                          context,
                                        ),
                                    style: hovered
                                        ? robotoRegular.copyWith(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                          )
                                        : rubikRegular.copyWith(
                                            color: ColorResources.COLOR_WHITE,
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT),
                                  ),
                                );
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.getPolicyRoute()),
                                    child: Text(
                                        ">   " +
                                            getTranslated(
                                                'privacy_policy', context),
                                        style: hovered
                                            ? robotoRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                              )
                                            : rubikRegular.copyWith(
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT)));
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.getTermsRoute()),
                                    child: Text(
                                        ">   " +
                                            getTranslated(
                                              'terms_and_condition',
                                              context,
                                            ),
                                        style: hovered
                                            ? robotoRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                              )
                                            : rubikRegular.copyWith(
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT)));
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE * 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated('contact', context),
                                    style: dancingScriptRegular,
                                  ),
                                  Text(
                                    " __",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize:
                                          Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                                      color: ColorResources.APPBAR_HEADER_COL0R,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.getPolicyRoute()),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: ColorResources.COLOR_WHITE,
                                        size: Dimensions.FONT_SIZE_LARGE,
                                      ),
                                      SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          "120 2nd Avenue North, Saskatoon, SK, Canada, Saskatchewan",
                                          style: hovered
                                              ? robotoRegular.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.6,
                                                )
                                              : rubikRegular.copyWith(
                                                  color: ColorResources
                                                      .COLOR_WHITE,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_DEFAULT),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.getPolicyRoute()),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: ColorResources.COLOR_WHITE,
                                        size: Dimensions.FONT_SIZE_LARGE,
                                      ),
                                      SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL,
                                      ),
                                      Text(
                                        "(530) 625-9694",
                                        style: hovered
                                            ? robotoRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                              )
                                            : rubikRegular.copyWith(
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              OnHover(builder: (hovered) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.getPolicyRoute()),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: ColorResources.COLOR_WHITE,
                                        size: Dimensions.FONT_SIZE_LARGE,
                                      ),
                                      SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL,
                                      ),
                                      Text(
                                        "info@mingskitchen.ca",
                                        style: hovered
                                            ? robotoRegular.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                              )
                                            : rubikRegular.copyWith(
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [],
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE * 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated('opening', context),
                                    style: dancingScriptRegular,
                                  ),
                                  Text(
                                    " __",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize:
                                          Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                                      color: ColorResources.APPBAR_HEADER_COL0R,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),
                              Text(
                                "Monday - Saturday",
                                style: rubikRegular.copyWith(
                                  color: ColorResources.COLOR_WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Text(
                                "5:00 AM-11:00 PM",
                                style: rubikRegular.copyWith(
                                  color: ColorResources.COLOR_WHITE_GRAY,
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Text(
                                getTranslated("download_our_apps", context),
                                style: rubikRegular.copyWith(
                                  color: ColorResources.COLOR_WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),
                              Row(
                                children: [
                                  Image.asset(
                                    Images.google_play_bandge,
                                    width: 120,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svgs/App_Store_Badge.svg",
                                    width: 100,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),

                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated('newsletter', context),
                                    style: dancingScriptRegular,
                                  ),
                                  Text(
                                    " __",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize:
                                          Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                                      color: ColorResources.APPBAR_HEADER_COL0R,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL),
                              Text(getTranslated('subscribe_to_our', context),
                                  style: rubikRegular.copyWith(
                                      color: ColorResources.COLOR_WHITE_GRAY,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),

                              Container(
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.COLOR_BLACK
                                            .withOpacity(0.05),
                                        blurRadius: 2,
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: TextField(
                                      controller: _newsLetterController,
                                      style: rubikMedium.copyWith(
                                          color: ColorResources.COLOR_BLACK),
                                      decoration: InputDecoration(
                                        hintText: getTranslated(
                                            'your_email_address', context),
                                        hintStyle: rubikRegular.copyWith(
                                            color: ColorResources.getGreyColor(
                                                context),
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                    )),
                                    InkWell(
                                      onTap: () {
                                        String email = _newsLetterController
                                            .text
                                            .trim()
                                            .toString();
                                        if (email.isEmpty) {
                                          showCustomSnackBar(
                                              getTranslated(
                                                  'enter_email_address',
                                                  context),
                                              context);
                                        } else if (EmailChecker.isNotValid(
                                            email)) {
                                          showCustomSnackBar(
                                              getTranslated(
                                                  'enter_valid_email', context),
                                              context);
                                        } else {
                                          Provider.of<NewsLetterProvider>(
                                                  context,
                                                  listen: false)
                                              .addToNewsLetter(context, email)
                                              .then((value) {
                                            _newsLetterController.clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                            getTranslated('subscribe', context),
                                            style: rubikRegular.copyWith(
                                                color: Colors.white,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT),

                              // const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                              Consumer<SplashProvider>(
                                  builder: (context, splashProvider, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (splashProvider.configModel
                                                .socialMediaLink.length !=
                                            null &&
                                        splashProvider.configModel
                                                .socialMediaLink.length >
                                            0)
                                      Text(
                                        getTranslated('follow_us_on', context),
                                        style: rubikRegular.copyWith(
                                            color:
                                                ColorResources.COLOR_WHITE_GRAY,
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT),
                                      ),
                                    Container(
                                      height: 50,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: splashProvider
                                            .configModel.socialMediaLink.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          String name = splashProvider
                                              .configModel
                                              .socialMediaLink[index]
                                              .name;
                                          String icon;
                                          if (name == 'facebook') {
                                            icon = Images.facebook_icon;
                                          } else if (name == 'linkedin') {
                                            icon = Images.linked_in_icon;
                                          } else if (name == 'youtube') {
                                            icon = Images.youtube_icon;
                                          } else if (name == 'twitter') {
                                            icon = Images.twitter_icon;
                                          } else if (name == 'instagram') {
                                            icon = Images.in_sta_gram_icon;
                                          } else if (name == 'pinterest') {
                                            icon = Images.pinterest;
                                          }
                                          return splashProvider.configModel
                                                      .socialMediaLink.length >
                                                  0
                                              ? InkWell(
                                                  onTap: () {
                                                    _launchURL(splashProvider
                                                        .configModel
                                                        .socialMediaLink[index]
                                                        .link);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Image.asset(icon,
                                                        height: Dimensions
                                                            .PADDING_SIZE_EXTRA_LARGE,
                                                        width: Dimensions
                                                            .PADDING_SIZE_EXTRA_LARGE,
                                                        fit: BoxFit.contain),
                                                  ),
                                                )
                                              : SizedBox();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),

                              const SizedBox(
                                  height: Dimensions.PADDING_SIZE_LARGE),
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child:
                      Divider(thickness: .1, color: ColorResources.COLOR_WHITE),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 500.0,
                      child: Text(
                          "©Copyright 2022 Mings Kitchen- All Right reserved! Developed By DeelComm",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnHover(builder: (hovered) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.getProfileRoute());
                            },
                            child: Text(
                              getTranslated('profile', context),
                              style: hovered
                                  ? robotoRegular.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                    )
                                  : rubikRegular.copyWith(
                                      color: ColorResources.COLOR_WHITE,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT),
                            ),
                          );
                        }),
                        const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        OnHover(builder: (hovered) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.getAddressRoute());
                              },
                              child: Text(getTranslated('address', context),
                                  style: hovered
                                      ? robotoRegular.copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                        )
                                      : rubikRegular.copyWith(
                                          color: ColorResources.COLOR_WHITE,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT)));
                        }),
                        const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        OnHover(builder: (hovered) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    Routes.getChatRoute(orderModel: null));
                              },
                              child: Text(getTranslated('live_chat', context),
                                  style: hovered
                                      ? robotoRegular.copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                        )
                                      : rubikRegular.copyWith(
                                          color: ColorResources.COLOR_WHITE,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT)));
                        }),
                        const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        OnHover(builder: (hovered) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.getDashboardRoute('order'));
                              },
                              child: Text(getTranslated('my_order', context),
                                  style: hovered
                                      ? robotoRegular.copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                        )
                                      : rubikRegular.copyWith(
                                          color: ColorResources.COLOR_WHITE,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT)));
                        }),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
