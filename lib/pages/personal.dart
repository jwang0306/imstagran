import 'package:flutter/material.dart';

import '../widgets/ui_elements/logout_list_tile.dart';

import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class PersonalPage extends StatefulWidget {
  final MainModel model;

  PersonalPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _PersonalPage();
  }
}

class _PersonalPage extends State<PersonalPage>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
    widget.model.fetchProducts(onlyForUser: true);
    super.initState();
  }

  Widget _buildProductsList(BuildContext context, model) {
    Widget content = Center(child: Text('No Products Found!'));
    if (model.displayedProducts.length > 0 && !model.isLoading) {
      content = Products();
    } else if (model.isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    return content;
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              '',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  Widget _buildPersonalIntroduction(BuildContext context, String userEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          userEmail,
          style: TextStyle(
              fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Text(
          'Bios.',
          style: TextStyle(fontSize: 15, color: Colors.black),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildPersonalPhoto() {
    return Stack(
      children: <Widget>[
        //photo
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 100,
          margin: EdgeInsets.fromLTRB(10, 18, 18, 18),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('./assets/15.png'),
            ),
          ),
        ),
        //blue plus icon
        Positioned(
          right: 10.0,
          top: 90,
          child: new Icon(
            Icons.add_circle,
            size: 32.0,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildFanDetail() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('0',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      'Post',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('0',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      'Followers',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('0',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      'Following',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 25,
          width: MediaQuery.of(context).size.width * 0.55,
          child: OutlineButton(
            color: Colors.white30,
            onPressed: () {},
            child: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPersonalProfile(BuildContext context, model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _buildPersonalPhoto(),
                  ],
                ),
              ),
              Container(
                  //padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
                  child: _buildFanDetail()),
            ]),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: _buildPersonalIntroduction(context, model.user.email),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.grid_on),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.view_day),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('./assets/20.png'),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(
            child: _buildProductsList(context, model),
          ),
        )
      ],

    );

  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          endDrawer: Container(
            child: _buildSideDrawer(context),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(model.user.email, style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          body: Container(
            child:
                //   children: <Widget>[
                _buildPersonalProfile(context, model),

            // Container(child: _buildProductsList(context, model),),
            // ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('./assets/19.png'),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
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
                    icon: Icon(Icons.person), iconSize: 40, onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
