import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/onboarding_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Provider.of<ThemeProvider>(context).darkTheme ? SizedBox() : Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(Images.background, fit: BoxFit.fill),
          ),
          Consumer<OnBoardingProvider>(
            builder: (context, onBoardingList, child) => Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    itemCount: onBoardingList.onBoardingList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                            Expanded(flex: 2, child: Image.asset(onBoardingList.onBoardingList[index].imageUrl)),
                            Text(onBoardingList.onBoardingList[index].title,
                                style: titilliumBold.copyWith(fontSize: 30)),
                            Text(onBoardingList.onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular),
                          ],
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      onBoardingList.changeSelectIndex(index);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _pageIndicators(onBoardingList.onBoardingList, context),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 70),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              ColorResources.getBlue(context),
                              ColorResources.getBlue(context),
                            ])),
                        child: FlatButton(
                          onPressed: () {
                            if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
                            } else {
                              _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1
                                ? getTranslated('GET_STARTED', context) : getTranslated('NEXT', context),
                                style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? 18 : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
