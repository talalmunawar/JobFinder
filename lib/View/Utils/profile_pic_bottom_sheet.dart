import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder/Controller/firestore_controller.dart';
import 'package:job_finder/View/Utils/app_button/app_button.dart';
import 'package:job_finder/View/Utils/app_text/app_text.dart';
import 'package:random_string/random_string.dart';

import 'Styles/app_colors.dart';

class ProfilePicBottomSheet extends StatefulWidget {
  const ProfilePicBottomSheet({super.key});

  @override
  State<ProfilePicBottomSheet> createState() => _ProfilePicBottomSheetState();
}

class _ProfilePicBottomSheetState extends State<ProfilePicBottomSheet> {
  FirestoreController firestoreController = Get.put(FirestoreController());
  String imageUrlFireStore = '';
  File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title: 'Pick Profile Image',
                    size: 16,
                  ),
                  AppButton(
                    buttonWidth: 120,
                    buttonName: 'Pick Image',
                    textSize: 12,
                    onTap: () {
                      getImage();
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              AppButton(
                buttonName: 'Save Image',
                onTap: () async {
                  String UniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  // Creating instance of Firebase Cloud
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  // Creating here images folder inside the Firebase Cloud
                  Reference referenceDirImages =
                      referenceRoot.child('ProfileImages');

                  // Passing the name to the uploaded image
                  Reference referenceImageToUpload =
                      referenceDirImages.child(UniqueFileName);

                  try {
                    // Uploading the image to Firebase Cloud, with path
                    await referenceImageToUpload.putFile(File(image!.path));
                    imageUrlFireStore =
                        await referenceImageToUpload.getDownloadURL();
                  } catch (e) {
                    //  Handle Errors here..
                  }

                  String id = randomAlphaNumeric(7);
                  Map<String, dynamic> profileImagesData = {
                    'id': id,
                    'image': imageUrlFireStore,
                  };

                  await firestoreController
                      .addData(profileImagesData, id, 'ProfileImages')
                      .then((value) => {
                            Get.snackbar('Success', 'Image Added Successfully'),
                            Get.back(),
                          });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempImage = File(pickedFile.path);

      int fileSize = await tempImage.length();
      if (fileSize <= 2 * 1024 * 1024) {
        image = tempImage;
        debugPrint("Image path: ${image!.path}");
        setState(() {});
      } else {
        Get.snackbar(
          'Warning',
          'The selected image is too large. Please choose an image smaller than 2MB.',
        );
      }
    }
  }
}
