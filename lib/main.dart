import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/brand_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/chat_provider.dart';
import 'package:sixvalley_ui_kit/provider/coupon_provider.dart';
import 'package:sixvalley_ui_kit/provider/localization_provider.dart';
import 'package:sixvalley_ui_kit/provider/mega_deal_provider.dart';
import 'package:sixvalley_ui_kit/provider/notification_provider.dart';
import 'package:sixvalley_ui_kit/provider/onboarding_provider.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/support_ticket_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/provider/tracking_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/theme/dark_theme.dart';
import 'package:sixvalley_ui_kit/theme/light_theme.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/view/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'provider/product_details_provider_test.dart';
import 'provider/banner_provider.dart';
import 'provider/product_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MegaDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TrackingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: 'sixValley UI Kit',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: SplashScreen(),
    );
  }
}
