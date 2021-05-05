import 'package:flutter/foundation.dart';
import 'package:sen381flutterweb/objects/ComplaintRequest.dart';

class ComplaintRequestsModel extends ChangeNotifier {
  /// Internal, private state of the model.
  List<ComplaintRequest> complaintRequests = [];



  Future<void> load () async {
    complaintRequests =  await fetchComplaintRequests();
    notifyListeners();
  }

  List<ComplaintRequest> getOpenComplaints() {
    List<ComplaintRequest> openRequests = [];

    for (ComplaintRequest req in complaintRequests) {
      if (req.status == 'Open') {
        openRequests.add(req);
      }
    }

    return openRequests;
  }

  List<ComplaintRequest> getClosedComplaints() {
    List<ComplaintRequest> closedRequests = [];

    for (ComplaintRequest req in complaintRequests) {
      if (req.status != 'Open') {
        closedRequests.add(req);
      }
    }

    return closedRequests;
  }

  void refresh() {
    notifyListeners();
  }
}