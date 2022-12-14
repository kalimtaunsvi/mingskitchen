import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/category_provider.dart';
import 'package:flutter_restaurant/provider/theme_provider.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/screens/home/web/widget/category_page_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryViewWeb extends StatefulWidget {
  @override
  State<CategoryViewWeb> createState() => _CategoryViewWebState();
}

class _CategoryViewWebState extends State<CategoryViewWeb> {
  final PageController pageController = PageController();

  void _nextPage() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void _previousPage() {
    pageController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return Column(
          children: [
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(getTranslated('all_categories', context),
                    style: rubikRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE)),
              ],
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Center(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 160,
                          child: category.categoryList != null
                              ? category.categoryList.length > 0
                                  ? CategoryPageView(
                                      categoryProvider: category,
                                      pageController: pageController)
                                  : Center(
                                      child: Text(getTranslated(
                                          'no_category_available', context)))
                              : Center(child: CategoryShimmer()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: 7,
        // padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled:
                  Provider.of<CategoryProvider>(context).categoryList == null,
              child: Column(children: [
                Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[
                        Provider.of<ThemeProvider>(context).darkTheme
                            ? 800
                            : 300],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[
                        Provider.of<ThemeProvider>(context).darkTheme
                            ? 800
                            : 300],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: Provider.of<CategoryProvider>(context).categoryList == null,
          child: Column(children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}
