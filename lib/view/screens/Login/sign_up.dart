
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_button.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_colors.dart';
import 'package:phone_store_app/view/screens/Login/widgets/app_text_field.dart';
import 'package:phone_store_app/view/screens/Login/widgets/font_styles.dart';
import 'package:phone_store_app/view/screens/Login/widgets/gradient_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/Firebase/firebase_db.dart';
import '../../widgets/bottom_app_bar.dart';
import '../cart_screen.dart';
class SignUp extends StatelessWidget {
  static const String routeName = 'signup';

  SignUp({Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppHeaderGradient(
      fixedHeight: MediaQuery.of(context).size.height * .25,
      isProfile: false,
      text: 'Profile Info',
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        child: Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showModalSheet(context);
            },
            child: const CircleAvatar(
              radius: 50.0,
              backgroundColor: AppColors.lightGray,
            ),
          ),
          const Text('Upload photo'),
          const SizedBox(height: 20.0),
          AppTextField(

            hintText: 'Your name',
            labelText: 'Name',
            onTap: () {}, controller: name,
          ),
          const SizedBox(height: 20.0),
          AppTextField(
            hintText: 'Email address',
            labelText: 'Email',
            onTap: () {}, controller: email,
          ),
          const SizedBox(height: 20.0),
          AppTextField(
            hintText: 'You address',
            labelText: 'Address',
            onTap: () {}, controller: address,
          ),
          const SizedBox(height: 20.0),
          AppButton.button(
              text: 'Save',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .08,
              color: AppColors.secondary,
              onTap: () {
                if(name.text.isNotEmpty&&address.text.isNotEmpty&&email.text.isNotEmpty) {
                  FirebaseDb.addUsersData(name.text, email.text, address.text);
                }else{
                  Get.snackbar("Error", "Not Empty");
                }
              }),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              Get.off(()=>CartScreen());
            },
            child: Text(
              'Skip',
              style: FontStyles.montserratBold17().copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    ));
  }
  showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings_rounded),
                  title: const Text('From gallery'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('From Camera'),
                ),
              )
            ],
          );
        });
  }

}
