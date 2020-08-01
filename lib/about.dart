import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team PermissionDenied'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/24989497?s=400&v=4")),
                    title: Text("Rajesh Tiwari"),
                    subtitle: Text("GitHub: RajeshTiwariji"),
                    trailing: Text("Mentor"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/53534532?s=400&v=4")),
                    title: Text("Kuldeep Sharma"),
                    subtitle: Text("GitHub: kuldeepsharma11"),
                    trailing: Text("Team Leader"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars2.githubusercontent.com/u/34422111?s=400&v=4")),
                    title: Text("Rubin Shah"),
                    subtitle: Text("GitHub: rubin1603"),
                    trailing: Text("Participant"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/45765206?s=400&u=7362416c790a307fee1dfb9d3ee1e52d7250a778&v=4")),
                    title: Text("Sahil Babani"),
                    subtitle: Text("GitHub: Sahilbabani"),
                    trailing: Text("Participant"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/46031396?s=400&u=642a7e91a5e13498fe04f07c3b99af584321ae07&v=4")),
                    title: Text("Abhiti Darbar"),
                    subtitle: Text("GitHub: abhitidarbar"),
                    trailing: Text("Participant"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars1.githubusercontent.com/u/37576387?s=400&u=45564d232740698050e4afc2e004fadcfe3a4759&v=4")),
                    title: Text("Hariom Verma"),
                    subtitle: Text("GitHub: harry-hov"),
                    trailing: Text("Participant"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/42097982?s=400&u=c380477dad857a4b4a3ee6c940375b30645bfff0&v=4")),
                    title: Text("Uday Mewada"),
                    subtitle: Text("GitHub: udaymewada"),
                    trailing: Text("Participant"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
