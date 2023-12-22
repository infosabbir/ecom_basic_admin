import 'dart:io';

import 'package:ecom_basic_admin/models/category_model.dart';
import 'package:ecom_basic_admin/providers/product_provider.dart';
import 'package:ecom_basic_admin/utils/helper_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/addproduct';

  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _discountController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryModel? categoryModel;
  String? imageLocalPath;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(
                children: [
                  imageLocalPath == null
                      ? const Icon(
                          Icons.photo,
                          size: 100,
                        )
                      : Image.file(
                          File(imageLocalPath!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Capture'),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo_album),
                        label: const Text('Gallery'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, child) =>
                  DropdownButtonFormField<CategoryModel>(
                items: provider.categoryList
                    .map(
                      (category) => DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.categoryName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  categoryModel = value;
                },
                hint: const Text('Select Category'),
                value: categoryModel,
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _selectDate,
                      child: const Text('Select Purchase Date'),
                    ),
                    Text(
                      dateTime == null
                          ? 'No Choosen date'
                          : getFormattedDate(dateTime!),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    if (file != null) {
      imageLocalPath = file.path;
    }
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        dateTime = date;
      });
    }
  }

  void _saveProduct() async {}

  @override
  void dispose() {
    _nameController.dispose();
    _shortDescriptionController.dispose();
    _longDescriptionController.dispose();
    _purchasePriceController.dispose();
    _quantityController.dispose();
    _discountController.dispose();
    _salePriceController.dispose();
    super.dispose();
  }

  void _resetFields() {
    setState(() {
      _nameController.clear();
      _shortDescriptionController.clear();
      _longDescriptionController.clear();
      _purchasePriceController.clear();
      _quantityController.clear();
      _discountController.clear();
      _salePriceController.clear();
    });
  }
}
