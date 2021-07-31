import 'package:flutter/material.dart';
import 'package:flutter_pokedex/widgets/drawer.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final grey =  Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.blueGrey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Container(
            width: 65,
            height: 56,
            padding: EdgeInsets.all(8.0),
            child: IconButton(
            icon: Icon( Icons.menu),
            color: Colors.black87,
            iconSize: 32,
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              width: 42,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, blurRadius: 8.0,
                    offset: Offset(0.0, 0.0)
                  )
                ]
              ),
              child: Icon(Icons.navigation, size: 24, color: Color.fromRGBO(17, 139, 74, 1)),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, blurRadius: 8.0,
                  offset: Offset(0.0, 0.0)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.gps_fixed, color: Colors.grey[300],),
                Text("102 Fordham Rd"),
                Icon(Icons.cancel, color: Colors.grey[300],),
                Icon(Icons.settings_input_antenna, color: Colors.grey[300],),
              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundMap.png"),
                fit: BoxFit.cover,
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                // textAlign: TextAlign.justify,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "\$5", 
                                      style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                                    ),
                                    TextSpan(
                                      text: "/Hr", 
                                      style: TextStyle(color: grey, fontWeight: FontWeight.bold),
                                    ),
                                  ]
                                ),
                              ),
                              // Text("5/Hr"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: grey, size: 20,),
                                      Text("102 Fordham Rd"),
                                    ],
                                  ),
                                  Text("San Jose", style: TextStyle(color: grey)),
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          Text("Available spaces", style: TextStyle(color: grey)),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 170,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    color: Color.fromRGBO(40, 174, 96, 1),
                                    minHeight: 10,
                                    value: 0.35,
                                    // semanticsLabel: 'Linear progress indicator',
                                  ),
                                ),
                              ),
                              Text("4"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.nordic_walking, color: grey, size: 24,),
                                ),
                                Text("124 meters walk", style: TextStyle(color: grey))
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(40, 174, 96, 1),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    child: Center(
                      heightFactor: 3,
                      child: Text("GO"),
                    ),
                    onPressed: (){},
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}