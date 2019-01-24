import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/simple_interest_calculator.dart';



void main(){
  runApp(Manifest());
}

class Manifest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Flutter App",
      debugShowCheckedModeBanner: false,
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,

      ),

    );
  }


}