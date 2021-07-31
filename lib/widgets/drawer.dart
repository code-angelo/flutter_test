import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Angel Rosillo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, '/');
            },
            leading: Icon(Icons.pets),
            title: Text('Pokemon'),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, 'calendar');
            },
            leading: Icon(Icons.calendar_today),
            title: Text('Calendario'),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, 'mapa');
            },
            leading: Icon(Icons.map),
            title: Text('UI Mapa'),
          ),
        ],
      ),
    );
  }
}