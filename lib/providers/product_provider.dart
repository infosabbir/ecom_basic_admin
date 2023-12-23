import 'dart:io';

import 'package:ecom_basic_admin/db/db_helper.dart';
import 'package:ecom_basic_admin/models/category_model.dart';
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

  Future<String>  uploadImage(String imageLocalPath) async {
    final photoRef = FirebaseStorage.instance.ref().child(
          'ProductImages/${DateTime.now().microsecondsSinceEpoch}',
        );
    final uploadTask = photoRef.putFile(File(imageLocalPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}
