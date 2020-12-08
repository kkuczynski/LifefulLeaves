import 'package:flutter/material.dart';

class WateringList extends StatefulWidget {
  @override
  _WateringListState createState() => _WateringListState();
}

class _WateringListState extends State<WateringList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green[700]),
        title: Text(
          'Do podlania',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              color: Colors.green[700],
              fontSize: 32),
        ),
      ),
    );
  }
}
