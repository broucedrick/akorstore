import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/banner_provider.dart';
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
import 'package:sixvalley_ui_kit/provider/product_details_provider_test.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/support_ticket_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/provider/tracking_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';

import 'data/repository/auth_repo.dart';
import 'data/repository/banner_repo.dart';
import 'data/repository/brand_repo.dart';
import 'data/repository/cart_repo.dart';
import 'data/repository/category_repo.dart';
import 'data/repository/chat_repo.dart';
import 'data/repository/coupon_repo.dart';
import 'data/repository/mega_deal_repo.dart';
import 'data/repository/notification_repo.dart';
import 'data/repository/onboarding_repo.dart';
import 'data/repository/order_repo.dart';
import 'data/repository/product_details_repo.dart';
import 'data/repository/product_repo.dart';
import 'data/repository/profile_repo.dart';
import 'data/repository/search_repo.dart';
import 'data/repository/seller_repo.dart';
import 'data/repository/splash_repo.dart';
import 'data/repository/support_ticket_repo.dart';
import 'data/repository/tracking_repo.dart';
import 'data/repository/wishlist_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton(() => CategoryRepo());
  sl.registerLazySingleton(() => MegaDealRepo());
  sl.registerLazySingleton(() => BrandRepo());
  sl.registerLazySingleton(() => ProductRepo());
  sl.registerLazySingleton(() => BannerRepo());
  sl.registerLazySingleton(() => OnBoardingRepo());
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo());
  sl.registerLazySingleton(() => SearchRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderRepo());
  sl.registerLazySingleton(() => SellerRepo());
  sl.registerLazySingleton(() => CouponRepo());
  sl.registerLazySingleton(() => ChatRepo());
  sl.registerLazySingleton(() => NotificationRepo());
  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => WishListRepo());
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SupportTicketRepo());
  sl.registerLazySingleton(() => TrackingRepo());

  // Provider
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => MegaDealProvider(megaDealRepo: sl()));
  sl.registerFactory(() => BrandProvider(brandRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProductDetailsProvider(productDetailsRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl(),));
  sl.registerFactory(() => SellerProvider(sellerRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => SupportTicketProvider(supportTicketRepo: sl()));
  sl.registerFactory(() => TrackingProvider(trackingRepo: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
