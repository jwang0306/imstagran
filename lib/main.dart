import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped-models/main.dart';
import './models/product.dart';
import './widgets/helpers/custom_route.dart';
import './shared/global_config.dart';
import 'package:camera/camera.dart';
import './pages/personal.dart';
import './pages/explore.dart';

List<CameraDescription> cameras;
Future<Null> main() async {
  // debugPaintSizeEnabled = true;
  cameras = await availableCameras();
  MapView.setApiKey(apiKey);
  runApp(MyApp());
}

//void main() {
//  // debugPaintSizeEnabled = true;
//  // debugPaintBaselinesEnabled = true;
//  // debugPaintPointersEnabled = true;
//  MapView.setApiKey(apiKey);
//  runApp(MyApp());
//}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building main page');

    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.grey,
        ),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_model, cameras),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsAdminPage(_model),
          '/personal': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PersonalPage(_model),
          '/explore': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : Explore(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            final Product product =
                _model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return CustomRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => !_isAuthenticated
                  ? AuthPage()
                  : ProductsPage(_model, cameras));
        },
      ),
    );
  }
}
