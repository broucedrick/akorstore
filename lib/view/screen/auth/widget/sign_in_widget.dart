import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_loader.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/screen/auth/forget_password_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController _emailController;

  TextEditingController _passwordController;

  GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // _emailController.text = Provider.of<AuthProvider>(context, listen: false).getUserEmail() ?? null;
    // _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin.currentState.validate()) {
      _formKeyLogin.currentState.save();

      if (_emailController.text.isEmpty) {
        showCustomSnackBar("Votre identifiant est obligatoire", context);
      } else if (_passwordController.text.isEmpty) {
        showCustomSnackBar("Votre mot de passe est obligatoire", context);
      } else {

        // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_emailController.text, _passwordController.text);
        // } else {
        //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        // }

        loginBody.email = _emailController.text;
        loginBody.password = _passwordController.text;
        await Provider.of<AuthProvider>(context, listen: false).login(loginBody).then((value){
          if(value){
            showCustomSnackBar("Connexion effectut??e", context, isError: false);
            debugPrint("UserID: ${Provider.of<AuthProvider>(context, listen: false).getUserToken()}");
            Provider.of<ProfileProvider>(context, listen: false).getUserInfo(Provider.of<AuthProvider>(context, listen: false).getUserToken());
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));
          }else{
            //showCustomSnackBar("Identifiant ou mot de passe incorrecte", context);
          }
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    //_emailController.text = 'Johndoe@gmail.com';
    //_passwordController.text = '123456';

    return Form(
      key: _formKeyLogin,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        children: [
          // for Email
          Container(
              margin:
                  EdgeInsets.only(left: Dimensions.MARGIN_SIZE_LARGE, right: Dimensions.MARGIN_SIZE_LARGE, bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: CustomTextField(
                hintText: "Identifiant",
                focusNode: _emailNode,
                nextNode: _passNode,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              )),

          // for Password
          Container(
              margin:
                  EdgeInsets.only(left: Dimensions.MARGIN_SIZE_LARGE, right: Dimensions.MARGIN_SIZE_LARGE, bottom: Dimensions.MARGIN_SIZE_DEFAULT),
              child: CustomPasswordTextField(
                hintTxt: "Mot de passe",
                textInputAction: TextInputAction.done,
                focusNode: _passNode,
                controller: _passwordController,
              )),

          // for remember and forgetpassword
          Container(
            margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL, right: Dimensions.MARGIN_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Checkbox(
                        checkColor: ColorResources.WHITE,
                        activeColor: ColorResources.COLOR_PRIMARY,
                        value: authProvider.isRemember,
                        onChanged: authProvider.updateRemember,
                      ),
                    ),
                    //

                    Text("Se souvenir", style: titilliumRegular),
                  ],
                ),
                // InkWell(
                //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPasswordScreen())),
                //   child: Text("Mot de passe oubli??", style: titilliumRegular.copyWith(color: ColorResources.getLightSkyBlue(context))),
                // ),
              ],
            ),
          ),

          // for signin button
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
            child: CustomButton(onTap: loginUser, buttonText: "Connexion"),
          ),

          SizedBox(height: 20),
          Center(child: Text("Ou", style: titilliumRegular.copyWith(fontSize: 12))),

          //for order as guest
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 30),
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ColorResources.getHint(context), width: 1.0),
              ),
              child: Text("Continuer sans se connecter", style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
            ),
          ),
        ],
      ),
    );
  }
}
