import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/localization_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/screen/chat/inbox_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/home/home_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/more_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/notification/notification_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/home/home_screen_test1.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {

  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    HomePageTest(),
    //InboxScreen(isBackButtonExist: false),
    OrderScreen(isBacButtonExist: false),
    NotificationScreen(isBacButtonExist: false),
    MoreScreen(),
  ];
  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int _pageIndex;
    if(Provider.of<SplashProvider>(context, listen: false).fromSetting) {
      _pageIndex = 4;
    }else {
      _pageIndex = 0;
    }

    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavBar(
          key: _bottomNavKey,
          initialSelection: _pageIndex,
          isLtr: Provider.of<LocalizationProvider>(context).isLtr,
          isDark: Provider.of<ThemeProvider>(context).darkTheme,
          tabs: [
            FancyTabData(imagePath: Images.home_image, title: getTranslated('home', context)),
            //FancyTabData(imagePath: Images.message_image, title: getTranslated('inbox', context)),
            FancyTabData(imagePath:Images.shopping_image, title: getTranslated('orders', context)),
            FancyTabData(imagePath: Images.notification, title: getTranslated('notification', context)),
            FancyTabData(imagePath: Images.more_image, title: getTranslated('more', context)),
          ],
          onTabChangedListener: (int index) {
            _pageController.jumpToPage(index);
            _pageIndex = index;
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return _screens[index];
          },
        ),
      ),
    );
  }
}