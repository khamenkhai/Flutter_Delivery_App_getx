import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/common/aboutUs.dart';
import 'package:delivery_app/features/view/common/privacyPolicy.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingSubScreens/languageChangeScreen.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingSubScreens/saveAddressScreen.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingSubScreens/userEditProfile.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingSubScreens/userWallet.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UserSettingScreenScreen extends StatefulWidget {
  const UserSettingScreenScreen({super.key});

  @override
  State<UserSettingScreenScreen> createState() =>
      _UserSettingScreenScreenState();
}

class _UserSettingScreenScreenState extends State<UserSettingScreenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50.withOpacity(0.3),
      appBar: AppBar(title: Text("Settings"), elevation: 0),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 120,
            //   width: 120,
            //   margin: EdgeInsets.only(bottom: 20),
            //   decoration: BoxDecoration(
            //     color: Colors.lightGreen.shade120,
            //     shape: BoxShape.circle,
            //   ),
            //   child: Center(
            //     child: Icon(Ionicons.person, size: 60),
            //   ),
            // ),
            // MyText(
            //     text: "${authController.user!.name}",
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold),
            // SizedBox(height: 15),
            // MyText(
            //     text: "+${authController.user!.phoneNumber}",
            //     color: ThemeConstant.secondaryTextColor,
            //     fontSize: 15),
            SizedBox(height: 25),

            ///edit profile list tile
            ListTile(
              onTap: () {
                navigatorPush(
                    context, EditProfileScreen(user: authController.user!));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.lightGreen.shade50,
                child: Icon(
                  Ionicons.person_sharp,
                  color: Colors.lightGreen,
                  size: 19,
                ),
              ),
              title: Text("Edit Profile"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            ///wallet list tile
            SizedBox(height: 12),
            ListTile(
              onTap: () {
                navigatorPush(context, UserWalletScreen());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(
                  Ionicons.wallet,
                  color: Colors.blue,
                  size: 19,
                ),
              ),
              title: Text("Wallet"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            SizedBox(height: 12),
            ListTile(
              onTap: () {
                navigatorPush(context, SaveAddressScreen());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade50,
                child: Icon(
                  Ionicons.location,
                  color: Colors.indigo,
                  size: 19,
                ),
              ),
              title: Text("Save Address"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            SizedBox(height: 12),
            ListTile(
              onTap: () {
                navigatorPush(context, UserLanguageScreen());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade50,
                child: Icon(
                  Ionicons.language,
                  color: Colors.green,
                  size: 19,
                ),
              ),
              title: Text("Language"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            SizedBox(height: 12),
            ListTile(
              onTap: () {
                navigatorPush(context, PrivacyPolicy());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: Icon(
                  Icons.question_mark,
                  color: Colors.orange,
                  size: 19,
                ),
              ),
              title: Text("Privacy Policy"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            SizedBox(height: 12),
            ListTile(
              onTap: () {
                navigatorPush(context, AboutUs());
              },
              leading: CircleAvatar(
                backgroundColor: Colors.amber.shade50,
                child: Icon(
                  Icons.verified_user,
                  color: Colors.amber,
                  size: 19,
                ),
              ),
              title: Text("About Us"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            SizedBox(height: 12),
            ListTile(
              onTap: () {
                _logoutDialog(context);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade50,
                child: Icon(
                  Ionicons.log_out,
                  color: Colors.red,
                  size: 19,
                ),
              ),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  //logout alert dialog 
  _logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Text("Are you sure to log out?",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              SizedBox(height: 0),
              ListTile(
                onTap: () {
                  //logout account
                  authController.signOut(context);
                  Navigator.pop(context);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logout"),
                  ],
                ),
              ),
              SizedBox(height: 0),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cancel"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
