import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/LoggedInAgent.dart';
import 'objects/Agent.dart';
import 'Models/LoggedInAgent.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String text = "";

  Widget _buildUsername() {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'username'
      ),
    );
  }

  Widget _buildPassword() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'password'
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      width: 400,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),
            Text("Enter User Credentials"),
            Container(height: 10,),
            _buildUsername(),
            _buildPassword(),
            Text(text, style: TextStyle(color: Colors.red),),
            Container(height: 10,),
            Row(
              children: [
                Expanded(child: Container()),
                Consumer<LoggedInAgentModel>(
                  builder: (context, value, child) {

                    return MaterialButton(
                      onPressed: () {
                        value.login(
                          usernameController.text, 
                          passwordController.text
                        ).then((bool value) {
                          if (!value) {
                            setState(() {
                              text = "Incorrect username & password combination";
                            });
                          }
                        });
                      },
                      child: Text("Login"),
                    );
                  },
                ),
              ],
            ),
            Expanded(child: Container())
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with Agent"),),

      body: Row(
        children: [
          Expanded(child: Container()),
          _buildLogin(),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}