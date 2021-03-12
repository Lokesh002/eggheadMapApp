import 'package:egghead_practical/Screens/mapScreen.dart';
import 'package:egghead_practical/backend/ReusableButton.dart';
import 'package:egghead_practical/backend/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:egghead_practical/backend/sizeConfig.dart';
import 'package:egghead_practical/backend/sharedPref.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _LoginState extends State<Login> {
  String userId;
  String password;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  SavedData savedData = SavedData();
  clearTextInput() {
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    //Navigator.pushReplacementNamed(context, "/loadingScreen");

    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              SizedBox(
                height: screenSize.screenHeight * 4,
              ),

              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: screenSize.screenHeight * 4,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenWidth * 15,
                          right: screenSize.screenWidth * 15,
                          top: screenSize.screenHeight * 2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: screenSize.screenHeight * 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your userId' : null,
                              controller: emailcontroller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (name) {
                                this.userId = name;
                                print(this.userId);
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode
                              decoration: InputDecoration(
                                hintText: "User ID",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenWidth * 15,
                          right: screenSize.screenWidth * 15,
                          top: screenSize.screenHeight * 2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: screenSize.screenHeight * 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your password' : null,
                              controller: passwordcontroller,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (name) {
                                this.password = name;
                                print(this.password);
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode

                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 4,
                    ),
                    Center(
                        child: ReusableButton(
                            height: screenSize.screenHeight * 6,
                            width: screenSize.screenWidth * 50,
                            content: 'Login',
                            onPress: () async {
                              if (_formkey.currentState.validate()) {
                                showAlertDialog(context);

                                Networking networking = Networking();
                                var data = await networking.postDataByUser({
                                  "userid": userId,
                                  "password": password,
                                  "device": "iPhone 11 Pro",
                                  "ip_address": "192.168.1.1",
                                  "firebase_id": "26451564164164514614145"
                                });
                                if (data['status'] == 'success') {
                                  if (data['id'] == 401) {
                                    savedData.setLoggedIn(true);
                                    Fluttertoast.showToast(
                                        msg: "Login Successfully");
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MapScreen()));
                                    setState(() {});
                                  }
                                } else {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: 'Wrong credentials!!');
                                }
                              }
                            })),
                    SizedBox(
                      height: screenSize.screenHeight * 2,
                    ),
                  ],
                ),
              ),
              //)
            ]),
          ),
        ],
      ),
    );
  }
}
