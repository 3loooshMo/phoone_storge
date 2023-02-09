import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:phone_store_app/view/screens/Login/phone_screen.dart';
import 'package:phone_store_app/view/screens/Login/sign_up.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_button.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_colors.dart';
import 'package:phone_store_app/view/screens/Login/widgets/font_styles.dart';
import 'package:phone_store_app/view/screens/Login/widgets/gradient_header.dart';


class Verification extends StatefulWidget {
   Verification({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? smsVerification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildWidget(context),
          const SizedBox(height: 30.0),
          _buildContinueButton(context),
          const SizedBox(height: 30.0),
          _buildResendCodeButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const AppHeaderGradient(
      text: 'Verification Code',
      isProfile: false,
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please enter code send to',
            style: FontStyles.montserratRegular17(),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '+9234404234242',
                style: FontStyles.montserratBold17(),
              ),
              GestureDetector(
                onTap: () {
                 // Navigator.pushReplacementNamed(context, Login.routeName);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Login()));
                },
                child: Text(
                  'Change phone number',
                  style: FontStyles.montserratRegular12()
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          _buildOTPField(context),
        ],
      ),
    );
  }

  Widget _buildOTPField(BuildContext context) {
    return OTPTextField(
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      otpFieldStyle: OtpFieldStyle(focusBorderColor: Colors.green),
      width: MediaQuery.of(context).size.width,
      keyboardType: TextInputType.number,
      length: 6,
      style: FontStyles.montserratBold25(),
      onChanged: (value){
        setState(() {
          smsVerification = value;
        });
      },
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: AppButton.button(
          width: 327,
          height: 64,
          color: AppColors.secondary,
          text: 'Continue',
          onTap: () async{
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: smsVerification!);
              await auth.signInWithCredential(credential);

              Get.offAll(() =>  SignUp());
            }catch(e){
              print(e.toString());
            }
           // Navigator.pushReplacementNamed(context, SignUp.routeName);
          }),
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {},
          child: Text(
            'Resend Code',
            style: FontStyles.montserratBold17().copyWith(color: Colors.grey),
          )),
    );
  }
}
