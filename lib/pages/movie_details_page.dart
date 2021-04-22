import 'dart:io';

import 'package:demo_app/providers/movie_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';

class MovieDetailsPage extends StatefulWidget {

  static final String routeName="/movie_details_page";

  const MovieDetailsPage();
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  int movieId;

  @override
  void didChangeDependencies() {
    movieId=ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MovieProvider>(
        builder: (context, provider, child) =>FutureBuilder<Movie>(
          future: provider.getMovieById(movieId),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return buildScaffold(context,snapshot.data);
            }
            else if(snapshot.hasError){
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text("Failed To Get Movies",style: TextStyle(fontSize: 15, color: Colors.redAccent),),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
    ) ;
  }

  Scaffold buildScaffold(BuildContext context,Movie movie) {
    return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.amber.shade900, //change your color here
      ),
      backgroundColor: Colors.black,
      title: Text(
        '${movie.name}',
        style: TextStyle(color: Colors.amber.shade900),
      ),
    ),
    body:buildMovieProfile(context,movie) ,
  );
  }
/*
*/
  Widget buildMovieProfile(BuildContext context,Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom:Radius.elliptical(MediaQuery.of(context).size.width, 90.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset.fromDirection(0).translate(0, 10),
                  color: Colors.black,
                  blurRadius: 20,
                  spreadRadius: 1
                )
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom:Radius.elliptical(MediaQuery.of(context).size.width, 90.0)),
                child: Hero(
                    tag:movie.id,
                    child: Image.file(File(movie.image),width: double.maxFinite, height: 555,fit: BoxFit.cover,)
                )
            ),
          ),
        SizedBox(height: 10,),

        Text(movie.category,
        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
        ),
        SizedBox(height: 10,),

        Text(DateFormat('yyyy').format(DateTime.fromMillisecondsSinceEpoch(movie.releaseDate)).toString(),
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10,),
      ],
    );
  }
}
