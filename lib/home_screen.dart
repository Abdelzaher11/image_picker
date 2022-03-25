// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  String? fileName;
  String? encodedImage;
  Future pickImage() async {
   try{
     final image  = await ImagePicker().pickImage(source: ImageSource.camera);
     if (image == null) return;
     final imageTemporary = File(image.path);
     setState(() {
       this.image = imageTemporary;
       fileName = image.path.split('/').last;
       final bytes = File(image.path).readAsBytesSync();
       base64Encode(bytes);
     });
   }on PlatformException catch(e){
     print('Failed to pick image:$e');
   }
  }

  String base64Encode(List<int> bytes) {
    var k = base64.encode(bytes);
    print(k);
    return base64.encode(bytes);
  }

  encode(name){
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(name);
    return encoded;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: (){
                  pickImage();
                },
                child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                color: Colors.blue,
              ),

              MaterialButton(
                onPressed: (){
                  print(fileName);
                  var encodedImage1 = encode(fileName);
                  print(encodedImage1);
                },
                child: Text('Image',style: TextStyle(color: Colors.white),),
                color: Colors.blue,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
