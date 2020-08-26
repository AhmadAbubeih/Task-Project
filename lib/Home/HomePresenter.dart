import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:taskphotosnavigator/Models/PhotoInformations.dart';
import 'package:taskphotosnavigator/Models/Photos.dart';
import 'package:taskphotosnavigator/Utils/ApiUrl.dart';

import 'HomeContract.dart';

class HomePresenter implements IHomePresenter {
  IHomeView view;

  HomePresenter(IHomeView view) {
    this.view = view;
  }

  @override
  Future<void> getPhotos(String apiUrl) async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader:
          "Bearer ${ApiUrl.token}",
    };

    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      var photoInformation =
          PhotoInformation.fromJson(jsonDecode(response.body));

      view.onGetPhotosSuccess(photoInformation);
    } else {
      view.onGetPhotosFail();
    }
  }
}
