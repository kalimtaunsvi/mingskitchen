import 'package:flutter/material.dart';
import 'package:flutter_restaurant/helper/product_type.dart';
import 'package:flutter_restaurant/helper/responsive_helper.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/auth_provider.dart';
import 'package:flutter_restaurant/provider/banner_provider.dart';
import 'package:flutter_restaurant/provider/cart_provider.dart';
import 'package:flutter_restaurant/provider/category_provider.dart';
import 'package:flutter_restaurant/provider/localization_provider.dart';
import 'package:flutter_restaurant/provider/membership_plan_provider.dart';
import 'package:flutter_restaurant/provider/order_provider.dart';
import 'package:flutter_restaurant/provider/product_provider.dart';
import 'package:flutter_restaurant/provider/profile_provider.dart';
import 'package:flutter_restaurant/provider/set_menu_provider.dart';
import 'package:flutter_restaurant/provider/splash_provider.dart';
import 'package:flutter_restaurant/provider/theme_provider.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/utill/routes.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/base/footer_view.dart';
import 'package:flutter_restaurant/view/base/on_hover.dart';
import 'package:flutter_restaurant/view/base/pricing_table.dart';
import 'package:flutter_restaurant/view/base/title_widget.dart';
import 'package:flutter_restaurant/view/base/web_app_bar.dart';
import 'package:flutter_restaurant/view/screens/home/web/widget/category_web_view.dart';
import 'package:flutter_restaurant/view/screens/home/web/widget/set_menu_view_web.dart';
import 'package:flutter_restaurant/view/screens/home/widget/all_product_view.dart';
import 'package:flutter_restaurant/view/screens/home/widget/category_view.dart';
import 'package:flutter_restaurant/view/screens/home/widget/main_slider.dart';
import 'package:flutter_restaurant/view/screens/home/widget/product_view.dart';
import 'package:flutter_restaurant/view/screens/home/widget/set_menu_view.dart';
import 'package:flutter_restaurant/view/screens/menu/widget/options_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool fromAppBar;
  HomeScreen(this.fromAppBar);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  final priceTableKey = GlobalKey();

  Future<void> _loadData(BuildContext context, bool reload) async {
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }
    if (reload) {
      Provider.of<ProductProvider>(context, listen: false).seeMoreReturn();
      Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
        context,
        true,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
      );
      Provider.of<SetMenuProvider>(context, listen: false).getSetMenuList(
        context,
        reload,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
      );

      Provider.of<BannerProvider>(context, listen: false)
          .getBannerList(context, reload);
      Provider.of<CategoryProvider>(context, listen: false)
          .getAllCategoryProductList(
        context,
        reload,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
      );
    } else {
      Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
        context,
        true,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
      );

      Provider.of<SetMenuProvider>(context, listen: false).getSetMenuList(
        context,
        reload,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
      );
      Provider.of<BannerProvider>(context, listen: false)
          .getBannerList(context, reload);
    }

    Provider.of<MembershipPlansProvider>(context, listen: false)
        .getMemberPlansList(context);
    Provider.of<ProductProvider>(context, listen: false).getLatestProductList(
      context,
      false,
      '1',
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );

    await Provider.of<ProductProvider>(context, listen: false)
        .getPopularProductList(
      context,
      false,
      '1',
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );

    Provider.of<CategoryProvider>(context, listen: false)
        .getAllCategoryProductList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
  }

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).seeMoreReturn();
    if (!widget.fromAppBar ||
        Provider.of<CategoryProvider>(context, listen: false).categoryList ==
            null) {
      _loadData(context, false);
    }
    super.initState();
  }

  Future _scrollToCounter(int c) async {
    final scrollContext = priceTableKey.currentContext;
    await Scrollable.ensureVisible(scrollContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerGlobalKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: ResponsiveHelper.isDesktop(context)
          ? Theme.of(context).cardColor
          : ColorResources.getBackgroundColor(context),
      drawer: ResponsiveHelper.isTab(context)
          ? Drawer(child: OptionsView(onTap: null))
          : SizedBox(),
      appBar: ResponsiveHelper.isDesktop(context)
          ? PreferredSize(
              child: WebAppBar(
                scrollToCounter: _scrollToCounter,
              ),
              preferredSize: Size.fromHeight(100))
          : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            Provider.of<OrderProvider>(context, listen: false)
                .changeStatus(true, notify: true);
            Provider.of<ProductProvider>(context, listen: false).latestOffset =
                1;
            Provider.of<SplashProvider>(context, listen: false)
                .initConfig(context)
                .then((value) {
              if (value) {
                _loadData(context, true);
              }
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: ResponsiveHelper.isDesktop(context)
              ? _scrollView(_scrollController, context)
              : Stack(
                  children: [
                    _scrollView(_scrollController, context),
                    Consumer<SplashProvider>(
                        builder: (context, splashProvider, _) {
                      return !splashProvider.isRestaurantOpenNow(context)
                          ? Positioned(
                              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              left: 0,
                              right: 0,
                              child: Consumer<OrderProvider>(
                                builder: (context, orderProvider, _) {
                                  return orderProvider.isRestaurantCloseShow
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          alignment: Alignment.center,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.9),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    horizontal: Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                child: Text(
                                                  '${'${getTranslated('restaurant_is_close_now', context)}'}',
                                                  style: rubikRegular.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => orderProvider
                                                    .changeStatus(false,
                                                        notify: true),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  child: Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.white,
                                                      size: Dimensions
                                                          .PADDING_SIZE_LARGE),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox();
                                },
                              ),
                            )
                          : SizedBox();
                    })
                  ],
                ),
        ),
      ),
    );
  }

  Scrollbar _scrollView(
      ScrollController _scrollController, BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(controller: _scrollController, slivers: [
        // AppBar
        ResponsiveHelper.isDesktop(context)
            ? SliverToBoxAdapter(child: SizedBox())
            : SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).cardColor,
                pinned: ResponsiveHelper.isTab(context) ? true : false,
                leading: ResponsiveHelper.isTab(context)
                    ? IconButton(
                        onPressed: () =>
                            drawerGlobalKey.currentState.openDrawer(),
                        icon: Icon(Icons.menu, color: Colors.black),
                      )
                    : null,
                title: Consumer<SplashProvider>(
                    builder: (context, splash, child) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveHelper.isWeb()
                                ? FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder_rectangle,
                                    height: 40,
                                    width: 40,
                                    image: splash.baseUrls != null
                                        ? '${splash.baseUrls.restaurantImageUrl}/${splash.configModel.restaurantLogo}'
                                        : '',
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder_rectangle,
                                        height: 40,
                                        width: 40),
                                  )
                                : Image.asset(Images.logo,
                                    width: 40, height: 40),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                ResponsiveHelper.isWeb()
                                    ? splash.configModel.restaurantName
                                    : AppConstants.APP_NAME,
                                style: rubikBold.copyWith(
                                    color: Theme.of(context).primaryColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.getNotificationRoute()),
                    icon: Icon(Icons.notifications,
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                  ResponsiveHelper.isTab(context)
                      ? IconButton(
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.getDashboardRoute('cart')),
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(Icons.shopping_cart,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      Provider.of<CartProvider>(context)
                                          .cartList
                                          .length
                                          .toString(),
                                      style: rubikMedium.copyWith(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),

        // Search Button
        if (!ResponsiveHelper.isWeb())
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
                child: Center(
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getSearchRoute()),
                child: Container(
                  height: 60,
                  width: 1170,
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.getSearchBg(context),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: Icon(Icons.search, size: 25)),
                      Expanded(
                          child: Text(
                              getTranslated('search_items_here', context),
                              style: rubikRegular.copyWith(fontSize: 12))),
                    ]),
                  ),
                ),
              ),
            )),
          ),

        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // shrinkWrap: true,
              children: [
                MainSlider(),
                ResponsiveHelper.isDesktop(context)
                    ? CategoryViewWeb()
                    : CategoryView(),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Center(
                  child: SizedBox(
                    width: Dimensions.getScreeenSize(context).width * 0.86,
                    child: AllProductView(),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      getTranslated('join_membership', context),
                      style: rubikRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                ),
                Center(
                  child: SizedBox(
                    key: priceTableKey,
                    width: Dimensions.getScreeenSize(context).width * 0.83,
                    child: PricingTable(),
                  ),
                ),
                if (ResponsiveHelper.isDesktop(context))
                  Center(
                    child: SizedBox(
                      width: Dimensions.getScreeenSize(context).width * 0.86,
                      child: SetMenuViewWeb(),
                    ),
                  )
                else
                  SetMenuView(),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                ),
                ResponsiveHelper.isDesktop(context)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                              getTranslated('popular_item', context),
                              style: rubikRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: TitleWidget(
                            title: getTranslated('popular_item', context)),
                      ),
                Center(
                  child: SizedBox(
                    width: Dimensions.getScreeenSize(context).width * 0.86,
                    child: ProductView(
                      productType: ProductType.POPULAR_PRODUCT,
                      scrollController: _scrollController,
                    ),
                  ),
                ),
                // ResponsiveHelper.isMobile(context)
                // ? SizedBox()
                // : Center(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         RichText(
                //           text: TextSpan(
                //             text: '____   ',
                //             style: TextStyle(
                //               fontSize: Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                //               color: ColorResources.APPBAR_HEADER_COL0R,
                //               fontWeight: FontWeight.w900,
                //             ),
                //             children: <TextSpan>[
                //               TextSpan(
                //                 text: 'Team Members',
                //                 style: dancingScriptRegular,
                //               ),
                //               TextSpan(text: '   _____'),
                //             ],
                //           ),
                //         ),
                //         Text(
                //           "Our Master Chefs",
                //           style: TextStyle(
                //             fontWeight: FontWeight.w900,
                //             fontSize: Dimensions.FONT_SIZE_OVER_TOO_LARGE,
                //           ),
                //         ),
                //         SizedBox(
                //           height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                //         ),
                //         // Container(
                //         //   width: Dimensions.getScreeenSize(context).width *
                //         //       0.86,
                //         //   child: GridView.builder(
                //         //     padding: const EdgeInsets.symmetric(
                //         //       horizontal: Dimensions.PADDING_SIZE_LARGE,
                //         //     ),
                //         //     shrinkWrap: true,
                //         //     gridDelegate:
                //         //         SliverGridDelegateWithMaxCrossAxisExtent(
                //         //       maxCrossAxisExtent: 300,
                //         //       mainAxisExtent: 340,
                //         //       mainAxisSpacing: 10,
                //         //       crossAxisSpacing: 10,
                //         //     ),
                //         //     itemCount: 4,
                //         //     itemBuilder: (context, index) {
                //         //       return TeamMemberWidget();
                //         //     },
                //         //   ),
                //         // ),
                //         Wrap(
                //           children: [1, 2, 3, 4]
                //               .map(
                //                 (e) => TeamMemberWidget(),
                //               )
                //               .toList(),
                //         ),
                //         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                //       ],
                //     ),
                //   ),

                ResponsiveHelper.isMobile(context)
                    ? SizedBox()
                    : Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          width:
                              Dimensions.getScreeenSize(context).width * 0.86,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              ServiceCard(
                                title: "Master Chefs",
                                iconData: Icons.person,
                                description:
                                    "We have well trained professional cooks and tradesman who is proficient in all aspects of food preparation.",
                              ),
                              ServiceCard(
                                title: "Quality Food",
                                iconData: Icons.fastfood,
                                description:
                                    "We aim to provide customers with supreme taste, impressive quality service and pleasant dining experiences, continuing to challenge ourselves.",
                              ),
                              ServiceCard(
                                title: "Online Order",
                                iconData: Icons.shopping_cart,
                                description:
                                    "Fast and easy food delivery from any branch of Ming's Kitchen near you.A large variety of cuisines, diverse dishes.Safe, easy & secure payment options.",
                              ),
                              ServiceCard(
                                title: "24/7 Support",
                                iconData: Icons.headphones,
                                description:
                                    "We provide 24/7 Support to help our customers if they have any issues with ordering & booking or any other customers can get help and find answers to questions.",
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                ),
                if (ResponsiveHelper.isDesktop(context)) FooterView(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
//ResponsiveHelper

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 60 ||
        oldDelegate.minExtent != 60 ||
        child != oldDelegate.child;
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  const ServiceCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: OnHover(
        builder: (bool isHovered) {
          return Card(
            color: isHovered
                ? ColorResources.APPBAR_HEADER_COL0R
                : Provider.of<ThemeProvider>(context).darkTheme
                    ? Color(0xFF494949)
                    : Colors.white,
            child: Container(
              width: 270,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    size: 60,
                    color: isHovered
                        ? ColorResources.COLOR_WHITE
                        : ColorResources.APPBAR_HEADER_COL0R,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Text(
                    title,
                    style: rubikRegular.copyWith(
                      color: isHovered
                          ? ColorResources.COLOR_WHITE
                          : ColorResources.COLOR_BLACK,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Text(
                    description,
                    style: rubikRegular.copyWith(
                      color: isHovered
                          ? ColorResources.COLOR_WHITE
                          : ColorResources.COLOR_BLACK,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TeamMemberWidget extends StatefulWidget {
  @override
  _TeamMemberWidgetState createState() => _TeamMemberWidgetState();
}

class _TeamMemberWidgetState extends State<TeamMemberWidget> {
  double elevation = 4.0;
  double scale = 1.0;
  bool isHover = false;
  double opacity = 0.0;
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: InkWell(
        onTap: () {},
        onHover: (value) {
          setState(() {
            isHover = value;
          });
          if (value) {
            setState(() {
              opacity = 1;
              elevation = 20.0;
              scale = 1.2;
            });
          } else {
            setState(() {
              opacity = 0;
              elevation = 4.0;
              scale = 1;
            });
          }
        },
        child: Card(
          elevation: 1.5,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: AnimatedScale(
                      scale: scale,
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      child: Material(
                        elevation: elevation,
                        child: Image.network(
                          'https://technext.github.io/restoran/img/team-1.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(
                  "Full Name",
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(
                  "Designation",
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 28,
                              height: 37,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.orange,
                              ),
                              child: Icon(
                                FontAwesomeIcons.facebook,
                                size: 18,
                                color: ColorResources.COLOR_WHITE,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 28,
                              height: 37,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.orange,
                              ),
                              child: Icon(
                                FontAwesomeIcons.twitter,
                                size: 18,
                                color: ColorResources.COLOR_WHITE,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            width: 28,
                            height: 37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.orange,
                            ),
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              size: 18,
                              color: ColorResources.COLOR_WHITE,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
