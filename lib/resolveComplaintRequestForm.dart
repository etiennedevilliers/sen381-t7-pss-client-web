import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sen381flutterweb/Models/ComplaintRequests.dart';
import 'package:sen381flutterweb/objects/ComplaintRequest.dart';

import 'Models/LoggedInAgent.dart';
import 'objects/Agent.dart';
import 'objects/CallLog.dart';
import 'objects/Client.dart';


class ResolveComplaintRequestForm extends StatefulWidget {
  final ComplaintRequest complaintRequest;

  const ResolveComplaintRequestForm({Key key, this.complaintRequest}) : super(key: key);

  @override
  _ResolveComplaintRequestFormState createState() => _ResolveComplaintRequestFormState();
}

class _ResolveComplaintRequestFormState extends State<ResolveComplaintRequestForm> {
  bool onCall = false;
  DateTime callStartTime;

  Widget _buildBody(ComplaintRequest request) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<Client>(
            builder: (context, value, child) {
              String contactNum = (value != null) ? value.contactNum : "Loading...";
              

              return Card(
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      Text("Client contact number: ${contactNum}"),
                      Text("Date Created: ${request.dateCreated}"),
                      Text("Status: ${request.status}"),
                      Container(height: 10,),
                      Text("${request.description}"),
                      Container(height: 30,),
                        Center(
                        child: _buildButtons(request)
                      ),
                    ]
                  ),
                ),
              );
            },
          ),
          Expanded(child: Container()),
          
          
        ],
      );
  }

  Widget _buildButtons(ComplaintRequest request) {
    if (onCall) {
      return Consumer<LoggedInAgentModel>(
        builder: (context, value, child) {
          Agent agent = value.getAgent();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("End call"),
                onPressed: () {
                  endCall(agent.agentID ,callStartTime, DateTime.now());
                  setState(() {
                    onCall = false;
                  });
                },
              ),
              Container(
                width: 10,
              ),
              Consumer<ComplaintRequestsModel>(
                builder: (context, complaintRequestsModel, child) {
                  return ElevatedButton(
                    child: Text("End call & Resolve Complaint"),
                    onPressed: () {
                      DateTime resolved = DateTime.now();
                      endCall(agent.agentID, callStartTime, resolved);
                      resolveComplaintRequest(request.complaintRequestID, agent.agentID, resolved);
                      request.status = "Closed";
                      request.dateResolved = resolved.toString();
                      complaintRequestsModel.refresh();
                      setState(() {
                        onCall = false;
                        Navigator.pop(context);
                      });
                    },
                  );
                },
              )
            ],
          );
        },
      );
    } else {
      return ElevatedButton(
        child: Text("Call client"),
        onPressed: () {
          setState(() {
            callStartTime = DateTime.now();
            onCall = true;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ComplaintRequest request = widget.complaintRequest;

    return FutureProvider<Client>(
      initialData: null,
      create: (BuildContext) {
        return fetchClient(request.clientID);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<Client>(
            builder: (context, value, child) {
              if (value != null) {
                if (value.bName != null) {
                  return Text("Business Client: ${value.bName}");
                } else {
                  return Text("Individual Client: ${value.iName} ${value.iSurname}");
                }
              } else {
                return Text("Loading client info...");
              }
            },
          ),
        ),
        body: _buildBody(request),
      ),
    );

  }
}