import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './address_tag.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Image.asset('./assets/15.png'),
            onPressed: () {},
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.userEmail,
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              AddressTag(product.location.address),
            ],
          )
        ],
      ),
//          Flexible(
//            //child: TitleDefault(product.title),
//            child: Text(product.title, style: TextStyle(fontSize: 20),),
//          ),
//          Flexible(
//            child: PriceTag(product.price.toString()),
//          )
      //],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('./assets/16.png'),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('./assets/18.png'),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                ],
              ),
//              IconButton(
//                icon: Icon(Icons.info),
//                color: Theme.of(context).accentColor,
//                onPressed: () {
//                  model.selectProduct(product.id);
//                  Navigator
//                      .pushNamed<bool>(context, '/product/' + product.id)
//                      .then((_) => model.selectProduct(null));
//                },
//              ),
              IconButton(
                icon: Icon(
                    product.isFavorite ? Icons.turned_in : Icons.turned_in_not),
                color: Colors.black,
                iconSize: 40,
                onPressed: () {
                  model.selectProduct(product.id);
                  model.toggleProductFavoriteStatus();
                },
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildTitlePriceRow(),
          Hero(
            tag: product.id,
            child: FadeInImage(
              image: NetworkImage(product.image),
              // height: 300.0,
              fit: BoxFit.fitWidth,
              placeholder: AssetImage('assets/11.png'),
            ),
          ),
//          SizedBox(
//            height: 0.0,
//          ),
//          AddressTag(product.location.address),
          _buildActionButtons(context),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
