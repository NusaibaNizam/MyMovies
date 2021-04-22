import 'package:demo_app/models/movie_model.dart';
import 'package:demo_app/pages/add_movie_page.dart';
import 'package:demo_app/providers/movie_provider.dart';
import 'package:demo_app/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  static final String routeName="/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return buildMovieList();
  }

  Scaffold buildMovieList() {
    return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.amber.shade900, //change your color here
      ),
      backgroundColor: Color(0xff000000),
      shadowColor: Colors.black,
      elevation: 300,
      title: Text(
          'My Movies',
          style: TextStyle(color: Colors.amber.shade900),
      ),
    ),
    body: SafeArea(
      child: Consumer<MovieProvider>(
        builder: (_, provider, child) =>
        Padding(
          padding: const EdgeInsets.only(left: 1, right: 1),
          child: FutureBuilder<List<Movie>>(
            future: provider.getMovies(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemBuilder:(context, index) {
                    provider.movieListItem=snapshot.data[index];
                    return MovieItem();
                  },
                  itemCount: snapshot.data.length,
                );
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
          /*child: ListView.builder(
            itemBuilder:(context, index) {
              provider.movieListItem=provider.movieList[index];
              return MovieItem();
            },
            itemCount: provider.movieList.length,
          ),*/
        )
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddMoviePage.routeName).then((_) => {
            setState(() {})
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 20,
      ),
  );
  }

}



