import 'package:flutter/foundation.dart';
import 'package:sen381flutterweb/objects/ComplaintRequest.dart';

class ComplaintRequestsModel extends ChangeNotifier {
  /// Internal, private state of the model.
  List<ComplaintRequest> complaintRequests = [];



  Future<void> load () async {
    complaintRequests =  await fetchComplaintRequests();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}