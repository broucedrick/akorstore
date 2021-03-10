import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/provider/order_provider.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ShippingMethodBottomSheet extends StatelessWidget {
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

          Consumer<OrderProvider>(
            builder: (context, order, child) {
              // return order.shippingList != null ? order.shippingList.length != 0 ?  SizedBox(
              //   height: 300,
              //   child: ListView.builder(
              //     itemCount: order.shippingList.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return RadioListTile(
              //         title: Text('${order.shippingList[index].title} (Duration: ${order.shippingList[index].duration}, Cost: ${
              //             PriceConverter.convertPrice(context, double.parse(order.shippingList[index].cost))})'),
              //         value: index,
              //         groupValue: order.shippingIndex,
              //         activeColor: Theme.of(context).primaryColor,
              //         toggleable: true,
              //         onChanged: (value) {
              //           Provider.of<OrderProvider>(context, listen: false).setSelectedShippingAddress(value);
              //           Navigator.pop(context);
              //         },
              //       );
              //     },
              //   ),
              // )  : Center(child: Text('No method available')) : Center(child: CircularProgressIndicator());
            },
          ),
        ]),
      ),
    );
  }
}
