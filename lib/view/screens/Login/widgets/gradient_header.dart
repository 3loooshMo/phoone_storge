import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_styles.dart';


class AppHeaderGradient extends StatelessWidget {
  const AppHeaderGradient(
      {this.text, this.isProfile, this.fixedHeight, Key? key})
      : super(key: key);
  final String? text;
  final bool? isProfile;
  final double? fixedHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: fixedHeight ?? 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient:  const LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primaryDark],
              stops: [0, 1],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft),
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.only(
            bottomRight: isProfile!
                ? const Radius.circular(150.0)
                : const Radius.circular(250.0),
          ),
        ),
        child: isProfile!
            ? _buildProfileInfo(context)
            : Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 34),
                  child: Text(
                    text!,
                    style: FontStyles.montserratBold25()
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ));
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 40.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/product/profile.png'),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oleh Chabanov',
                style: FontStyles.montserratBold19()
                    .copyWith(color: AppColors.white),
              ),
              Text(
                '+38 (099) 123 45 67',
                style: FontStyles.montserratRegular14()
                    .copyWith(color: AppColors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
