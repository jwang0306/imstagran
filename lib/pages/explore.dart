import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../widgets/products/post.dart';

class PhotosList extends StatelessWidget {
  final List<Photo> photos;
  double imageSize;

  PhotosList({Key key, this.photos}) : super(key: key);

  Widget createImagePost(double sizePercentage, String url) {
    return Container(
        width: imageSize * sizePercentage - 2,
        height: imageSize * sizePercentage - 2,
        margin: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
        ),
        child: FlatButton(
          onPressed: () {},
          child: null,
        ));
  }

  Widget createThreeInRowPhoto(int index, int rowHeadId) {
    return Row(
      children: <Widget>[
        createImagePost(1 / 3, photos[index * 18 + rowHeadId].imageUrl),
        createImagePost(1 / 3, photos[index * 18 + rowHeadId + 1].imageUrl),
        createImagePost(1 / 3, photos[index * 18 + rowHeadId + 2].imageUrl),
      ],
    );
  }

  Widget createExploreBox(int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                createImagePost(1 / 3, photos[index * 18].imageUrl),
                createImagePost(1 / 3, photos[index * 18 + 1].imageUrl),
              ],
            ),
            createImagePost(2 / 3, photos[index * 18 + 2].imageUrl),
          ],
        ),
        createThreeInRowPhoto(index, 3),
        createThreeInRowPhoto(index, 6),
        Row(
          children: <Widget>[
            createImagePost(2 / 3, photos[index * 18 + 9].imageUrl),
            Column(
              children: <Widget>[
                createImagePost(1 / 3, photos[index * 18 + 10].imageUrl),
                createImagePost(1 / 3, photos[index * 18 + 11].imageUrl),
              ],
            ),
          ],
        ),
        createThreeInRowPhoto(index, 12),
        createThreeInRowPhoto(index, 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    imageSize = MediaQuery.of(context).size.width;
    int blockNum = photos.length ~/ 18;

    return ListView.builder(
      itemCount: blockNum,
      itemBuilder: (BuildContext context, int blockIndex) {
        return createExploreBox(blockIndex);
      },
    );
    // return GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //   ),
    //   itemCount: blockNum,
    //   itemBuilder: (context, index) {
    //     return createImagePost(1/3, photos[index].imageUrl);
    //     // return Image.network(photos[index].imageUrl);
    //   },
    // );
  }
}

class Explore extends StatelessWidget {
  double imageSize;

  Widget _buildSearchTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Search', filled: true, fillColor: Colors.white),
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
          body: FutureBuilder<List<Photo>>(
            future: model.fetchAllPosts(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? PhotosList(photos: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
          // body: ListView.builder(
          //   itemCount: 10,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container();
          //     // return createExploreBox(context, photoUrls);
          //   },
          // ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 40,
                  onPressed: () {},
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
      },
    );
  }
}
