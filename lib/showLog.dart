import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:sih2020/about.dart';

class ShowLog extends StatefulWidget {
  ShowLog({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShowLogState createState() => new _ShowLogState();
}

class _ShowLogState extends State<ShowLog> {
  Future<List<dynamic>> _future;
  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
        _future = fetchUsers();
      });
    });
  }

  final String apiUrl = 'https://ba57531582e6.ngrok.io/dummydata';
  //final String apiUrl = "https://api.jsonbin.io/b/5f2695fedddf413f95bac0a3/1";

  Future<List<dynamic>> fetchUsers() async {
    var log = await http.get(apiUrl);
    if (log.statusCode == 200) {
      return json.decode(log.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  String _component(dynamic log) {
    return log['Component'];
  }

  String _status(dynamic log) {
    return log['Status'].toString();
  }

  String _server(dynamic log) {
    return log['Server'].toString();
  }

  String _pid(Map<String, dynamic> log) {
    return "PID: " + log['Pid'].toString();
  }

  String _content(dynamic log) {
    return log['Content'].toString();
  }

  String _level(dynamic log) {
    return log['Level'].toString();
  }

  String _dateandtime(dynamic log) {
    String date = "Date and Time: " +
        log['Date'].toString() +
        " " +
        log['Time'].toString();
    return date;
  }

  String _eventId(dynamic log) {
    return log['EventId'].toString();
  }

  String _eventTemplate(dynamic log) {
    return log['EventTemplate'].toString();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    Color status_color;
    String server_icon_path, err = '';

    final headerList = new Expanded(
        child: FutureBuilder<List<dynamic>>(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(_pid(snapshot.data[0]));
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (_status(snapshot.data[index]) == "Anomaly")
                      status_color = Colors.red;
                    else
                      status_color = Colors.green;

                    EdgeInsets padding = index == 0
                        ? const EdgeInsets.only(
                            left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
                        : const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

                    return new Padding(
                      padding: padding,
                      child: new InkWell(
                        child: new Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: status_color,
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.black.withAlpha(70),
                                  offset: const Offset(3.0, 10.0),
                                  blurRadius: 15.0)
                            ],
                          ),
                          //height: 20.0,
                          width: 10.0,
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    final body = new Scaffold(
      appBar: new AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          child: Image.asset(
            "assets/images/bemlicon.png",
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
              })
        ],
        title: new Text(
          widget.title,
          style: new TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Padding(
                        padding: new EdgeInsets.only(left: 22.0, bottom: 10.0),
                        child: new Text(
                          'Current Status',
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  new Container(height: 70.0, width: _width, child: headerList),
                  new Expanded(
                      child: FutureBuilder<List<dynamic>>(
                          future: _future,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(_pid(snapshot.data[0]));
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    if (_status(snapshot.data[index]) ==
                                        "Anomaly") {
                                      server_icon_path =
                                          'assets/images/server-icon-red.png';
                                      status_color = Colors.red;
                                      err = '(fatal: needs attention !!!)';
                                    } else {
                                      server_icon_path =
                                          'assets/images/server-icon-green.png';
                                      status_color = Colors.green;
                                      err = '';
                                    }
                                    return new ListTile(
                                      title: new Column(
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 0.0),
                                                height: 32.0,
                                                width: 52.0,
                                                decoration: new BoxDecoration(
                                                    color: Colors.transparent,
                                                    boxShadow: [
                                                      new BoxShadow(
                                                          color: Colors.black
                                                              .withAlpha(00),
                                                          offset: const Offset(
                                                              2.0, 2.0),
                                                          blurRadius: 2.0)
                                                    ],
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                12.0)),
                                                    image: new DecorationImage(
                                                      image:
                                                          new ExactAssetImage(
                                                        server_icon_path,
                                                      ),
                                                      fit: BoxFit.scaleDown,
                                                    )),
                                              ),
                                              new SizedBox(
                                                width: 8.0,
                                              ),
                                              new Expanded(
                                                  child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    _component(
                                                        snapshot.data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  new Text(
                                                    _content(
                                                        snapshot.data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    "Status: " +
                                                        _status(snapshot
                                                            .data[index]) +
                                                        '  ' +
                                                        err,
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: status_color,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    "Server: " +
                                                        _server(snapshot
                                                            .data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color:
                                                            Colors.blueAccent,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    _pid(snapshot.data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    "Level: " +
                                                        _level(snapshot
                                                            .data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    _dateandtime(
                                                        snapshot.data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    "Event Id: " +
                                                        _eventId(snapshot
                                                            .data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  new Text(
                                                    "Event Template: " +
                                                        _eventTemplate(snapshot
                                                            .data[index]),
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                          new Divider(),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return new Container(
      decoration: new BoxDecoration(
        color: Colors.grey[100],
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
          ),
          body,
        ],
      ),
    );
  }
}
