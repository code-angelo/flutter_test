// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';


Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
    Pokemon({
        this.count = 0,
        this.next = "",
        this.previous,
        required this.results
    });

    int count;
    String next;
    dynamic previous;
    List<Result> results;

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson()))
    };
}

class Result {
    Result({
        this.color = "",
        this.name = "",
        this.url = ""
    });

    String color;
    String name;
    String url;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        // color: json["color"],
        name: json["name"],
        url: json["url"]
    );

    Map<String, dynamic> toJson() => {
        "color": color,
        "name": name,
        "url": url
    };

    String getImage(int i){
      String urlImage = "";
      if(i == 0){
        urlImage = "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg";
      }else{
        urlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$i.png";
      }
      return urlImage;
    }
}


// Pokemons Details
// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);


Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
    Details({
        required this.abilities,
        this.height = 0,
        this.id = 0,
        this.name = "",
        required this.stats,
        this.weight = 0,
    });

    List<AbilityElement> abilities;
    int height;
    int id;
    String name;
    List<Stat> stats;
    int weight;

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        abilities: List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromJson(x))),
        height: json["height"],
        id: json["id"],
        name: json["name"],
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "height": height,
        "id": id,
        "name": name,
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "weight": weight,
    };
}

class AbilityElement {
    AbilityElement({
        required this.ability,
    });

    StatClass ability;

    factory AbilityElement.fromJson(Map<String, dynamic> json) => AbilityElement(
        ability: StatClass.fromJson(json["ability"]),
    );

    Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
    };
}

class StatClass {
    StatClass({
        this.name ="",
        this.url ="",
    });

    String name;
    String url;

    factory StatClass.fromJson(Map<String, dynamic> json) => StatClass(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class Stat {
    Stat({
        this.baseStat = 0,
        this.effort = 0,
        required this.stat,
    });

    int baseStat;
    int effort;
    StatClass stat;

    factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: StatClass.fromJson(json["stat"]),
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
    };
}

