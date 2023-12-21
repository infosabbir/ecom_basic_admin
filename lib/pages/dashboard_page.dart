import 'package:ecom_basic_admin/auth/auth_service.dart';
import 'package:ecom_basic_admin/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/dashboard_item_view.dart';
import '../models/dashboard_model.dart';
import 'add_product_page.dart';
import 'category_page.dart';
import 'dashboard_home.dart';
import 'launcher_page.dart';
import 'order_page.dart';
import 'report_page.dart';
import 'settings_page.dart';
import 'user_list_page.dart';
import 'view_product_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final _pages = <Widget>[
    DashboardHome(),
    AddProductPage(),
    ViewProductPage(),
    CategoryPage(),
    OrderPage(),
    UserListPage(),
    SettingsPage(),
    ReportPage(),
  ];

  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logOut().then(
                (value) => Navigator.pushReplacementNamed(
                    context, LauncherPage.routeName),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          return DashboardItemView(
            model: dashboardModelList[index],
          );
        },
      ),
    );
  }
}
