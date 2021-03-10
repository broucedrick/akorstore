import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class NotLoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_LARGE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.login, height: MediaQuery.of(context).size.width*0.4, width: MediaQuery.of(context).size.width),
            SizedBox(height: 50),
            Text(getTranslated('PLEASE_LOGIN_FIRST', context), textAlign: TextAlign.center, style: titilliumSemiBold),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                buttonText: getTranslated('LOGIN', context),
                onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false),
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).updateSelectedIndex(1);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen(initialPage: 1)), (route) => false);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: 30),
                child: Text(getTranslated('create_new_account', context), style: titilliumRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                )),
              ),
            ),
          ],
        ));
  }
}
