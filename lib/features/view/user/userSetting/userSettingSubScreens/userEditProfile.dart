import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EditProfileScreen extends StatefulWidget {

  final UserModel user;
  EditProfileScreen({required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Uint8List? imageProfile;

  pickImageFromGallery()async{
    print("testing");
    Uint8List? image = await pickImage(false);
    if(image!=null){
      setState(() {
        imageProfile = image;
      });
    }
  }

  @override
  void initState() {
    if(authController.user!=null){
      nameController.text = widget.user.name;
      emailController.text = widget.user.email;
      phoneNumberController.text = widget.user.phoneNumber;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"),
      actions: [
        TextButton(onPressed: ()async{
         bool status = await authController.editUserProfile(name: nameController.text, 
          email: emailController.text, 
          userId: widget.user.userId, 
          phoneNumber: phoneNumberController.text,
          file: imageProfile
          );
          if(status){
            Navigator.pop(context);
          }
        }, child: Text("Save"))
      ],
      ),

      body: Container(
        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(  
            children: [
          
              InkWell(
                onTap: (){
                  pickImageFromGallery();
                },
                child: Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(bottom: 35),
                  decoration: BoxDecoration(
                    color:imageProfile==null ? Colors.white : Colors.transparent
                  ),
                  child:imageProfile==null ? Center(
                    child: Icon(Ionicons.person,size:60),
                  ) : Image.memory(imageProfile!,fit:BoxFit.cover),
                ),
              ),
          
          
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15)
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15)
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15)
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}