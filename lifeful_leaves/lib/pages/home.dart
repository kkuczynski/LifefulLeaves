import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/widgets/open_menu_fab.dart';

class Home extends StatefulWidget {
  final DatabaseService dbService;
  const Home({
    Key key,
    @required this.dbService,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green[50], Colors.white])),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                  widget.dbService.getWeeklyConditions().humidity[5].toString())
            ],
          )),
      floatingActionButton: OpenMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
