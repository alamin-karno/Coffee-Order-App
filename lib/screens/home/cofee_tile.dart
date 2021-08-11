import 'package:coffer_order/models/coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {

  final Coffee coffee;
  CoffeeTile({this.coffee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shadowColor: Colors.brown[500],
        elevation: 2.0,
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: AssetImage("assets/coffee_icon.png"),
          ),
          title: Text(coffee.name),
          subtitle: Text('Takes ${coffee.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
