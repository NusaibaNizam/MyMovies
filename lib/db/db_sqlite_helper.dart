import 'package:demo_app/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as P;

class DBSQLiteHelper{
  static String _create='''create table $table_movie(
      $col_movie_id integer primary key autoincrement,
      $col_movie_name text not null,
      $col_movie_category text not null,
      $col_movie_description text,
      $col_movie_release_date integer not null,
      $col_movie_rating real,
      $col_movie_image text not null,
      $col_movie_favorite integer not null
      )''';



  static Future<Database> _open() async{
    final root=await getDatabasesPath();
    final dbPath=P.join(root,'movie.db');
    return await openDatabase(dbPath,version: 1,onCreate: (db,version) async{
      await db.execute(_create);
    });
  }


  static Future<int> insertMovie(Movie movie) async{
    final db=await _open();
    return await db.insert(table_movie, movie.toMap());
  }

  static Future<int> updateMovieFavorite(int id, int fav) async{
    final db=await _open();
    return await db.update(table_movie, {col_movie_favorite:fav},where: '$col_movie_id = ?',whereArgs: [id]);
  }

  static Future<int> deleteMovie(int id) async{
    final db=await _open();
    return await db.delete(table_movie, where: '$col_movie_id = ?',whereArgs: [id]);
  }

  static Future<List<Movie>> getMovies() async{
    final db=await _open();
    var mapList= await db.query(table_movie,orderBy: '$col_movie_id desc');
    return List.generate(mapList.length, (index) => Movie.fromMap(mapList[index]));
  }

  static Future<Movie> getMovieById(int id) async{
    final db=await _open();
    var mapList= await db.query(table_movie,where: '$col_movie_id = ?' ,whereArgs: [id]);
    return Movie.fromMap(mapList.first);
  }
}