import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/seller_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/amount_widget.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/my_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/widget/order_details_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/payment/payment_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/seller/seller_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/support/support_ticket_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/tracking/tracking_screen.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel order;
  final List<OrderDetailsModel> ord;
  OrderDetails({@required this.order, this.ord});

  @override
  Widget build(BuildContext context) {
    Provider.of<SellerProvider>(context, listen: false).removePrevOrderSeller();
    //debugPrint(order.id.toString());
    Provider.of<OrderProvider>(context, listen: false).getOrderDetails(order.id);
    Provider.of<ProfileProvider>(context, listen: false).initAddressList();
    //Provider.of<OrderProvider>(context, listen: false).initShippingList();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBar(title: 'Détail de la commande'),

          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, orderDetails, child) {
                List<String> sellerList = [];
                List<List<OrderDetailsModel>> sellerProductList = [];
                double _order = 0;
                //double _discount = 0;
                //double _tax = 0;
                //String shippingPartner = '';
                double _shippingFee = 0;
                String shippingAddress = '';

                if(this.ord != null) {
                  // ord.forEach((orderDetails) {
                  //   if(!sellerList.contains(orderDetails.productDetails.seller)) {
                  //     sellerList.add(orderDetails.productDetails.seller);
                  //   }
                  // });
                  // sellerList.forEach((seller) {
                  //   if(seller != '1') {
                  //     Provider.of<SellerProvider>(context, listen: false).initSeller(seller);
                  //   }
                  //   List<OrderDetailsModel> orderList = [];
                  //   ord.forEach((orderDetails) {
                  //     if(seller == orderDetails.productDetails.seller) {
                  //       orderList.add(orderDetails);
                  //     }
                  //   });
                  //   sellerProductList.add(orderList);
                  // });

                  // List<OrderDetailsModel> orderList = [];
                  // ord.forEach((orderDetails) {
                  //   //if(seller == orderDetails.productDetails.seller) {
                  //     orderList.add(orderDetails);
                  //   //}
                  // });
                  // sellerProductList.add(orderList);
                  debugPrint("OK");
                  ord.forEach((orderDetails) {
                    _order = _order + (double.parse(orderDetails.price) * double.parse(orderDetails.qty));
                    debugPrint(_order.toString());
                    //_discount = _discount + double.parse(orderDetails.discount);
                    //_tax = _tax + (double.parse('10') * double.parse(orderDetails.qty));
                  });

                  // if(orderDetails.shippingList != null) {
                  //   orderDetails.shippingList.forEach((shipping) {
                  //     if(shipping.id.toString() == orderDetails.orderDetails[0].shippingMethodId) {
                  //       shippingPartner = shipping.title;
                  //       _shippingFee = double.parse(shipping.cost);
                  //     }
                  //   });
                  // }
                }

                return ord != null ? ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: [

                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'ID Commande', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                            TextSpan(text: order.id.toString(), style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                      decoration: BoxDecoration(color: Theme.of(context).accentColor),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(child: Text('Livraison à', style: titilliumRegular)),
                            Consumer<ProfileProvider>(
                              builder: (context, profile, child) {
                                if(profile.addressList != null) {
                                  profile.addressList.forEach((address) {
                                    //if(address.id.toString() == order.shippingAddress) {
                                      shippingAddress = address.address ?? '';
                                    //}
                                  });
                                }
                                return Text(shippingAddress, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL));
                              },
                            ),
                          ]),
                          // Divider(),
                          // Row(children: [
                          //   Expanded(child: Text(getTranslated('SHIPPING_PARTNER', context), style: titilliumRegular)),
                          //   Text(shippingPartner, style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                          // ]),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    ListView.builder(
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE, vertical: Dimensions.MARGIN_SIZE_SMALL),
                          color: Theme.of(context).accentColor,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            // InkWell(
                            //   onTap: () {
                            //     if(Provider.of<SellerProvider>(context, listen: false).orderSellerList.length != 0 && sellerList[index] != '1') {
                            //       Navigator.push(context, MaterialPageRoute(builder: (_) {
                            //         return SellerScreen(seller: Provider.of<SellerProvider>(context, listen: false).orderSellerList[index]);
                            //       }));
                            //     }
                            //   },
                            //   child: Row(children: [
                            //     Expanded(child: Text(getTranslated('seller', context), style: robotoBold)),
                            //     Text(
                            //       sellerList[index] == '1' ? 'Admin'
                            //           : Provider.of<SellerProvider>(context).orderSellerList.length == 0 ? sellerList[index]
                            //           : '${Provider.of<SellerProvider>(context).orderSellerList[index].fName} ${Provider.of<SellerProvider>(context).orderSellerList[index].lName}',
                            //       style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                            //     ),
                            //     SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            //     Icon(Icons.chat, color: ColorResources.getColombiaBlue(context), size: 20),
                            //   ]),
                            // ),
                            Text('Article(s) commandé(s)', style: robotoBold.copyWith(color: ColorResources.getHint(context))),
                            Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              itemCount: ord.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) => OrderDetailsWidget(orderDetailsModel: ord[i]),
                            ),
                          ]),
                        );
                      },
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // Amounts
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).accentColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleRow(title: 'Total'),
                        AmountWidget(title: 'Commande', amount: _order.toString()),
                        // AmountWidget(title: getTranslated('SHIPPING_FEE', context), amount: PriceConverter.convertPrice(context, _shippingFee)),
                        // AmountWidget(title: getTranslated('DISCOUNT', context), amount: PriceConverter.convertPrice(context, _discount)),
                        // AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, double.parse(order.discountAmount))),
                        // AmountWidget(title: getTranslated('TAX', context), amount: PriceConverter.convertPrice(context, _tax)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Divider(height: 2, color: ColorResources.HINT_TEXT_COLOR),
                        ),
                        AmountWidget(title: 'Total à payer', amount: _order.toString()),
                      ]),
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // Payment
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(color: Theme.of(context).accentColor),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Paiement', style: robotoBold),
                        SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Statut du paiement', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                          Text(
                            ord != null ? ord[0].paymentStatus : '',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                        ]),
                        SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Moyen de paiement', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                          order.orderStatus == AppConstants.PENDING
                              ? InkWell(
                                onTap: () async {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                                  showAnimatedDialog(context, MyDialog(
                                    icon: Icons.done,
                                    title: 'Paiement effectué',
                                    description: 'Paiement effectué avec succès ',
                                  ), dismissible: false, isFlip: true);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                    color: ColorResources.getPrimary(context),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text('Payer maintenant', style: titilliumSemiBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: Theme.of(context).accentColor,
                                  )),
                                ),
                              )
                              : Text(order.paymentMethod.replaceAll('_', ' '), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
                        ]),
                      ]),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    // Buttons
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: CustomButton(
                    //           buttonText: getTranslated('TRACK_ORDER', context),
                    //           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingScreen())),
                    //         ),
                    //       ),
                    //       SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    //       Expanded(
                    //         child: SizedBox(
                    //           height: 45,
                    //           child: FlatButton(
                    //             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SupportTicketScreen())),
                    //             child: Text(getTranslated('SUPPORT_CENTER', context), style: titilliumSemiBold.copyWith(fontSize: 16, color: ColorResources.getPrimary(context))),
                    //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: ColorResources.getPrimary(context))),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ) : Center(child: CustomLoader(color: ColorResources.COLOR_PRIMARY));
              },
            ),
          )
        ],
      ),
    );
  }
}
