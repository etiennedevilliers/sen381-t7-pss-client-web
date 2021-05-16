import 'package:flutter/foundation.dart';
import 'package:sen381flutterweb/objects/Agent.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../objects/Agent.dart';

class LoggedInAgentModel extends ChangeNotifier {
  /// Internal, private state of the model.
  Agent _selectedAgent;
  int agentID = null;
  bool loggedIn = false;

  Future<bool> login(String username, String password) async {
    Map<String, String> headers = {
      'username': '${username}',
      'password': '${password}',
    };
    Uri uri = Uri.http(
      'ludere.co.za:3000',
      'CheckCredentials',
    );
    print(uri);
    print(headers);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> mapResponse = jsonDecode(response.body);

      if (mapResponse['auth'] == true) {
        loggedIn = true;
        agentID = mapResponse['AgentID'];
        _selectedAgent = await fetchAgent(agentID);
        notifyListeners();
      } else {
        loggedIn = false;
        agentID = null;
        _selectedAgent = null;
      }
    } else {
      throw Exception('Failed log call');
    }
    return loggedIn;
  }

  void logout() {
    this._selectedAgent = null;
    loggedIn = false;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  Agent getAgent() {
    return _selectedAgent;
  }
}
