import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> endCall(int agentID, DateTime start, DateTime end) async {
  Map<String, dynamic> queryParameters = {
    'DateTimeCallStarted': '${start}',
    'DateTimeCallEnded': '${end}',
    'AgentID': '${agentID}'
  };
  final response = await http
      .post(Uri.http('ludere.co.za:3000', 'InsertCallLog', queryParameters));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = jsonDecode(response.body);
    print(mapResponse.toString());
  } else {
    throw Exception('Failed log call');
  }
}
