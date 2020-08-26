import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taskphotosnavigator/Home/HomeContract.dart';
import 'package:taskphotosnavigator/Home/HomePresenter.dart';
import 'package:taskphotosnavigator/Models/PhotoInformations.dart';
import 'package:taskphotosnavigator/Models/Photos.dart';
import 'package:taskphotosnavigator/Utils/ApiUrl.dart';
import 'package:taskphotosnavigator/Utils/ColorsUtils.dart';
import 'package:taskphotosnavigator/Utils/NavigatorUtils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorsUtils.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements IHomeView {
  HomePresenter presenter;

  List<Photos> photos = new List<Photos>();

  ScrollController scrollController = new ScrollController();

  String nextApiUrl;

  @override
  void initState() {
    super.initState();

    presenter = new HomePresenter(this);

    presenter.getPhotos(ApiUrl.getPhotosUrl);

    addScrollControllerListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: photos.isEmpty
          ? _waitingWidget()
          : SafeArea(
              child: ListView.builder(
                controller: scrollController,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => NavigatorUtils.navigateToPhotoDetailsPage(
                          context, photos[index]),
                      child: _buildFeaturedItem(
                        image: photos[index].photoSrc.original,
                        title: photos[index].photographer,
                      ));
                },
              ),
            ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void addScrollControllerListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        presenter.getPhotos(nextApiUrl);
      }
    });
  }

  Widget _waitingWidget() {
    return Center(
      child: SpinKitDualRing(
        color: ColorsUtils.secondaryColor,
        size: 35.0,
      ),
    );
  }

  Container _buildFeaturedItem({String image, String title}) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 380,
                )),
            Positioned(
              left: 10.0,
              top: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 10,
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.black.withOpacity(0.7),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                    ),
                    Center(
                      child: Text('350',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onGetPhotosFail() {}

  @override
  void onGetPhotosSuccess(PhotoInformation photoInformation) {
    setState(() {
      nextApiUrl = photoInformation.nextPage;

      this.photos.addAll(photoInformation.photos);
    });
  }
}
