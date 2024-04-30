import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget {  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello World',
        debugShowCheckedModeBanner: false,
        home: Home()

    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Text('Today is thebegining of my flutter class and its my first app dgdddddddddddgn gsdbstebettbeb fffffffffffffffffffff  ',
         textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
        fontSize: 25, fontWeight:  FontWeight.w600,
        backgroundColor: Colors.purple,
        color: Colors.white,
            overflow: TextOverflow.ellipsis
      )),
    )
  );
  }
}

