
import 'package:coffer_order/models/coffee.dart';
import 'package:coffer_order/screens/home/cofee_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeOrderList extends StatefulWidget {

  @override
  _CoffeeOrderListState createState() => _CoffeeOrderListState();
}

class _CoffeeOrderListState extends State<CoffeeOrderList> {

  @override
  Widget build(BuildContext context) {

    final coffeeList = Provider.of<List<Coffee>>(context) ?? [];

    return ListView.builder(
      itemCount: coffeeList.length,
      itemBuilder: (context,index){
        return CoffeeTile(coffee: coffeeList[index]);
      },
    );
  }
}
