import 'package:flutter/material.dart';
import 'package:taskphotosnavigator/Models/Photos.dart';
import 'package:taskphotosnavigator/PhotoDetails/PhotoDetailsPage.dart';

class NavigatorUtils {
  static void navigateToPhotoDetailsPage(context, Photos photoDetails) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhotoDetailsPage(
                  photoDetails: photoDetails,
                )));
  }
}
