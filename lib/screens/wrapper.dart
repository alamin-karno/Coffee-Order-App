import 'package:coffer_order/models/user.dart';
import 'package:coffer_order/screens/authenticate/authenticate.dart';
import 'package:coffer_order/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
