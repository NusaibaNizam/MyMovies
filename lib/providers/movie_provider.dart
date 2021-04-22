
import 'package:demo_app/db/db_sqlite_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/movie_model.dart';

class MovieProvider extends ChangeNotifier{
  Movie _movie_list_item;


  set movieListItem(Movie value) {
    _movie_list_item = value;
  }
  Future<Movie> getMovieById(int id){
    return DBSQLiteHelper.getMovieById(id);
  }
  Future<List<Movie>> getMovies(){
    return DBSQLiteHelper.getMovies();
  }
  Future<int> addMovie(Movie movie){
    return DBSQLiteHelper.insertMovie(movie);
  }

  Movie get movieListItem => _movie_list_item;


  void changeMovieFav(Movie movie){
    movie.isFav=!movie.isFav;
    int fav=movie.isFav?1:0;
    DBSQLiteHelper.updateMovieFavorite(movie.id, fav).then((value) => {
      notifyListeners()
    });
  }

  void deleteMovie(int movieId) {
    DBSQLiteHelper.deleteMovie(movieId).then(
        (value) =>{
          notifyListeners()
        }
    );
  }
}