import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectazo/models/design.dart';
import 'package:projectazo/models/designer.dart';
import 'package:projectazo/networking/designs.dart';
import 'dart:async';
import 'package:projectazo/ui/addDesign.dart';
import 'package:projectazo/util/url.dart';


// Widget for the list of all designs loaded in user profile
class DesignListPage extends StatefulWidget {
  final Designer designerUser;
  DesignListPage ({Key key, @required this.designerUser }): super(key: key);

  @override
  _DesignListPageState createState() => _DesignListPageState();
}

class _DesignListPageState extends State<DesignListPage> {

  DesignRepository _designRepository = DesignRepository();
  @override
  void initState(){
    super.initState();
  }

  ListView _designsList(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // This container is used to show the profile picture and the username
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(backgroundImage: data[index].author.profilePicture),
                      ),
                      Text(data[index].author.username,)
                    ],
                  ),
                ),
                //Space between user information and post
                Container(
                  constraints: BoxConstraints.expand(height: 1),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: 282
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Url.baseUrl+data[index].file)
                      )
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  //Function to get the FutureBuilder of designs
  FutureBuilder _designsData(){
    return FutureBuilder<List<Design>>(
      future: _designRepository.getDesignList(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData){
          List<Design> data = snapshot.data;
          return _designsList(data);
        }
        else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projectazo'),
        leading:Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){},
            child: CircleAvatar(
            radius: 20,
            backgroundImage: this.widget.designerUser.profilePicture,
          ),
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateDesignPage(),
            ),
          );
        },
      ),
      body: Center(child: _designsData())
    );
  }
}
