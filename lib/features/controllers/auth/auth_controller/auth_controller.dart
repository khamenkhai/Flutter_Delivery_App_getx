import 'package:delivery_app/features/repositories/auth_repo/auth_repo.dart';
import 'package:delivery_app/features/repositories/storageRepository/storageRepository.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthController({required this.authRepository,required this.userRepository});

  static AuthController instance = Get.find();

  Rx<UserModel?> _user = Rx<UserModel?>(null);

  UserModel? get user => _user.value;
  //Rx<User?> loginUser = Rx<User?>(null);

  var loginStatus = false.obs;

  var loading = false.obs;

  @override
  void onInit() {
    initUserData();
    super.onInit();
  }

  initUserData() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user!=null) {
        getUserDataById(user.uid);
        loginStatus.value = true;
      }else{
        loginStatus.value = false;
      }
    });
  }

  ///create new account
  creteNewAccount(
      {required String email,
      required String password,
      required String username,
      required String phoneNumber,
      required BuildContext context}) async {
    loading.value = true;
    await authRepository.createAccount(
        email: email,
        password: password,
        username: username,
        context: context,
        phoneNumber: phoneNumber);

    await Future.delayed(Duration(milliseconds: 100));
    loading.value = false;
  }

  //login
  loginAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    loading.value = true;
    await authRepository.login(
        email: email, password: password, context: context);
    await Future.delayed(Duration(milliseconds: 100));
    initUserData();
    loading.value = false;
  }

  //signout
  signOut(BuildContext context) {
    authRepository.signOut();
    _user.value = null;
  }

  //get user data by id
  getUserDataById(String id) async {
    _user.bindStream(authRepository.getUserDataById(id));
  }

  //edit userProfile
  Future<bool> editUserProfile({required String name,required String email,required String userId,required String phoneNumber,Uint8List? file})async{
    String photoUrl = "";
    if(file!=null){
      photoUrl = await FirebaseStorageRepository.uploadImage(file, 'DAapp/users/${userId}');
    }
    bool status = await userRepository.editUserProfile(UserModel(userId: userId, name: name, email: email, phoneNumber: phoneNumber,profilePhoto: photoUrl));
    return status;
  }


  //get 
}
