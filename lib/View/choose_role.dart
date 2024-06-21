import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/View/BuyerScreens/buyer_home_screen.dart';
import 'package:job_finder/View/SellerScreens/seller_home_screen.dart';
import 'package:job_finder/View/Utils/app_button/app_button.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';

import 'Utils/Styles/app_colors.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: AppText(
          title: 'Choose Your Role',
          color: AppColors.whiteColor,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                  buttonName: 'Buyer',
                  onTap: () {
                    Get.to(() => BuyerHomeScreen());
                  }),
              SizedBox(height: 20),
              AppButton(
                  buttonName: 'Seller',
                  onTap: () {
                    Get.to(() => SellerHomeScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
