import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/widget/add_address_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AddressBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Close Button
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                    boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)]),
                child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
              ),
            ),
          ),

          Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return profile.addressList != null ? profile.addressList.length != 0 ?  SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: profile.addressList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorResources.getIconBg(context),
                          border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            profile.addressList[index].addressType == 'Home' ? Images.home_image
                                : profile.addressList[index].addressType == 'Ofice' ? Images.bag : Images.more_image,
                            color: ColorResources.getSellerTxt(context), height: 30, width: 30,
                          ),
                          title: Text(profile.addressList[index].address, style: titilliumRegular),
                        ),
                      ),
                    );
                  },
                ),
              )  : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                child: Text('No address available'),
              ) : Center(child: CircularProgressIndicator());
            },
          ),

          CustomButton(buttonText: getTranslated('add_new_address', context), onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddAddressBottomSheet(),
            );
          }),
        ]),
      ),
    );
  }
}
