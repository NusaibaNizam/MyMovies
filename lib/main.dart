
import 'package:demo_app/pages/add_movie_page.dart';
import 'package:demo_app/pages/movie_details_page.dart';
import 'package:demo_app/providers/movie_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/movie_list_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    const Color color=Color(0xFFFF6F00);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => MovieProvider(),)
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          ),
          accentColor: color,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
          ),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        routes: {
          Home.routeName:(context)=>Home(),
          MovieDetailsPage.routeName:(context)=>MovieDetailsPage(),
          AddMoviePage.routeName:(context)=>AddMoviePage(),
        },
      ),
    );
  }

}
