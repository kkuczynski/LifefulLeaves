import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String path;
  final String label;
  final icon;
  MenuButton({this.path, this.label, this.icon}); 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, this.path);
        },
        child: Column(
          children: [
            Text(
              this.label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'IndieFlower',
                  color: Colors.green[700],
                  fontSize: 18),
            ),
            Container(
              child: Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green[300],
                    border: Border.all(color: Colors.green[700], width: 2.0)),
                child: Icon(
                  icon,
                  color: Colors.green[700],
                  size: 30.0,
                ),
              ),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green[300], width: 2.0)),
            ),
          ],
        ),
      ),
    );
  }
}
