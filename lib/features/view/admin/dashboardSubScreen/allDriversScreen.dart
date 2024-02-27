import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDriversScreen extends StatefulWidget {
  const AllDriversScreen({super.key});

  @override
  State<AllDriversScreen> createState() => _AllDriversScreenState();
}

class _AllDriversScreenState extends State<AllDriversScreen> {

  @override
  void initState() {
    driverController.getDrivers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drivers")),
   
      body: Obx(
        () =>
            ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: driverController.drivers.length,
              padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                UserModel driver= driverController.drivers[index];
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text("${driver.name}"),
                  subtitle: Text("${driver.phoneNumber}"),
                );
              },
            ),
           
      ),
    );
  }



}
