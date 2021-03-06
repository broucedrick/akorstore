import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;


  addUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      isEmailVerified = true;

      if (_firstNameController.text.isEmpty) {
        showCustomSnackBar("Entrez votre nom", context);
      } else if (_emailController.text.isEmpty) {
        showCustomSnackBar("Entrez un email", context);
      } else if (_phoneController.text.isEmpty) {
        showCustomSnackBar("Entrez un num??ro de t??l??phone", context);
      } else if (_passwordController.text.isEmpty) {
        showCustomSnackBar("Entrez un mot de passe", context);
      } else if (_confirmPasswordController.text.isEmpty) {
        showCustomSnackBar("Confirmezvotre mot de passe", context);
      } else if (_passwordController.text != _confirmPasswordController.text) {
        showCustomSnackBar("Mot de passe non similaire", context);
      } else {
        register.fName = '${_firstNameController.text}';
        register.lName = _lastNameController.text ?? " ";
        register.email = _emailController.text;
        register.phone = _phoneController.text;
        register.password = _passwordController.text;
        await Provider.of<AuthProvider>(context, listen: false).registration(register).then((value){
          if(value){
            _emailController.clear();
            _passwordController.clear();
            _firstNameController.clear();
            _lastNameController.clear();
            _phoneController.clear();
            _confirmPasswordController.clear();

            //showCustomSnackBar("Incription effectu??e", context, isError: false);
            //showCustomSnackBar("Connectez-vous", context, isError: false);
          }else{
            //showCustomSnackBar("Veuillez r??essayer", context);
          }
        });
        //Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));


      }
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: "Pr??nom(s)",
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      controller: _firstNameController,
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: CustomTextField(
                      hintText: "Nom",
                      focusNode: _lNameFocus,
                      nextNode: _emailFocus,
                      controller: _lastNameController,
                    )),
                  ],
                ),
              ),

              // for email
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: "Email",
                  focusNode: _emailFocus,
                  nextNode: _phoneFocus,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              ),

              // for phone

              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: "Num??ro",
                  focusNode: _phoneFocus,
                  nextNode: _passwordFocus,
                  controller: _phoneController,
                  isPhoneNumber: true,
                ),
              ),

              // for password
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: "Mot de passe",
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // for re-enter password
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: "Mot de passe",
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),

        // for register button
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: CustomButton(onTap: addUser, buttonText: "Inscription"),
        ),

        // for skip for now
        Center(
                child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
                },
                child: Text("Continuer sans s'inscrire",
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getColombiaBlue(context))),
              )),
      ],
    );
  }
}
