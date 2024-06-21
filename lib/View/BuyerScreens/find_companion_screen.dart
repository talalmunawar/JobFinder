import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/Controller/firestore_controller.dart';
import 'package:job_finder/View/SellerScreens/seller_home_screen.dart';
import 'package:job_finder/View/Utils/Styles/app_colors.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';
import 'package:job_finder/View/Utils/common_button2.dart';
import 'package:random_string/random_string.dart';

import '../Utils/common_field.dart';

class FindCompanionScreen extends StatefulWidget {
  const FindCompanionScreen({super.key});

  @override
  State<FindCompanionScreen> createState() => _FindCompanionScreenState();
}

class _FindCompanionScreenState extends State<FindCompanionScreen> {
  final skillController = TextEditingController();
  final descController = TextEditingController();
  final key = GlobalKey<FormState>();

  FirestoreController firestoreController = Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: AppText(
          title: 'Find',
          color: AppColors.whiteColor,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: 'Give Your Requirments',
                      size: 22,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    title: 'Skill',
                    size: 16,
                  ),
                ),
                CommonTextField(
                  controller: skillController,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Skill Field Cannot be Empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Need a Professional UI/UX Dev.',
                  obsecureText: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    title: 'Descriptions',
                    size: 16,
                  ),
                ),
                CommonTextField(
                  controller: descController,
                  validate: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Description Field could not be empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Description',
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
                    title: 'Post',
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
          ),
          onPressed: () {
            if (key.currentState!.validate()) {
              String id = randomAlphaNumeric(10);
              Map<String, dynamic> buyerDetails = {
                'skill': skillController.text.toString(),
                'description': descController.text.toString(),
                'created_at': Timestamp.now(),
              };

              firestoreController
                  .addData(buyerDetails, id, 'BuyerDetails')
                  .then((_) {
                Get.snackbar('Succes', 'Data inserted Successfully');
                Get.off(() => SellerHomeScreen());
              });
            }
          },
        ),
      ),
    );
  }
}
