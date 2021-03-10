import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/banner_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);

    return CustomExpandedAppBar(title: getTranslated('offers', context), child: Consumer<BannerProvider>(
      builder: (context, banner, child) {
        return banner.bannerList != null ? banner.bannerList.length != 0 ? ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: Provider.of<BannerProvider>(context).bannerList.length,
          itemBuilder: (context, index) {

            return InkWell(
              onTap: () => _launchUrl(banner.bannerList[index].url),
              child: Container(
                margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    banner.bannerList[index].photo,
                    fit: BoxFit.fill,
                    height: 150,
                  ),
                ),
              ),
            );
          },
        ) : Center(child: Text('No banner available')) : OfferShimmer();
      },
    ));
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class OfferShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<BannerProvider>(context).bannerList == null,
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorResources.WHITE),
          ),
        );
      },
    );
  }
}

