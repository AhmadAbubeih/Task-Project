import 'package:taskphotosnavigator/Models/PhotoInformations.dart';

class IHomeView {
  void onGetPhotosSuccess(PhotoInformation photoInformation) {}

  void onGetPhotosFail() {}
}

class IHomePresenter {
  void getPhotos(String apiUrl) {}
}
