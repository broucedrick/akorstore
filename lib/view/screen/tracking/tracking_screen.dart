import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/tracking/tracking_result_screen.dart';

class TrackingScreen extends StatelessWidget {
  final TextEditingController _orderIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    _orderIdController.text = '1';

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('TRACKING', context)),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Image.asset(
                        'assets/images/onboarding_image_one.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                      ),
                      SizedBox(height: 50),

                      Text(getTranslated('TRACK_ORDER', context), style: robotoBold),
                      Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 1,
                          margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                          color: ColorResources.colorMap[50],
                        ),
                        Container(
                          width: 70,
                          height: 1,
                          margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                          decoration: BoxDecoration(color: ColorResources.getPrimary(context), borderRadius: BorderRadius.circular(1)),
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      CustomTextField(
                        hintText: getTranslated('TRACK_ID', context),
                        textInputType: TextInputType.number,
                        controller: _orderIdController,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      Builder(
                        builder: (context) => CustomButton(
                          buttonText: getTranslated('TRACK', context),
                          onTap: () {
                            if(_orderIdController.text.isNotEmpty){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(orderID: _orderIdController.text)));
                            }else {
                              showCustomSnackBar('Insert track ID', context);
                            }
                          },
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
}
