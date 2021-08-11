import 'package:coffer_order/models/user.dart';
import 'package:coffer_order/services/database.dart';
import 'package:coffer_order/shared/constant.dart';
import 'package:coffer_order/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Update Your Order Settings',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                      validator: (val) {
                        return val.isEmpty ? 'Enter your name' : null;
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Name'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      value: _currentSugar ?? userData.sugar,
                      items: sugars.map((e) {
                        return DropdownMenuItem(
                            value: e, child: Text('$e sugars'));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugar = val;
                        });
                      },
                      decoration: textInputDecoration,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor: Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                         await DatabaseService(uid: user.uid)
                             .updateUserData(
                           _currentSugar ?? userData.sugar,
                           _currentName ?? userData.name,
                           _currentStrength ?? userData.strength
                         );
                         Navigator.pop(context);
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
