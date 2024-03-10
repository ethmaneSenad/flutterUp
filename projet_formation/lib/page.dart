import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_formation/configration.dart';
import 'package:projet_formation/upload_file.dart';

class MaPage extends StatefulWidget {
  const MaPage({super.key});

  @override
  State<MaPage> createState() => _MaPageState();
}

class _MaPageState extends State<MaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
        backgroundColor: Colors.green,
        leading: BackButton(
          color: Colors.black,
          onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadImage()),
              );}
          
        ),

      ),
    
      body:Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        color: Color.fromARGB(218, 221, 220, 218),
        child: ListView(
          children: [

            // Icon(Icons.fork_left,size: 100,),
            
            Image.asset("assets/images/2.jpg",height: 300),
            Text("L'enfant noir grandit dans un village de Haute-Guinée où le merveilleux côtoie quotidiennement la réalité. Son père, forgeron, travaille l'or au rythme de la harpe des griots et des incantations aux génies du feu et du vent. Respectée de tous, sa mère jouit de mystérieux pouvoirs sur les êtres et les choses.",
        style: TextStyle(fontSize:20,color: Colors.black)
        
        
        
        ),
          ],
        ),
      )
    );
  }
}