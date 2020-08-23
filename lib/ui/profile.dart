import 'package:flutter/material.dart';
import 'package:projectazo/models/designer.dart';
import 'package:projectazo/models/design.dart';
import 'package:projectazo/util/url.dart';
import 'package:projectazo/networking/designs.dart';


class ProfilePicture extends StatefulWidget {
  Designer designer;
  ProfilePicture ({Key key, @required this.designer }): super(key: key);
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.designer.username.toString() + " Home"),
      ),
      body: FutureBuilder<List<Design>>(
          future: DesignRepository().getUserDesigns(this.widget.designer.username.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Design> data = snapshot.data;
              return GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                            decoration:  BoxDecoration(
                                image:  DecorationImage(
                                    image:  NetworkImage(snapshot.data[index].file),
                                    fit: BoxFit.cover
                                )
                            )
                        )
                    );
                  });
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
