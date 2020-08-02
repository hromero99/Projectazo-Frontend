import 'package:flutter/material.dart';
import 'package:projectazo/models/design.dart';
import 'package:projectazo/networking/designs.dart';
import 'dart:async';
import 'package:projectazo/ui/addDesign.dart';


// Widget for the list of all designs loaded in user profile
class DesignListPage extends StatefulWidget {
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
          return Card(
              child: Text(data[index].Description??"asd")
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
        title: Text('Design List Home'),
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
      body: Center(child: _designsData()),
    );
  }
}
