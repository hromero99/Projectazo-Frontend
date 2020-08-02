import 'package:flutter/material.dart';
import 'package:projectazo/networking/api.dart';
import 'package:projectazo/ui/designList.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormkey = GlobalKey();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  Api _api = Api();

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //AnimatedLogo(animation: animation),
          ],
        ),
        Container(
          width: 300.0, //size.width * .6,
          child: Form(
            key: _loginFormkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: usernameController,
                  validator: (text) {
                    if (text.length == 0) {
                      return "Why username is empty? You bitch";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Insert username',
                    labelText: 'Username',
                    counterText: '',
                    icon:
                    Icon(Icons.email, size: 32.0, color: Colors.blue[800]),
                  ),
                  //onSaved: (text) => _correo = text,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (text) {
                    if (text.length == 0) {
                      return "Why password is empty? You bitch";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Insert password',
                    labelText: 'Password',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_loginFormkey.currentState.validate()) {
                        _api.login(
                          usernameController.text,
                          passwordController.text
                        ).then((responseCode){
                          if (responseCode == 200){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DesignListPage(),
                              ),
                            );
                          }
                          else{
                            print("Not loged");
                          }
                        });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loginForm()
    );
  }

}


