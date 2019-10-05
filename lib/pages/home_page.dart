import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/logout_list_tile.dart';
import '../widgets/products/products.dart';
import '../scoped-models/main.dart';
import './message_page.dart';
import './camera_page.dart';

class HomePage extends StatelessWidget {
  var cameras;

  final MainModel model;
  HomePage(this.model, this.cameras);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Products Found!'));
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: model.fetchProducts,
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: _buildSideDrawer(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 40,
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: true,
                    transitionDuration: const Duration(milliseconds: 150),
                    pageBuilder: (BuildContext context, _, __) {
                      return new CameraPage(cameras);
                    },
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return new SlideTransition(
                        child: child,
                        position: new Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                      );
                    }));
              },
            ),
            Text(
              'Imstagran',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
                icon: Icon(Icons.send),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(new PageRouteBuilder(
                      opaque: true,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext context, _, __) {
                        return new MessagePage();
                      },
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new SlideTransition(
                          child: child,
                          position: new Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                        );
                      }));
                }),
          ],
        ),
      ),
      body: _buildProductsList(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 40,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/explore');
              },
            ),
            IconButton(
              icon: Image.asset('./assets/17.png'),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              iconSize: 40,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person_outline),
              iconSize: 40,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/personal');
              },
            ),
          ],
        ),
      ),
    );
  }
}
