import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taskphotosnavigator/Models/PhotoInformations.dart';
import 'package:taskphotosnavigator/Models/Photos.dart';
import 'package:taskphotosnavigator/Utils/ColorsUtils.dart';
import 'package:taskphotosnavigator/Utils/DummyUtils.dart';

class PhotoDetailsPage extends StatefulWidget {
  Photos photoDetails;

  PhotoDetailsPage({Key key, this.photoDetails}) : super(key: key);

  @override
  _PhotoDetailsPageState createState() =>
      _PhotoDetailsPageState(photoDetails: photoDetails);
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  Photos photoDetails;

  _PhotoDetailsPageState({this.photoDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: ColorsUtils.primaryColor,
          expandedHeight: 400.0,
          pinned: true,
          title: Text(photoDetails.photographer),
          flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
              imageUrl: photoDetails.photoSrc.original,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 19.0, right: 19.0, top: 20.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photoDetails.photographer,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '950',
                            )
                          ],
                        ),
                        Icon(
                          Icons.share,
                          color: ColorsUtils.primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(DummyUtils.dummyText)
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.phone,
        ),
        backgroundColor: ColorsUtils.secondaryColor,
      ),
    );
  }
}
