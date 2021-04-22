class Movie{
  int id;
  String name;
  String category;
  String description;
  int releaseDate;
  double rating;
  String image;
  bool isFav;

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map={
      col_movie_name:name,
      col_movie_category:category,
      col_movie_description:description,
      col_movie_release_date: releaseDate,
      col_movie_rating:rating,
      col_movie_image:image,
      col_movie_favorite:isFav
    };
    if(id!=null){
      map[col_movie_id]=id;
    }
    return map;
  }
  Movie.fromMap(Map<String,dynamic> map){
    id=map[col_movie_id];
    name=map[col_movie_name];
    category=map[col_movie_category];
    description=map[col_movie_description];
    releaseDate=map[col_movie_release_date];
    rating=map[col_movie_rating];
    image=map[col_movie_image];
    isFav=map[col_movie_favorite]==0?false:true;
  }
  Movie({this.id, this.name, this.category, this.releaseDate, this.image,this.rating,
      this.isFav=false, this.description});

  @override
  String toString() {
    return 'Movie{id: $id, name: $name, category: $category, description: $description, releaseDate: $releaseDate, rating: $rating, image: $image, isFav: $isFav}';
  }

}
const String table_movie='tbl_movie';
const String col_movie_id='movie_id';
const String col_movie_name='movie_name';
const String col_movie_category='movie_category';
const String col_movie_description='movie_description';
const String col_movie_release_date='movie_release_date';
const String col_movie_rating='movie_rating';
const String col_movie_image='movie_image';
const String col_movie_favorite='movie_favorite';