import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/Controller/firestore_controller.dart';
import 'package:job_finder/View/SellerScreens/seller_profile_screen.dart';
import 'package:job_finder/View/Utils/Styles/app_colors.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';
import 'package:job_finder/View/Utils/common_button2.dart';
import 'package:job_finder/View/Utils/common_field.dart';
import 'package:random_string/random_string.dart';

class AddSellerDetails extends StatefulWidget {
  const AddSellerDetails({super.key});

  @override
  State<AddSellerDetails> createState() => _AddSellerDetailsState();
}

class _AddSellerDetailsState extends State<AddSellerDetails> {
  final contactController = TextEditingController();
  final skillController = TextEditingController();
  final descController = TextEditingController();
  FirestoreController firestoreController = Get.put(FirestoreController());
  String currentUserID = '';
  String currentUserEmail = '';

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
    currentUserID = currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title: 'More Profile Data ',
                  size: 24,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  title: 'Seller Details',
                  size: 14,
                  color: AppColors.greyColor,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    title: 'Contact No.',
                    size: 16,
                  ),
                ),
                CommonTextField(
                  controller: contactController,
                  validate: (val) {
                    if (val == null) {
                      return 'Contact Field Cannot be Empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: '+92 123456789',
                  obsecureText: false,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    title: 'Skills',
                    size: 16,
                  ),
                ),
                CommonTextField(
                  controller: skillController,
                  validate: (val) {
                    if (val == null) {
                      return 'Skills Field Cannot be Empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'UI/UX, Web Dev.',
                  obsecureText: false,
                ),
                SizedBox(height: 20),
                CommonTextField(
                  controller: descController,
                  validate: (val) {
                    if (val == null) {
                      return 'Description could not be empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Description....',
                  maxLines: 4,
                  obsecureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton2(
          child: Obx(
            () => firestoreController.loader.value
                ? CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : AppText(
                    title: 'Add Data',
                    color: AppColors.whiteColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
          ),
          onPressed: () {
            String id = randomAlphaNumeric(10);
            Map<String, dynamic> sellerData = {
              'user_id': currentUserID,
              'userName': userName,
              'email': currentUserEmail,
              'created_at': Timestamp.now(),
              'id': id,
              'contact': contactController.text.toString(),
              'skill': skillController.text.toString(),
              'description': descController.text.toString(),
            };

            firestoreController
                .addData(
              sellerData,
              id,
              'SellerProfileData',
            )
                .then((_) {
              Get.snackbar('Success', 'Seller Data is inserted');
              Get.off(
                () => SellerProfileScreen(),
              );
            });
          },
        ),
      ),
    );
  }
}
