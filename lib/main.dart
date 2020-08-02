import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sih2020/about.dart';
import 'package:sih2020/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Server Logs | Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Server Logs | Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int count;
    double grid1, grid2;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      count = 2;
      grid1 = 2.9;
      grid2 = 1.8;
    } else {
      count = 1;
      grid1 = 1.8;
      grid2 = 2.3;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.call_to_action),
              title: Text("Test API"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            Container(
                child: GridView.count(
              primary: false,
              crossAxisCount: 1,
              padding: const EdgeInsets.all(10.0),
              childAspectRatio: grid1,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              children: <Widget>[
                Container(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 30.0),
                      child: Text("Some text"),
                    ),
                  ),
                ),
              ],
              shrinkWrap: true,
            )),
            Container(
              height: 10,
            ),
            Container(
              child: GridView.count(
                primary: false,
                crossAxisCount: count,
                padding: const EdgeInsets.all(10.0),
                childAspectRatio: grid2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 5.0,
                children: List.generate(2, (index) {
                  return Container(
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 30.0),
                        child: Text("Some text"),
                      ),
                    ),
                  );
                }),
                shrinkWrap: true,
              ),
            ),
            Container(
              height: 30,
            ),
            Container(
              child: Center(
                child: Text(
                  "© permission_denied",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
