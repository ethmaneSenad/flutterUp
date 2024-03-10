import 'package:flutter/material.dart';
import 'package:projet_formation/configration.dart';

class MaPage extends StatefulWidget {
  const MaPage({super.key});

  @override
  State<MaPage> createState() => _MaPageState();
}

class _MaPageState extends State<MaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [
          Icon(Icons.wb_sunny_rounded,size: 100,),
           Text("Home Screen",
      style: TextStyle(fontSize:20),
      
      
      
      ),
        ],
      )
    );
  }
}