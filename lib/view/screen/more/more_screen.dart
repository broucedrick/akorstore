import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/boutique/boutique_screen.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/guest_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/category/all_category_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/chat/inbox_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/web_view_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/more/widget/app_info_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/more/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/notification/notification_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/offer/offers_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/profile_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/setting/settings_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/support/support_ticket_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:nanoid/nanoid.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(Provider.of<AuthProvider>(context, listen: false).getUserToken());
    NetworkInfo.checkConnectivity(context);
    //debugPrint();

    return Scaffold(
      body: Stack(children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            Images.more_page_header,
            height: 150,
            fit: BoxFit.fill,
            color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
          ),
        ),

        // AppBar
        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                Image.asset(Images.akorit_text, height: 35, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                // Text(!isGuestMode ? profile.userInfoModel != null ? '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}' : 'Full Name' : 'Guest',
                //     style: titilliumRegular.copyWith(color: ColorResources.WHITE)),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                // InkWell(
                //   onTap: () {
                //     if(isGuestMode) {
                //       showAnimatedDialog(context, GuestDialog(), isFlip: true);
                //     }else {
                //       if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel != null) {
                //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                //       }
                //     }
                //   },
                //   child: isGuestMode ? CircleAvatar(child: Icon(Icons.person, size: 35)) :
                //   profile.userInfoModel == null ? CircleAvatar(child: Icon(Icons.person, size: 35)) : ClipRRect(
                //     borderRadius: BorderRadius.circular(15),
                //     child: Image.asset(
                //       profile.userInfoModel.image,
                //       width: 35,
                //       height: 35,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
              ]);
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              // Top Row Items
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SquareButton(image: Images.shopping_image, title: "Commandes", navigateTo: OrderScreen()),
                SquareButton(image: Images.cart_image, title: "Panier", navigateTo: CartScreen()),
                //SquareButton(image: Images.offers, title: "Ma boutique", navigateTo: BoutiqueScreen()),
                SquareButton(image: Images.wishlist, title: "List de souhaits", navigateTo: WishListScreen()),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              // Buttons
              //TitleButton(image: Images.more_filled_image, title: getTranslated('all_category', context), navigateTo: AllCategoryScreen()),
              TitleButton(image: Images.notification_filled, title: "Notifications", navigateTo: NotificationScreen()),
              //TitleButton(image: Images.chats, title: getTranslated('chats', context), navigateTo: InboxScreen()),
              //TitleButton(image: Images.settings, title: getTranslated('settings', context), navigateTo: SettingsScreen()),
              //TitleButton(image: Images.preference, title: getTranslated('support_ticket', context), navigateTo: SupportTicketScreen()),
              TitleButton(image: Images.privacy_policy, title: "Termes et Conditions", navigateTo: WebViewScreen(
                title: "Termes et Conditions",
                url: 'https://www.google.com',
              )),
              // TitleButton(image: Images.help_center, title: getTranslated('faq', context), navigateTo: WebViewScreen(
              //   title: getTranslated('faq', context),
              //   url: 'https://www.google.com',
              // )),
              TitleButton(image: Images.about_us, title: "A propos de nous", navigateTo: WebViewScreen(
                title: "A propos de nous",
                url: 'https://www.google.com',
              )),
              TitleButton(image: Images.contact_us, title: "Contactez-nous", navigateTo: WebViewScreen(
                title: "Contactez-nous",
                url: 'https://www.google.com',
              )),

              ListTile(
                leading: Image.asset(Images.logo_image, width: 25, height: 25, fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
                title: Text("Informations", style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () => showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
              ),

              isGuestMode
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(Icons.exit_to_app, color: ColorResources.getPrimary(context), size: 25),
                      title: Text("Deconnexion", style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      onTap: () => showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true),
                    ),
            ]),
          ),
        ),
      ]),
    );
  }

}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  SquareButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Image.asset(image, color: Theme.of(context).accentColor),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
      title: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context,
          /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/
        MaterialPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}

