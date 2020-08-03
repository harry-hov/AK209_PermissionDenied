import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Log> fetchLog() async {
  final response = await http.get(
    'https://ba57531582e6.ngrok.io/dummydata',
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Log.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Log');
  }
}

class Log {
  final String component;
  final String level;
  final String pid;

  Log({this.component, this.level, this.pid});

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      component: json['Component'],
      level: json['Level'],
      pid: json['Pid'],
    );
  }
}

class TestTest extends StatefulWidget {
  TestTest({Key key}) : super(key: key);

  @override
  _TestTestState createState() => _TestTestState();
}

class _TestTestState extends State<TestTest> {
  Future<Log> futureLog;

  @override
  void initState() {
    super.initState();
    futureLog = fetchLog();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Log>(
            future: futureLog,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.pid.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
