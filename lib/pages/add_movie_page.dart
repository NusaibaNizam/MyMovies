

import 'dart:io';

import 'package:demo_app/models/movie_model.dart';
import 'package:demo_app/providers/movie_provider.dart';
import 'package:demo_app/utils/movie_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMoviePage extends StatefulWidget {
  static final String routeName="/add_movie_page";
  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  String category;
  DateTime releaseDate;
  File imageFile;
  Movie movie=Movie();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber.shade900, //change your color here
        ),
        backgroundColor: Color(0xff000000),
        shadowColor: Colors.black,
        title: Text(
          'Add Movies',
          style: TextStyle(color: Colors.amber.shade900),
        ),
        actions: [
          IconButton(icon: Icon(
            Icons.save,
          ), onPressed: _saveMove)
        ],
      ),
      body: buildForm(context),
    );
  }

  Widget buildForm(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),

            child: SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  SizedBox(height: 10,),
                  movieNameFormField(),
                  SizedBox(height: 20,),
                  movieDescriptionFormField(),
                  SizedBox(height: 20,),
                  movieCategoryFormField(),
                  SizedBox(height: 20,),
                  movieReleaseDateFormField(context),
                  SizedBox(height: 20,),
                  moviePosterFormField()
                ],
              ),
            ),


      ),
      ),
    );
  }

  FormField moviePosterFormField() {
    return FormField(
                builder: (state)=>Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 135,
                        child: imageFile==null?Image.asset('images/upload.png'):Image.file(imageFile),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.camera,color: Colors.amber.shade900,), onPressed:(){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            takePhoto(false);
                          }),
                          IconButton(icon: Icon(Icons.photo,color: Colors.amber.shade900,), onPressed:(){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            takePhoto(true);
                          })
                        ],
                      ),
                      if(state.hasError)Container(child: Text(state.errorText,style: TextStyle(fontSize: 11,color: Colors.red),),)
                    ],
                  ),
                ),
                validator: (_){
                  if(imageFile==null){
                    return 'Movie Poster Needed!';

                  }
                  else {
                    return null;
                  }
                },
                onSaved: (_){
                  movie.image=imageFile.path;
                },
              );
  }

  FormField movieReleaseDateFormField(BuildContext context) {
    return FormField(
                builder:(state)=> Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Text(
                            'Release Date',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),

                          onTap: (){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            selectDate(context);
                          },
                        ),
                        InkWell(
                          child: Text(
                            releaseDate==null?'No Date Selected':DateFormat('dd/MM/yyyy').format(releaseDate),
                            style: TextStyle(color: Colors.white,),
                          ),
                          onTap: (){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            selectDate(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today_outlined,color: Colors.amber.shade900,),
                          onPressed: (){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            selectDate(context);
                          },
                        ),
                      ],
                    ),

                    if(state.hasError)Container(child: Text(state.errorText,style: TextStyle(fontSize: 11,color: Colors.red)),)
                  ]
                ),
                validator: (value) {
                  if(releaseDate==null){
                    return 'Provide Release Date Please!';
                  }
                  else
                    return null;
                },
                onSaved: (value){

                  movie.releaseDate=releaseDate.millisecondsSinceEpoch.toInt();

                },
              );
  }

  DropdownButtonFormField<String> movieCategoryFormField() {
    return DropdownButtonFormField(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                value: category,
                items: catagories.map((catagory) => DropdownMenuItem(
                  child: Text(catagory, style: TextStyle(color: Colors.amber.shade900),),
                  value: catagory,
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    category=value;
                  });
                },
                isExpanded: false,
                hint: Text('Category',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                validator: (value){
                  if(value==null){
                    return 'What about the category?';
                  }
                  return null;
              },
                onSaved: (value) {
                  movie.category=value;
                },
              );
  }

  TextFormField movieDescriptionFormField() {
    return TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Short Description',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'What is the movie about?';
                  }
                  return null;
                },
                onSaved: (value) {
                  movie.description=value;
                },
              );
  }

  TextFormField movieNameFormField() {
    return TextFormField(
                decoration: InputDecoration(
                  labelText: 'Movie Name',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Movie Name Please!';
                  }
                  return null;
                },
                onSaved: (value) {
                  movie.name=value;
                },
              );
  }

  void selectDate(BuildContext context) {

    setState(() async{
      final dt=await showDatePicker(context: context, initialDate: DateTime.now(),
          firstDate: DateTime(1900), lastDate: DateTime(DateTime.now().year+10));
      releaseDate=dt;
    });
  }

  void _saveMove() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Provider.of<MovieProvider>(context,listen: false).addMovie(movie).then((id) => Navigator.pop(context));
    }

  }

  void takePhoto(bool isGallery) async{
    ImageSource imageSource;
    if(isGallery){
      imageSource=ImageSource.gallery;
    }else{
      imageSource=ImageSource.camera;
    }
    final pf=await ImagePicker().getImage(source: imageSource);
    setState(() {
      imageFile=File(pf.path);
    });
  }
}
