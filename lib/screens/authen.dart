import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:tongproduct/screens/product_list_view.dart';
import 'package:tongproduct/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  String email, password;

  @override
  void initState() {
    super.initState();
    // checkStatus(context);
  }

  void checkStatus(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser() != null) {
      print('Login');
      setState(() {
        
      });
      // moveToProduct(context);
      // var productRoute = MaterialPageRoute(builder: (BuildContext context) => ProductListView());
      // Navigator.of(context).pushAndRemoveUntil(productRoute, (Route<dynamic> route) => false);
    } else {
      print('Logout');
    }
  }

  void moveToProduct(BuildContext context) {
    setState(() {
      var productRoute =
        MaterialPageRoute(builder: (BuildContext context) => ProductListView());
        Navigator.of(context)
        .pushAndRemoveUntil(productRoute, (Route<dynamic> route) => false); //no show arrow
    });
    
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo2.png'),
    );
  }

  Widget showAppName() {
    return Container(
      alignment: Alignment(0, -1),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        'Tong Product',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.green[900],
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget emailTextFromField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.green[400],
            ),
            labelText: 'email : ',
            helperText: 'Your@email.com',
            labelStyle: TextStyle(color: Colors.green[400]),
            helperStyle: TextStyle(color: Colors.yellow[800]),
          ),
          validator: (String value) {
            if (!((value.contains('@')) && (value.contains('.')))) {
              return 'Please Email Format';
            }
          },
          onSaved: (String value) {
            email = value;
          },
        ),
      ),
    );
  }

  Widget passwordTextFromField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.green[900],
            ),
            labelText: 'Password : ',
            helperText: 'More 6 charector',
            labelStyle: TextStyle(color: Colors.green[900]),
            helperStyle: TextStyle(color: Colors.yellow[800]),
          ),
          validator: (String value) {
            if (value.length <= 5) {
              return 'Password More Than 5 Charactor';
            }
          },
          onSaved: (String value) {
            password = value;
          },
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return Expanded(
      child: FlatButton(
        color: Colors.green[400],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          print('Click Sign in');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            checkEmailAndPassword(context);
          }
        },
      ),
    );
  }

  void checkEmailAndPassword(BuildContext context) async {
    print('email = $email, password = $password');

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('Login True');
      moveToProduct(context);

    }).catchError((value) {
      //print('Login Fail Because ==> $value');
      String message = value.message;
      print('Login Fail Because ==> $message');
      myAlertDialog(message); //call show dialog
    });
  }

  void myAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Authen False'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget signUpButton(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.green[400]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.green[800]),
        ),
        onPressed: () {
          print('Click Sign up');
          var routeRegister =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(routeRegister);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            center: Alignment(0, 0),
            colors: [Colors.white, Colors.blue[500]],
            radius: 1.5,
          )),
          alignment: Alignment(0, -1),
          padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
          child: Column(
            children: <Widget>[
              showLogo(),
              showAppName(),
              emailTextFromField(),
              passwordTextFromField(),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                alignment: Alignment(0, -1),
                child: Container(
                  width: 250.0,
                  child: Row(
                    children: <Widget>[
                      signInButton(context),
                      signUpButton(context),
                    ],
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
