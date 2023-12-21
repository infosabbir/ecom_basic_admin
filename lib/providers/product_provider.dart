import 'package:ecom_basic_admin/db/db_helper.dart';
import 'package:ecom_basic_admin/models/category_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addCategory(String name) {
    final category = CategoryModel(categoryName: name);
    return DbHelper.addCategory(category);
  }
}
