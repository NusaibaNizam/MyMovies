
import 'dart:io';

import 'package:demo_app/providers/movie_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../pages/movie_details_page.dart';

class MovieItem extends StatefulWidget {

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    Movie movie=Provider.of<MovieProvider>(context,listen: false).movieListItem;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, MovieDetailsPage.routeName, arguments: movie.id);
      },
      child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 9,
                    spreadRadius: 5,
                    offset: Offset.fromDirection(0).translate(5, 9)
                )
              ]
          ),

          child:Stack(

            children:[
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                    child: Hero(
                        tag: movie.id,
                        child: Image.file(File(movie.image),width: double.maxFinite,height: 455,fit: BoxFit.cover,)
                    )
              ),

              Positioned(
                  right: 10,
                  top:10,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child: IconButton(
                          onPressed: (){
                            Provider.of<MovieProvider>(context, listen: false).changeMovieFav(movie);
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 33,
                            color: movie.isFav?Colors.redAccent:Colors.white,
                          )
                      )
                  )
              ),
              Positioned(
                  right: 10,
                  bottom:55,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child: IconButton(
                          onPressed: (){
                            deleteMovie(context, movie);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 33,
                            color: Colors.amber.shade900,
                          )
                      )
                  )
              ),
              Positioned(
                  left: 20,
                  bottom:57,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child:Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(movie.releaseDate)).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.black,
                              ),

                            ]
                        ),
                      )
                  )
              ),
              if(movie.rating!=null)Positioned(
                  left: 20,
                  top:15,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child:Text(
                        movie.rating.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.black,
                              ),

                            ]
                        ),
                      )
                  )
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0,-0.60),
                  child: LimitedBox(
                    child: Text(movie.name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.amber.shade900,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black,
                            ),

                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0,-0.45),
                  child: LimitedBox(
                    child: Text(movie.category.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black,
                            ),

                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )

            ]
        )
      ),
    );
  }

  void deleteMovie(BuildContext context, Movie movie) {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Delete ${movie.name}?'),
          content: Text('This content cannot be recovered after deleting.'),
          actions: [
            CupertinoButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.amber.shade900),)),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              Provider.of<MovieProvider>(context, listen: false).deleteMovie(movie.id);
            }, child: Text('Delete',style: TextStyle(color: Color(0xff000000))),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.amber.shade900)),),
          ],
        ),
    );
  }


}
