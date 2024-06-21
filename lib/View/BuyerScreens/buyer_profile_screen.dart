import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/Controller/firebase_auth_controller.dart';
import 'package:job_finder/View/SellerScreens/add_seller_details.dart';
import 'package:job_finder/View/Utils/Styles/app_colors.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';
import 'package:job_finder/View/Utils/common_button2.dart';

import '../Utils/profile_pic_bottom_sheet.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  FirebaseController firebaseController = Get.put(FirebaseController());
  User? currentUser;
  String? userName;
  checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
        if (currentUser != null) {
          FirebaseFirestore.instance
              .collection('auth')
              .doc(currentUser!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                userName = documentSnapshot['name'];
              });
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: AppText(
          title: 'Profile Screen',
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            // child: Icon(
                            //   Icons.person_2_rounded,
                            //   color: AppColors.themeColor,
                            //   size: 30,
                            // ),
                            backgroundImage:
                                AssetImage('assets/images/img.jpg'),
                          ),
                          SizedBox(height: 12),
                          AppText(
                            title: '${userName}',
                            color: AppColors.whiteColor,
                          ),
                          AppText(
                            title: currentUser != null
                                ? "${currentUser!.email}"
                                : 'example@gmail.com',
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          Get.bottomSheet(ProfilePicBottomSheet());
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('SellerProfileData')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 120),
                            AppText(title: 'No Data Added yet'),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.themeColor,
                              ),
                              onPressed: () {
                                Get.to(() => AddSellerDetails());
                              },
                              child: AppText(
                                title: 'Add Data',
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return Column(
                          children: List.generate(
                            snapshot.data!.docs.length,
                            (index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];

                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
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
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  title: "Skill",
                                                  size: 16,
                                                ),
                                                AppText(
                                                  title: data['skill'],
                                                  size: 13,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  title: "Contact No: ",
                                                  size: 16,
                                                ),
                                                AppText(
                                                  title: '+${data['contact']}',
                                                  size: 13,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            AppText(
                                              title: 'Description:',
                                              size: 16,
                                            ),
                                            SizedBox(height: 10),
                                            AppText(
                                              title: data['description'],
                                              color: AppColors.greyColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 120),
                              AppText(title: 'No Data Added yet'),
                              SizedBox(height: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.themeColor,
                                ),
                                onPressed: () {
                                  Get.to(() => AddSellerDetails());
                                },
                                child: AppText(
                                  title: 'Add Data',
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 120),
                            AppText(title: 'No Data Added yet'),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.themeColor,
                              ),
                              onPressed: () {
                                Get.to(() => AddSellerDetails());
                              },
                              child: AppText(
                                title: 'Add Data',
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton2(
          child: AppText(
            title: 'Logout',
            size: 16,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          onPressed: () {
            firebaseController.logOut();
          },
        ),
      ),
    );
  }
}
