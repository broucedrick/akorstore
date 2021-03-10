import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/onboarding/onboarding_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/splash/widget/splash_painter.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);

    Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
    Provider.of<CartProvider>(context, listen: false).getCartData();
    Provider.of<SplashProvider>(context, listen: false).initConfig().then((bool isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    OnBoardingScreen(indicatorColor: ColorResources.GREY, selectedIndicatorColor: ColorResources.COLOR_PRIMARY)));
          }
        });
      }else {
        Provider.of<SplashProvider>(context, listen: false).initConfig().then((bool isSuccess) {
          if(isSuccess) {
            if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      OnBoardingScreen(indicatorColor: ColorResources.GREY, selectedIndicatorColor: ColorResources.COLOR_PRIMARY)));
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Color(0xff0000FF),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff0000FF), Color(0xff00005E)]
              )
            ),
            // child: CustomPaint(
            //   painter: SplashPainter(),
            // ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.splash_logo, height: 250.0, fit: BoxFit.scaleDown, width: 250.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
