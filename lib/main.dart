import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sen381flutterweb/Models/ComplaintRequests.dart';
import 'complaintRequestForm.dart';
import 'login.dart';
import 'objects/ComplaintRequest.dart';
import 'Models/LoggedInAgent.dart';
void main() {
  ComplaintRequestsModel complaintRequestsModel = ComplaintRequestsModel();
  complaintRequestsModel.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoggedInAgentModel()),
        ChangeNotifierProvider(create: (context) => complaintRequestsModel),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  Widget _buildPage() {
    return Consumer<LoggedInAgentModel>(
      builder: (context, value, child) {
        if (value.loggedIn) {
          return ComplaintRequestPage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildPage(),
    );
  }
}

