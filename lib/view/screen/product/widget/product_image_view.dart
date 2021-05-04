import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider_test.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/screen/product/product_image_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';

class ProductImageView extends StatelessWidget {
  final Product productModel;
  ProductImageView({@required this.productModel});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductImageScreen(imageList: productModel.photo, title: productModel.nom))),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.grey[300], spreadRadius: 1, blurRadius: 5)],
              gradient: Provider.of<ThemeProvider>(context).darkTheme ? null : LinearGradient(
                colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.width - 100,
                child: Container(
                  //padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Hero(
                    tag: 'image-${productModel.id}',
                    child: Image.network(
                      "https://www.akorstore.com/storage/images/${productModel.photo}",
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: 0, right: 0, bottom: 0,
              //   child: Padding(
              //     padding: EdgeInsets.only(bottom: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: _indicators(context),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FavouriteButton(
                  backgroundColor: ColorResources.getImageBg(context),
                  favColor: ColorResources.getPrimary(context),
                  isSelected: Provider.of<WishListProvider>(context,listen: false).isWish,
                  product: productModel,
                ),
              ),

            ]),
          ),
        ),

        // Image List
        // Container(
        //   height: 60,
        //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //   alignment: Alignment.center,
        //   child: ListView.builder(
        //     itemCount: productModel.images.length,
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //         onTap: () {
        //           _controller.animateToPage(index, duration: Duration(microseconds: 300), curve: Curves.easeInOut);
        //         },
        //         child: Container(
        //           width: 60,
        //           margin: EdgeInsets.symmetric(horizontal: 5),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             color: Theme.of(context).accentColor,
        //             border: Provider.of<ProductDetailsProvider>(context).imageSliderIndex == index
        //                 ? Border.all(color: ColorResources.COLOR_PRIMARY, width: 2) : null,
        //           ),
        //           child: Padding(
        //             padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //             child: Image.asset(
        //               productModel.images[index],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  // List<Widget> _indicators(BuildContext context) {
  //   List<Widget> indicators = [];
  //   for (int index = 0; index < productModel.images.length; index++) {
  //     indicators.add(TabPageSelectorIndicator(
  //       backgroundColor: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ? ColorResources.COLOR_PRIMARY : ColorResources.WHITE,
  //       borderColor: ColorResources.WHITE,
  //       size: 10,
  //     ));
  //   }
  //   return indicators;
  // }

}
