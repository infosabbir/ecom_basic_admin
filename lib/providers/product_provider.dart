import 'dart:io';

import 'package:ecom_basic_admin/db/db_helper.dart';
import 'package:ecom_basic_admin/models/category_model.dart';
import 'package:ecom_basic_admin/models/image_model.dart';
import 'package:ecom_basic_admin/models/product_model.dart';
import 'package:ecom_basic_admin/models/purchase_model.dart';
import 'package:ecom_basic_admin/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addCategory(String name) {
    final category = CategoryModel(categoryName: name);
    return DbHelper.addCategory(category);
  }

  getAllCategories() {
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<ImageModel> uploadImage(String imageLocalPath) async {
    final String imageName = 'image_${DateTime.now().microsecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child(
          '$imageDirectory$imageName}',
        );
    final uploadTask = photoRef.putFile(File(imageLocalPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return ImageModel(
      imageName: imageName,
      directoryName: imageDirectory,
      downloadUrl: url,
    );
  }

  Future<void> addProduct(ProductModel product, PurchaseModel purchase) {
    return DbHelper.addProduct(product, purchase);
  }
}
