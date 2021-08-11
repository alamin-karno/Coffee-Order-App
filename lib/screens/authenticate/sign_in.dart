import 'package:coffer_order/services/auth.dart';
import 'package:coffer_order/shared/constant.dart';
import 'package:coffer_order/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign in To Coffee App'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          return val.isNotEmpty && val.contains('@')
                              ? null
                              : 'Enter your email address';
                        },
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          password = val;
                        },
                        obscureText: true,
                        validator: (val) {
                          return val.length < 6
                              ? 'Enter 6 digit password'
                              : null;
                        },
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .sigInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = _auth.errorSMS;
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.pink[400],
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = _auth.errorSMS.trim();
                    });
                  } else {
                    print('sign in successful');
                    print(result.uid);
                  }
                },
                child: Text(
                  'Sign in Anonymously',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
