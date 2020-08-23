import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectazo/models/design.dart';
import 'package:projectazo/models/designer.dart';
import 'package:projectazo/networking/designer.dart';
import 'package:projectazo/networking/designs.dart';
import 'package:projectazo/ui/addDesign.dart';
import 'package:projectazo/util/url.dart';
import 'package:projectazo/ui/profile.dart';

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
  Designer _designer = Designer();

  void _assignDesigner(int DesignerID) async{
    _designer = await DesignerRepository().get(DesignerID);
  }
  ListView _designsList(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.25, color: Colors.white),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // This container is used to show the profile picture and the username
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.15, color: Colors.grey)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: data[index].author.profilePicture,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              _assignDesigner(data[index].author.id);
                              return ProfilePage(designer: _designer);
                            }));
                          }
                        ),
                      ),
                      Text(data[index].author.username),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),

                //Space between user information and post
                Container(
                  constraints: BoxConstraints.expand(height: 1),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
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
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(designer: this.widget.designerUser),
                ),
              );
            },
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
              builder: (_) => CreateDesignPage(designer: this.widget.designerUser,),
            ),
          );
        },
      ),
      body: Center(child: _designsData())
    );
  }
}
