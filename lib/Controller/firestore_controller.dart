import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  RxBool loader = false.obs;
  Future addData(
      Map<String, dynamic> data, String id, String collectionName) async {
    try {
      loader.value = true;
      update();
      return await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .set(data)
          .then((value) {
        loader.value = false;
        update();
      });
    } catch (e) {
      loader.value = false;
      update();
      print(e.toString());
    }
  }

  Future<Stream<QuerySnapshot>> getData(String collectionName) async {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }

  Future UpdateItem(String id, Map<String, dynamic> itemDetails) async {
    final docRef = FirebaseFirestore.instance.collection('items').doc(id);
    final doc = await docRef.get();

    if (doc.exists) {
      return await docRef.update(itemDetails);
    } else {
      print('Document does not exist');
    }
  }

  Future deleteData(String id, String collectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete()
        .then((value) {
      Get.snackbar('Success', 'Data Deleted Successfully');
    }).onError((error, stackTrace) {
      Get.snackbar('Success', 'Error While Deleting the item');
      print(error);
    });
  }

  // Here are the Auth Services below
}
