import 'dart:convert';
import 'package:http/http.dart' as http;

class Agent {
  final int agentID;
  final String aName;
  final String contactNum;
  final String employmentStatus;
  final String employeeType;

  Agent({
    this.agentID, 
    this.aName,
    this.contactNum,
    this.employmentStatus,
    this.employeeType
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      agentID: json['AgentID'],
      aName: json['aName'],
      contactNum: json['contactNum'],
      employmentStatus: json['employmentStatus'],
      employeeType: json['employeeType']
    );
  }
}

Future<List<Agent>> fetchAgents() async {
  final response = await http.get(Uri.http('ludere.co.za:3000', 'CallCentreAgents'));

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = jsonDecode(response.body);
    List<Agent> agents = [];

    print(mapResponse);
    
    for (Map<String, dynamic> item in mapResponse["recordset"]) {
      agents.add(Agent.fromJson(item));
    }

    return agents;
  } else {
    throw Exception('Failed to load ComplaintRequests');
  }
}