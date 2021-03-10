import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';

class AmountWidget extends StatelessWidget {
  final String title;
  final String amount;

  AmountWidget({@required this.title, @required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('$title CFA', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
        Text('$amount CFA', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
      ]),
    );
  }
}
