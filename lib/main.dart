import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_pokedex/pages/calendar_page.dart';
import 'package:flutter_pokedex/pages/mapa_page.dart';
import 'package:flutter_pokedex/pages/home_page.dart';
import 'package:flutter_pokedex/pages/pokemon_detail_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
    );
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nunito',
        textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
      ),
    ),
      title: 'Flutter test',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        'details': (context) => PokemonDetailPage(),
        'mapa': (context) => MapaPage(),
        'calendar': (context) => CalendarPage(),
      },
    );
  }
}