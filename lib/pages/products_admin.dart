import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../widgets/ui_elements/logout_list_tile.dart';
import '../scoped-models/main.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        drawer: _buildSideDrawer(context),
//        appBar: AppBar(
//          automaticallyImplyLeading: false,
//          backgroundColor: Colors.white,
//          title: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              IconButton(icon: Image.asset('./assets/09.png'), onPressed: (){ Navigator.pushReplacementNamed(context, '/'); },),
//              Text('New Post', style: TextStyle(color: Colors.black),),
//              IconButton(icon: Image.asset('./assets/10.png'), onPressed: (){},)
//            ],
//          ),
//        ),
        body: ProductEditPage(),
    );
  }

}
















//@override
//Widget build(BuildContext context) {
//  return DefaultTabController(
//    length: 2,
//    child: Scaffold(
//      drawer: _buildSideDrawer(context),
//      appBar: AppBar(
//        title: Text('Manage Products'),
//        bottom: TabBar(
//          tabs: <Widget>[
//            Tab(
//              icon: Icon(Icons.create),
//              text: 'Create Product',
//            ),
//            Tab(
//              icon: Icon(Icons.list),
//              text: 'My Products',
//            ),
//          ],
//        ),
//      ),
//      body: TabBarView(
//        children: <Widget>[ProductEditPage(), ProductListPage(model)],
//      ),
//    ),
//  );
//}