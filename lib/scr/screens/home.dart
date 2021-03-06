import 'package:HeartDoc/scr/screens/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/app.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/screens/search.dart';
import 'package:HeartDoc/scr/screens/plot.dart';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    globals.check = false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "HeartDoc",
          color: white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.orange, Colors.red]),
                color: primary,
              ),
              accountName: CustomText(
                text: user.userModel?.name ?? "username loading...",
                color: white,
                weight: FontWeight.bold,
                size: 25,
              ),
              accountEmail: CustomText(
                  text: user.userModel?.email ?? "email loading...",
                  color: white,
                  size: 25),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, UpdateProfile());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Update Profile"),
            ),
            ListTile(
              onTap: () async {
                //await user.getOrders();
                print(user.userModel?.email);
                changeScreen(context, Search(user.userModel?.email));
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My records"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Divider(),
                    SizedBox(
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          globals.check = await getUpload();
                          if (globals.check) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Input Successful!"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Input File",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          print(globals.check);
                          // Timer(Duration(milliseconds: 300), () async {
                          if (globals.check == true) {
                            await runmodel();
                            changeScreenReplacement(context, Plot());
                            globals.check = false;
                          } else {
                            //print("Dddddd");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Input a valid file first"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          // });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Submit",
                                  color: white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
//
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
