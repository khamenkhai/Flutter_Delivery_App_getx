import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_content/flutter_snackbar_content.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

Future<Uint8List?> myImagePicker() async {
  try {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
  } catch (e) {
    debugPrint('Failed to pick image: $e');
  }
  return null;
}

navigatorPush(BuildContext context, Widget route,
    [PageTransitionType type = PageTransitionType.fade]) {
  Navigator.push(context, PageTransition(child: route, type: type));
}

navigatorPushReplacement(BuildContext context, Widget route,
    [PageTransitionType type = PageTransitionType.fade]) {
  Navigator.pushReplacement(context, PageTransition(child: route, type: type));
}

showMessageSnackBar(
    {required String message, required BuildContext context, bool? isSuccess}) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text(message))
  // );
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 35, left: 15, right: 15),
    //backgroundColor: Colors.grey.shade900,
    backgroundColor: Colors.transparent,
    content: FlutterSnackbarContent(
      color: Colors.grey.shade900,
      //color: Colors.transparent,
      message: '${message}',
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

//loading widget
Widget loadingWidget({Color color = Colors.black, double size = 35}) {
  return Center(child: SpinKitFadingCircle(color: color, size: size));
}

Widget errorWidget(String errorMessage) {
  print("error message : ${errorMessage}");
  return Container(
    height: 500,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 20))
      ],
    ),
  );
}

Future<Uint8List?> pickImage(bool isCamera) async {
  final picker = ImagePicker();
  XFile? pickedFile = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery);

  if (pickedFile != null) {
    List<int> imageBytes = await pickedFile.readAsBytes();

    Uint8List uint8List = Uint8List.fromList(imageBytes);
    return uint8List;
  }

  return null;
}

String generateRandomId() {
  const characters = '0123456789';
  final random = Random();
  StringBuffer idBuffer = StringBuffer();

  for (int i = 0; i < 5; i++) {
    int randomIndex = random.nextInt(characters.length);
    idBuffer.write(characters[randomIndex]);
  }

  return "#${idBuffer}";
}

//get color code
Color getColorByCode(String colorString) {
  switch (colorString) {
    case 'amber':
      return Colors.amber;
    case 'blue':
      return Colors.blue;
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'teal':
      return Colors.teal;
    case 'yellow':
      return Colors.yellow;
    case 'indigo':
      return Colors.indigo;
    case 'pink':
      return Colors.pink;
    case 'cyan':
      return Colors.cyan;
    case 'brown':
      return Colors.brown;
    case 'grey':
      return Colors.grey;
    case 'deepOrange':
      return Colors.deepOrange;
    case 'lightGreen':
      return Colors.lightGreen;
    case 'lightBlue':
      return Colors.lightBlue;
    case 'deepPurple':
      return Colors.deepPurple;
    case 'lime':
      return Colors.lime;
    case 'blueGrey':
      return Colors.blueGrey;
    default:
      return Colors.black;
  }
}

Map<String, Color> colorMap = {
  'amber': Colors.amber,
  'blue': Colors.blue,
  'red': Colors.red,
  'green': Colors.green,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'teal': Colors.teal,
  'yellow': Colors.yellow,
  'indigo': Colors.indigo,
  'pink': Colors.pink,
  'cyan': Colors.cyan,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'deepOrange': Colors.deepOrange,
  'lightGreen': Colors.lightGreen,
  'deepPurple': Colors.deepPurple,
  'tealAccent': Colors.tealAccent,
  'lime': Colors.lime,
  'blueGrey': Colors.blueGrey,
};

roundedElevatedStyle() {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
}
// Color getColorDataByCode(int code) {
//   if (code >= 0 && code < colorList.length) {
//     return colorList[code];
//   } else {
//     return Colors.black;
//   }
// }