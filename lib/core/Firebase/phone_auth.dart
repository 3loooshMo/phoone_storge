import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class PhoneAuth extends GetxController{
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  PhoneAuth();
   Future<void> addPhone() async{

}
}