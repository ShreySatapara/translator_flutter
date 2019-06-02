import 'package:flutter/material.dart';
import './pages/homePage.dart';

void main(){
  runApp(MaterialApp(
      title: 'Translator',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        errorColor: Colors.yellowAccent,
      ),
      home: HomePage()
  ));
}