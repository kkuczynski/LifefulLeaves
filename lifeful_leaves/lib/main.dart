
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/pages/home.dart';
import 'package:lifeful_leaves/pages/loading.dart';
import 'package:lifeful_leaves/pages/menu.dart';

void main() {
  runApp(MaterialApp(

      initialRoute: '/home',
      routes:{
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/menu': (context) => Menu(),
      }
  ));
}