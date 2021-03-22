import 'package:HeartDoc/scr/screens/notification.dart';
import 'package:HeartDoc/scr/screens/record.dart';
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
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/models/user.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    // // final categoryProvider = Provider.of<CategoryProvider>(context);
    // // final restaurantProvider = Provider.of<RestaurantProvider>(context);
    // // final productProvider = Provider.of<ProductProvider>(context);
    // restaurantProvider.loadSingleRestaurant()
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "HeartDoc",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notification_important),
                onPressed: () {
                  changeScreen(context, notification_screen());
                },
              ),
            ],
          ),
        ],
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
                changeScreen(context, recordscreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My records"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
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
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      // child: Icon(Icons.input),
                      onTap: () async {
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        getUpload();
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

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     CustomText(
                  //       text: "Search by:",
                  //       color: grey,
                  //       weight: FontWeight.w300,
                  //     ),
                  //     DropdownButton<String>(
                  //       value: app.filterBy,
                  //       style: TextStyle(
                  //           color: primary, fontWeight: FontWeight.w300),
                  //       icon: Icon(
                  //         Icons.filter_list,
                  //         color: primary,
                  //       ),
                  //       elevation: 0,
                  //       onChanged: (value) {
                  //         if (value == "Products") {
                  //           app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                  //         } else {
                  //           app.changeSearchBy(
                  //               newSearchBy: SearchBy.RESTAURANTS);
                  //         }
                  //       },
                  //       items: <String>["Products", "Restaurants"]
                  //           .map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //             value: value, child: Text(value));
                  //       }).toList(),
                  //     ),
                  //   ],
                  // ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
//                   Container(
//                     height: 100,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: categoryProvider.categories.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () async {
// //                              app.changeLoading();
//                               await productProvider.loadProductsByCategory(
//                                   categoryName:
//                                       categoryProvider.categories[index].name);

//                               changeScreen(
//                                   context,
//                                   CategoryScreen(
//                                     categoryModel:
//                                         categoryProvider.categories[index],
//                                   ));

// //                              app.changeLoading();
//                             },
//                             child: CategoryWidget(
//                               category: categoryProvider.categories[index],
//                             ),
//                           );
//                         }),
//                   ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Graphical Presentations",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 220,
                    child: Column(children: <Widget>[
                      Expanded(
                        child: new charts.LineChart(
                          getSeriesData(),
                          animate: true,
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                              tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                      zeroBound: false,
                                      )
                          ),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Result",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: restaurantProvider.restaurants
                  //       .map((item) => GestureDetector(
                  //             onTap: () async {
                  //               app.changeLoading();

                  //               await productProvider.loadProductsByRestaurant(
                  //                   restaurantId: item.id);
                  //               app.changeLoading();

                  //               changeScreen(
                  //                   context,
                  //                   RestaurantScreen(
                  //                     restaurantModel: item,
                  //                   ));
                  //             },
                  //             child: RestaurantWidget(
                  //               restaurant: item,
                  //             ),
                  //           ))
                  //       .toList(),
                  // )
                ],
              ),
            ),
    );
  }
}
