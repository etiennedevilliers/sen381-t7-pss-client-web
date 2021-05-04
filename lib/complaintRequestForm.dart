import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sen381flutterweb/resolveComplaintRequestForm.dart';

import 'Models/ComplaintRequests.dart';
import 'Models/LoggedInAgent.dart';
import 'objects/Client.dart';
import 'objects/ComplaintRequest.dart';

class ComplaintRequestPage extends StatefulWidget {
  @override
  _ComplaintRequestPageState createState() => _ComplaintRequestPageState();
}

class _ComplaintRequestPageState extends State<ComplaintRequestPage> {
  Widget _buildComplaintRequestCard(ComplaintRequest complaintRequest) {
    return Card(
          child:ListTile(
            onTap: complaintRequest.status == "Open" ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResolveComplaintRequestForm(complaintRequest: complaintRequest,);
                  },
                )
              );
            } : null,
            leading: Text(complaintRequest.callID.toString()),
            title: Text(complaintRequest.description),
            subtitle: Text(complaintRequest.dateCreated),
            trailing: Text(complaintRequest.status),
          )
        );
  }


  Widget _buildComplaintRequests() {
    return Consumer<ComplaintRequestsModel>(
      builder: (context, complaintRequestModel, child) {
        List<ComplaintRequest> complaintRequests = complaintRequestModel.complaintRequests;
        return ListView.builder(
          itemCount: complaintRequests.length,
          itemBuilder: (context, i) {
            return _buildComplaintRequestCard(complaintRequests[i]);
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Requests"),
        actions: <Widget>[
          Consumer<LoggedInAgentModel>(
            builder: (context, value, child) {
              return MaterialButton(
                child: Text("Logout"),
                onPressed: () {
                  value.logout();
                }
              );
            },
          )
        ],
      ),
      body: _buildComplaintRequests(),
    );
  }
}