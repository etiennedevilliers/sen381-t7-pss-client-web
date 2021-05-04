import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'objects/Agent.dart';
import 'Models/LoggedInAgent.dart';

class AgentSelectPage extends StatefulWidget {
  @override
  _AgentSelectPageState createState() => _AgentSelectPageState();
}

class _AgentSelectPageState extends State<AgentSelectPage> {
  Future<List<Agent>> agentFuture = fetchAgents();

  Widget _buildAgentTile(Agent agent) {    
    return Card(
      child: ListTile(
        title: Text(agent.aName),
        subtitle: Text(agent.contactNum),
        trailing: Consumer<LoggedInAgentModel>(
          builder: (context, value, child) {
            return  ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                value.login(agent);
              },
            );
          },
        )  
      ),
    );
  }

  Widget _buildAgents() {
    return FutureBuilder<List<Agent>>(
      future: agentFuture,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          List<Agent> agents = snapshot.data;

          return ListView.builder(
            itemCount: agents.length,
            itemBuilder: (context, index) {
              Agent agent = agents[index];
              return _buildAgentTile(agent);
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with Agent"),),

      body: _buildAgents(),
    );
  }
}