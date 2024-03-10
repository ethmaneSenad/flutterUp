import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet_formation/page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController  titre = TextEditingController();
  final TextEditingController  auteur = TextEditingController();

  final CollectionReference table = FirebaseFirestore.instance.collection("matable");
  String imageUrl='';
  List matable = [];
  bool isLoading= true;
  // add btn 
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
             final   file = await  ImagePicker().pickImage(source:ImageSource.gallery);
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
                if(imageUrl.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("please select and upload image")));
                  return;
                }
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
              }, child:const Text('Create')))
        
        ], 
      ),
      );
     });
  }
  

  _productItem(product) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.all(5),
          child: ListTile(
            onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MaPage()),
            );
              print("Hello Ethmane");
            },
        
            
              leading: const Icon(Icons.photo_rounded , size: 50,),
        
        
              title:  Text(product['Titre'],
                  style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),
              subtitle: Text (product['Auteur'],
              style: TextStyle(  
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
              ),
                    )
        ),
        
        
        
      ],
    );
  }

  Future<void> getProductFromFirebase() async {
    try {
       FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection("matable").get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        print('*******************************************');
        print(data);
        matable.add(data);
      }
      isLoading=false;
      setState(() {
        
      });

    } catch (error) {
      setState(() {
        
      });
      print('Error fetching hotels: $error');

    }
  }

  void initState() {
    getProductFromFirebase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      isLoading ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        )

      )
      
      :Container(
        margin: EdgeInsets.all(10),
        color:Color.fromARGB(218, 221, 220, 218),
        child:ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount:matable.length,
        itemBuilder: (BuildContext context,int index) {
          return _productItem(matable[index]);
        } ,),)) ;
  }
}