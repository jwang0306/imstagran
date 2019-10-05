import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './chat_screen.dart';


class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Image.asset('./assets/06.png'),onPressed: (){Navigator.pop(context);},),
              Text('Direct Message'),
              IconButton(icon: Image.asset('./assets/02.png'),onPressed: (){},),
            ],
          )
      ),
      body: ChatScreen()
    );
  }
}
