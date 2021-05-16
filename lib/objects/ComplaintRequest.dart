import 'dart:convert';
import 'package:http/http.dart' as http;

class ComplaintRequest {
  final int complaintRequestID;
  final String description;
  final int clientID;
  final String contactNum;
  final String dateCreated;
  String dateResolved;
  String status;
  final int callID;

  ComplaintRequest(
      {this.complaintRequestID,
      this.description,
      this.clientID,
      this.contactNum,
      this.dateCreated,
      this.dateResolved,
      this.status,
      this.callID});

  factory ComplaintRequest.fromJson(Map<String, dynamic> json) {
    return ComplaintRequest(
        complaintRequestID: json["ComplaintRequestID"],
        description: json["description"],
        clientID: json["ClientID"],
        contactNum: json["contactNum"],
        dateCreated: json["dateCreated"],
        dateResolved: json["dateResolved"],
        status: json["status"],
        callID: json["CallID"]);
  }
}

Future<List<ComplaintRequest>> fetchComplaintRequests() async {
  final response =
      await http.get(Uri.http('ludere.co.za:3000', 'ComplaintRequests'));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = jsonDecode(response.body);
    List<ComplaintRequest> complaintRequests = [];

    print(mapResponse);

    for (Map<String, dynamic> item in mapResponse["recordset"]) {
      complaintRequests.add(ComplaintRequest.fromJson(item));
    }

    return complaintRequests;
  } else {
    throw Exception('Failed to load ComplaintRequests');
  }
}

Future<void> resolveComplaintRequest(
    int complaintRequestID, int agentID, DateTime end) async {
  Map<String, dynamic> queryParameters = {
    'ComplaintRequestID': '${complaintRequestID}',
    'AgentID': '${agentID}',
    'DateTimeResolved': '${end}'
  };
  final response = await http.post(Uri.http(
      'ludere.co.za:3000', 'ResolveComplaintRequest', queryParameters));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = jsonDecode(response.body);
    print(mapResponse.toString());
  } else {
    throw Exception('Failed resolve');
  }
}
