import 'package:flutter/foundation.dart';
import 'package:sen381flutterweb/objects/Agent.dart';

class LoggedInAgentModel extends ChangeNotifier {
  /// Internal, private state of the model.
  Agent _selectedAgent;
  bool loggedIn = false;

  void login(Agent agent) {
    this._selectedAgent = agent;
    loggedIn = true;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
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