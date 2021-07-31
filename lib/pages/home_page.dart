import 'package:flutter/material.dart';
import 'package:flutter_pokedex/providers/pokemon_provider.dart';
import 'package:flutter_pokedex/widgets/drawer.dart';
import 'package:flutter_pokedex/widgets/pokemons_card.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final pokemonProvider = new PokemonProvider();
    pokemonProvider.getPokemonType("pikachu");

    
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("CHOOSE A POKEMON", style: TextStyle(color: Color.fromRGBO(170, 174, 180, 1), fontWeight: FontWeight.bold),),
          ),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(170, 174, 180, 1), //change your color here
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
        ),
        drawer: MyDrawer(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0 ),
          child: FutureBuilder(
        
            future: pokemonProvider.getPokemons(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return PokemonCard(lista: snapshot.data,);
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

