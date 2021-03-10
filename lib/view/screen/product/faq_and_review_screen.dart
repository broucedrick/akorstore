import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/review_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/review_widget.dart';

class ReviewScreen extends StatelessWidget {
  final List<ReviewModel> reviewList;
  ReviewScreen({this.reviewList});

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        CustomAppBar(title: getTranslated('reviews', context)),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text(getTranslated('reviews', context)+'(${reviewList.length})', style: robotoBold),
        ),

        Expanded(child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: reviewList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              color: Theme.of(context).accentColor,
              child: ReviewWidget(reviewModel: reviewList[index]),
            );
          },
        )),

      ]),
    );
  }
}
