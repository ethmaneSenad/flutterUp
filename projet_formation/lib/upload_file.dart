import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projet_formation/page.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final TextEditingController  titre = TextEditingController();
  final TextEditingController  auteur = TextEditingController();

  final CollectionReference table = FirebaseFirestore.instance.collection("matable");
  // collection name must be same as firebase collection name
  String imageUrl='';

  Future<void> _create([DocumentSnapshot ? documentSnapshot]) async {
   await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder:(BuildContext ctx){
      return  Padding(
      padding: EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
        bottom: MediaQuery.of(ctx).viewInsets.bottom +20),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Center(
            child: Text("Create your Items"),),

        TextField(
          controller: titre,
          decoration:const InputDecoration(
          labelText: 'Title', hintText: 'Title',),
          ),
           TextField(
          controller: auteur,
          decoration:const InputDecoration(
          labelText: 'Auteur', hintText: 'Auteur', ),
          ),
          const SizedBox(
            height: 10,),
          Center(child: IconButton(onPressed: () async{
              //add the package image_picker
             final file = await  ImagePicker().pickImage(source:ImageSource.gallery);
             if (file==null)return;
             
             String fileName = 
             DateTime.now().microsecondsSinceEpoch.toString();
             // Get the reference to Storage root
             //We create the image folder first and insider folder we upload the image
             Reference referenceRoot =
              FirebaseStorage.instance.ref();
              Reference referenceDireImages = referenceRoot.child('images');

              // we have ceata reference for the image to be stored
              Reference referenceImageaToUpload = referenceDireImages.child(fileName);

              // For errors handled and/or success
              try {
                await referenceImageaToUpload
                .putFile(File(file.path));
                //make this upload image link in firebase database
                imageUrl = await referenceImageaToUpload.getDownloadURL();
                

              }catch(error){
                // some error
              }

            },
             icon:const Icon(Icons.camera_alt))),
          Center(
            child: ElevatedButton(
              onPressed:() async {
                // if(imageUrl.isEmpty){
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("please select and upload image")));
                //   return;
                // }
                final String Titre = titre.text;
                final String Auteur= auteur.text;
                if (Auteur!= null){
                  await table.add({  //ajouter champ dant ton firebase firestore
                    "Titre":Titre,
                    "Auteur":Auteur,
                    "image":imageUrl,
                  });
                  titre.text = '';
                  auteur.text = '';
                  Navigator.of(context).pop();
                }
              }, child:const Text('Ajouter un livre')))
        
        ], 
      ),
      );
     });
  }

  late Stream<QuerySnapshot> _stream;
  @override
  void initState(){
    super.initState();
    _stream = FirebaseFirestore.instance.collection('matable').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("Liste de mes livres",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
        ) ,
        body: Container(
          margin: const EdgeInsets.all(10),
        color:const Color.fromARGB(218, 221, 220, 218),
        padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Center(child: Text("Some error occured ${snapshot.error}"),);
              }
              // Now ,cheik if detea arried?
              if(snapshot.hasData){
                QuerySnapshot querySnapshot =snapshot.data;
                List<QueryDocumentSnapshot>document = querySnapshot.docs;
          
                // we need to convert your documents to Maps to disply
                List<Map> table =document.map((e)=>e.data()as Map).toList();
          
                //At last, Display the list of table
                return ListView.builder(
                  itemCount: table.length,
                  itemBuilder: (BuildContext context, int idex){
                  Map thisTable = table[idex];
                  return ListTile(
                    // title: Text("${thisTable['Titre']}"),
                    title : Card(
            color: Colors.white,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MaPage()),
              );
                print(imageUrl);
              },
          
              
                leading: const Icon(Icons.photo_rounded , size: 50,),
                // leading: Image.asset("assets/images/chaise.png"),
                
                // Image.asset("assets/images/chaise.png")
          
          
                title:  Text("${thisTable['Titre']}",
                style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),
                subtitle: Text ("${thisTable['Auteur']}",
                style: const TextStyle(  
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                ),
                      )
          ),
                  );
                });
              }
              return const Center(child: CircularProgressIndicator(),);
          
          },),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _create();
        },
      child:const Icon(Icons.add , color: Colors.white,),backgroundColor: Colors.blueAccent,),
    );
  }
}
//Now we have do your main last upload image and