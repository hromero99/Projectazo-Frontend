import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../networking/designs.dart';
import 'package:projectazo/models/designer.dart';


Widget setImageView(File imageFile) {
  if (imageFile != null) {
    return Card(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Image.file(imageFile, width: 250, height: 250),
      ),
    );
  } else {
    return Card(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Center(
            child: Text("Bro, pick up a photo")
        ),
      ),
    );
  }
}

class CreateDesignPage extends StatefulWidget {
  final Designer designer;
  CreateDesignPage ({Key key, @required this.designer }): super(key: key);
  @override
  _CreateDesignPageState createState() => _CreateDesignPageState();
}

class _CreateDesignPageState extends State<CreateDesignPage> {
  File _image;
  final picker = ImagePicker();
  DesignRepository _designRepository = new DesignRepository();
  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  Future getCameraImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });

  }
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create New Design'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              setImageView(_image),
              SizedBox(height: 10),
              ListTile(
                title: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Description"
                  ),
                ),
              ),
              Padding(
                child: RaisedButton(
                  onPressed: (){
                    print(_designRepository.createDesign(_image,this.widget.designer,_descriptionController.text));
                    //DesignRepository().createDesign(_image);
                  },
                  child: Text("Create Design"),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.red,
        animatedIcon: AnimatedIcons.menu_arrow,
        closeManually: false,
        children: [
          SpeedDialChild(
              label: "Add photo from Camera",
              child: Icon(Icons.camera),
              onTap: getCameraImage
          ),
          SpeedDialChild(
              label: "Add photo from gallery",
              child: Icon(Icons.photo_album),
              onTap: getGalleryImage
          )
        ],
      ),
    );
  }
}
