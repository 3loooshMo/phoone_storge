import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/screens/Login/verification_screen.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_button.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_colors.dart';
import 'package:phone_store_app/view/screens/Login/widgets/font_styles.dart';
import 'package:phone_store_app/view/screens/Login/widgets/gradient_header.dart';
import 'package:phone_store_app/view/screens/Login/widgets/international_input_field.dart';
import 'package:phone_store_app/view/screens/cart_screen.dart';

class Login extends StatefulWidget {

   Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
   bool clicked = false;
   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildWidget(context),
        ],
      ),
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return const AppHeaderGradient(
      text: 'What Is Your Phone Number',
      isProfile: false,
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Please enter your phone number to verify your account',
            style: FontStyles.montserratRegular17(),
          ),
          _buildPhoneField(context),
          const SizedBox(
            height: 30.0,
          ),
          _buildSendButton(context),
          const SizedBox(
            height: 20.0,
          ),
          _buildSkipButton()
        ],
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      height: 64,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child:  PhoneInput(controller: controller),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return !clicked?
    AppButton.button(
        height: 64.0,
        width: double.infinity,
        color: AppColors.secondary,
        onTap: () async{
          setState(() {
            clicked = true;
          });

          print(controller.text);
          await auth.verifyPhoneNumber(
            phoneNumber: "+249${controller.text}",
            verificationCompleted: (PhoneAuthCredential credential) async {
              await auth.signInWithCredential(credential);
              setState(() {

              });
              clicked = false;
            },
            verificationFailed: (FirebaseAuthException e) {
              clicked = false;
              print(controller.text);
              if (e.code == 'invalid-phone-number') {
                print('The provided phone number is not valid.');
              }


            },
            codeSent: (String verificationId, int? resendToken) async {
              clicked = false;
              Get.off(()=>  Verification(verificationId: verificationId,));

            },
            timeout: const Duration(seconds: 60),
            codeAutoRetrievalTimeout: (String verificationId) {
              setState(() {
                clicked = false;
              });

            },
          );


         // Navigator.pushReplacementNamed(context, Verification.routeName);
        },
        text: 'Send Verification Code'):const CircularProgressIndicator();
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () {
        Get.off(()=>CartScreen());
      },
      child: Text(
        'Skip',
        style: FontStyles.montserratBold17().copyWith(color: Colors.grey),
      ),
    );
  }
}
