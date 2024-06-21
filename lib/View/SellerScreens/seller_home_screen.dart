import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/View/SellerScreens/seller_profile_screen.dart';
import 'package:job_finder/View/Utils/app_button/app_button.dart';

import '../Utils/Styles/app_colors.dart';
import '../Utils/app_text/app_text.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: AppText(
          title: 'Seller Home',
          color: AppColors.whiteColor,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SellerProfileScreen());
            },
            icon: Icon(
              Icons.person_2,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: AppText(
                title: 'Available Jobs',
                size: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('BuyerDetails')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.05),
                                  offset: Offset(0, -5),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            title: data['skill'],
                                            size: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 10),
                                          AppText(
                                            title: data['description'],
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: AppButton(
                                        buttonName: 'Connect',
                                        buttonWidth: 80,
                                        textSize: 12,
                                        onTap: () {},
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child:
                        CircularProgressIndicator(color: AppColors.themeColor),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
