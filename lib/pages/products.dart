import 'package:flutter/material.dart';

//import 'package:scoped_model/scoped_model.dart';
//
//import '../widgets/products/products.dart';
//import '../widgets/ui_elements/logout_list_tile.dart';
import '../scoped-models/main.dart';
import './camera_page.dart';
import './home_page.dart';
import './message_page.dart';

class ProductsPage extends StatefulWidget {
  var cameras;
  final MainModel model;

  ProductsPage(this.model, this.cameras);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 3);
  }

//  Widget _buildSideDrawer(BuildContext context) {
//    return Drawer(
//      child: Column(
//        children: <Widget>[
//          AppBar(
//            automaticallyImplyLeading: false,
//            title: Text('Choose'),
//          ),
//          ListTile(
//            leading: Icon(Icons.edit),
//            title: Text('Manage Products'),
//            onTap: () {
//              Navigator.pushReplacementNamed(context, '/admin');
//            },
//          ),
//          Divider(),
//          LogoutListTile()
//        ],
//      ),
//    );
//  }

//  Widget _buildProductsList() {
//    return ScopedModelDescendant(
//      builder: (BuildContext context, Widget child, MainModel model) {
//        Widget content = Center(child: Text('No Products Found!'));
//        if (model.displayedProducts.length > 0 && !model.isLoading) {
//          content = Products();
//        } else if (model.isLoading) {
//          content = Center(child: CircularProgressIndicator());
//        }
//        return RefreshIndicator(onRefresh: model.fetchProducts, child: content,) ;
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CameraPage(widget.cameras),
            HomePage(widget.model, widget.cameras),
            MessagePage(),
          ],
      ),
    );
  }





//  Scaffold(
//  //drawer: _buildSideDrawer(context),
//  appBar: AppBar(
//  automaticallyImplyLeading: false,
//  backgroundColor: Colors.white,
//  title: Row(
//  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//  children: [
//  IconButton(icon: Image.asset('./assets/01.png'),onPressed: (){},),
//  Text(
//  'Imstagran',
//  textAlign: TextAlign.center,
//  style: TextStyle(color: Colors.black),
//  ),
//  IconButton(icon: Image.asset('./assets/02.png'),onPressed: (){},),
//  ],
//  ),
//  ),
//  body: _buildProductsList(),
//  bottomNavigationBar: BottomAppBar(
//  color: Colors.white,
//  child:
//  Row(
//  mainAxisAlignment: MainAxisAlignment.spaceAround,
//  children: <Widget>[
//  IconButton(icon: Image.asset('./assets/03.png'), onPressed: (){},),
//  IconButton(icon: Image.asset('./assets/07.png'), onPressed: (){},),
//  IconButton(icon: Image.asset('./assets/04.png'), onPressed: (){ Navigator.pushReplacementNamed(context, '/admin'); },),
//  IconButton(icon: Image.asset('./assets/08.png'), onPressed: (){},),
//  IconButton(icon: Image.asset('./assets/05.png'), onPressed: (){  },),
//  ],
//  ),
//  ),
//  );










//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      drawer: _buildSideDrawer(context),
//      appBar: AppBar(
//        title: Text('EasyList'),
//        actions: <Widget>[
//          ScopedModelDescendant<MainModel>(
//            builder: (BuildContext context, Widget child, MainModel model) {
//              return IconButton(
//                icon: Icon(model.displayFavoritesOnly
//                    ? Icons.favorite
//                    : Icons.favorite_border),
//                onPressed: () {
//                  model.toggleDisplayMode();
//                },
//              );
//            },
//          )
//        ],
//      ),
//      body: _buildProductsList(),
//    );
//  }
}
