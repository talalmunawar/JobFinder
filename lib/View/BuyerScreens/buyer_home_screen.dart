import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/View/BuyerScreens/buyer_profile_screen.dart';
import 'package:job_finder/View/BuyerScreens/find_companion_screen.dart';
import 'package:job_finder/View/Utils/Styles/app_colors.dart';
import 'package:job_finder/View/Utils/app_button/app_button.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: AppText(
          title: 'Buyer Home',
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
                Get.to(() => BuyerProfileScreen());
              },
              icon: Icon(
                Icons.person_2_rounded,
                color: AppColors.whiteColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            AppText(
              title: 'Find Your Companion',
              size: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 40),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('SellerProfileData')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        Timestamp timestamp = data['created_at'];
                        DateTime dateTime = timestamp.toDate();
                        // Format the DateTime object to a readable string
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(dateTime);
                        String formattedTime =
                            DateFormat('kk:mm').format(dateTime);
                        return Container(
                          padding: EdgeInsets.all(12),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: data['skill'],
                                      size: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 10),
                                    AppButton(
                                      buttonRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      buttonName: 'Contact Us',
                                      onTap: () {},
                                      buttonWidth: 120,
                                      textSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: formattedDate,
                                      size: 10,
                                    ),
                                    AppText(
                                      title: formattedTime,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // child: Center(
                          //   child: ListTile(
                          //     contentPadding: EdgeInsets.symmetric(
                          //         horizontal: 12, vertical: 20),
                          //     title: AppText(title: data['skill']),
                          //     subtitle: AppButton(
                          //       buttonWidth: 30,
                          //       buttonName: 'Contact Us',
                          //       onTap: () {},
                          //     ),
                          //     // subtitle: Padding(
                          //     //   padding: const EdgeInsets.only(top: 8.0),
                          //     //   child: GestureDetector(
                          //     //     onTap: () {},
                          //     //     child: Container(
                          //     //       height: 40,
                          //     //       width: 110,
                          //     //       decoration: BoxDecoration(
                          //     //         color: AppColors.themeColor,
                          //     //         borderRadius: BorderRadius.circular(22),
                          //     //       ),
                          //     //       child: Center(
                          //     //         child: AppText(
                          //     //           title: 'Contact Us',
                          //     //           size: 14,
                          //     //           color: AppColors.whiteColor,
                          //     //         ),
                          //     //       ),
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //     trailing: Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         AppText(
                          //           title: formattedTime,
                          //           color: AppColors.greyColor,
                          //           size: 9,
                          //         ),
                          //         AppText(
                          //           title: formattedDate,
                          //           color: AppColors.greyColor,
                          //           size: 9,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // child:
                          // Center(
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       AppText(
                          //         title: data['skill'],
                          //         size: 16,
                          //       ),
                          //       AppText(
                          //         title: '+${data['contact']}',
                          //         size: 14,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
          Get.to(() => FindCompanionScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppText(
              title: 'Find According to your requirement',
              color: AppColors.whiteColor,
            ),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
