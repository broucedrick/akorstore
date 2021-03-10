import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_modal_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/widget/select_address_bottomsheet.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatelessWidget {
  final UserInfoModel userInfoModel;
  AddressListScreen(this.userInfoModel);

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    feedbackMessage(String message){
      showCustomSnackBar(message, context);
    }

    return Scaffold(
      body: Column(
        children: [

          CustomAppBar(title: getTranslated('ADDRESS_LIST', context)),

          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return profileProvider.addressList != null ? profileProvider.addressList.length > 0 ? Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  itemCount: profileProvider.addressList.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        addressBottomSheet(profileProvider.addressList[index], context, feedbackMessage);
                      },
                      title: Text('Address: ${profileProvider.addressList[index].address}' ?? ""),
                      subtitle: Text('City: ${profileProvider.addressList[index].city ?? ""}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever, color: Colors.red),
                        onPressed: () {
                          showCustomModalDialog(
                            context,
                            title: getTranslated('REMOVE_ADDRESS', context),
                            content: profileProvider.addressList[index].address,
                            cancelButtonText: getTranslated('CANCEL', context),
                            submitButtonText: getTranslated('REMOVE', context),
                            submitOnPressed: () {
                              Provider.of<ProfileProvider>(context, listen: false).removeAddressById(profileProvider.addressList[index].id, index);
                              Navigator.of(context).pop();
                            },
                            cancelOnPressed: () => Navigator.of(context).pop(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ) : Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
                  : Expanded(child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))));
            },
          ),
        ],
      ),
    );
  }


}
