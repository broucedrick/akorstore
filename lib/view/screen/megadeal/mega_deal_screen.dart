import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/provider/mega_deal_provider.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/mega_deals_view.dart';
import 'package:provider/provider.dart';

class MegaDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        
        CustomAppBar(title: Strings.mega_deal),
        
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: TitleRow(title: Strings.mega_deal, eventDuration: Provider.of<MegaDealProvider>(context).duration),
        ),

        Expanded(child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: MegaDealsView(isHomeScreen: false),
        )),
        
      ]),
    );
  }
}
