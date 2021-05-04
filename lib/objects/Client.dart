import 'dart:convert';

import 'package:http/http.dart' as http;

class Client {
  final int clientID;
  final String contactNum;
  final String bName;
  final String iName;
  final String iSurname;

  Client({this.clientID, this.contactNum, this.bName, this.iName, this.iSurname});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientID: json["ClientID"],
      contactNum: json["contactNum"],
      bName: json["bName"],
      iName: json["iName"],
      iSurname: json["iSurname"]
    );
  }
}

Future<Client> fetchClient(int clientID) async {
  Map<String, dynamic> queryParameters = {
    "clientID" : clientID.toString()
  };
  final response = await http.get(Uri.http(
    'ludere.co.za:3000', 
    'Client',
    queryParameters
  ));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = jsonDecode(response.body);

    return Client.fromJson(mapResponse['recordset'][0]);
  } else {
    throw Exception('Failed to load Client');
  }
}