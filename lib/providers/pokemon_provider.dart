import 'dart:convert';

import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonProvider {

  String _url = "https://pokeapi.co/api/v2/pokemon";
  String urlColor = "https://pokeapi.co/api/v2/pokemon-species/";
  String urlType = "https://pokeapi.co/api/v2/pokemon/";
  String urlPokemonDetails = "https://pokeapi.co/api/v2/pokemon/";

   Future<List<Result>> getPokemons() async{
     List<Result>pokemons = [];
    
     final resp = await http.get(Uri.parse("$_url"));
     final decodedData = json.decode(resp.body);
      // decodedData mapa
     final pokemon = new Pokemon.fromJson(decodedData);
     pokemons = pokemon.results;

     return pokemons;
   }

   Future <String> getPokemonColor(String name) async {

     final respType = await http.get(Uri.parse("${urlColor+name}"));
     final decodedData = json.decode(respType.body);

     final color =  decodedData["color"]["name"];
     return color;
   }

   Future <String> getPokemonType(String name) async {

     final respType = await http.get(Uri.parse("${urlType+name}"));
     final decodedData = json.decode(respType.body);

     String type =  decodedData["types"][0]["type"]["name"];
     return type;
   }


   Future <Details> getDetails(String name) async {
     Details details;
     final respType = await http.get(Uri.parse("${urlPokemonDetails+name.toLowerCase()}"));
     final decodedData = json.decode(respType.body);

     final pokemonDetail = Details.fromJson(decodedData);
     details = pokemonDetail;
    //  print(details.abilities[0].ability.name);
      return details;
   }




}