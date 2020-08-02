import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowLog extends StatefulWidget {
  ShowLog({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ShowLogState createState() => _ShowLogState();
}

class _ShowLogState extends State<ShowLog> {
  final String apiUrl = "https://api.jsonbin.io/b/5f2695fedddf413f95bac0a3";

  Future<List<dynamic>> fetchUsers() async {
    var log = await http.get(apiUrl);
    return json.decode(log.body)['logs'];
  }

  String _component(dynamic log) {
    return log['Component'];
  }

  String _status(dynamic log) {
    return log['status'].toString();
  }

  String _pid(Map<dynamic, dynamic> log) {
    return "PID: " + log['Pid'].toString();
  }

  @override
  Widget build(BuildContext context) {
    Color cl;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(_pid(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_status(snapshot.data[index]) == "Anomaly")
                      cl = Colors.red;
                    else
                      cl = Colors.green;
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: 10,
                              backgroundColor: cl,
                            ),
                            title: Text(_component(snapshot.data[index])),
                            subtitle: Text(
                                "Status: " + _status(snapshot.data[index])),
                            trailing: Text(_pid(snapshot.data[index])),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
