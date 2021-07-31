import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/providers/pokemon_provider.dart';

class PokemonDetailPage extends StatelessWidget {

    
  @override
  Widget build(BuildContext context) {

    // Map<String, dynamic> color = {
    //   "black": Color(0xfff44336),
    //   "blue": Colors.blue,
    //   "brown": Colors.brown,
    //   "gray": Colors.grey,
    //   "green": Colors.green,
    //   "pink": Colors.pink,
    //   "purple": Colors.purple,
    //   "red": Colors.red,
    //   "white": Colors.grey,
    //   "yellow": Colors.yellow
    // };
    final provider = PokemonProvider();
    Map<String, dynamic> aragumentos = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String name = aragumentos["name"];
    String type = aragumentos["type"];
    String image = aragumentos["image"];
    var color = aragumentos["color"];
    //split string
      var col = color.split('(');
      var codeExa = col[2].split(')');
    Color pokemonColor = Color(int.parse("${codeExa[0]}"));
    print(name);


    return Scaffold(
      backgroundColor: pokemonColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.only(top: 30),
                // color: Colors.redAccent,
                // height: 200,
                width: 350,
                child: FutureBuilder(
                  future: provider.getDetails(name),
                  builder: (context, AsyncSnapshot<Details> snapshot){
                    if(snapshot.connectionState != ConnectionState.done){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      if(snapshot.hasError){
                          return Container();
                      }
                      else{
                        if(snapshot.hasData){
                          final details = snapshot.data as Details;
                        // print(snapshot.data);
                        return buildCard(name, pokemonColor, type, image, details);
                        } else{
                          return Text("No hay información");
                        }
                      }
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(50),
                child: Image(image: AssetImage("assets/images/poke.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
            ],  
          ),
        ),
      ),
    );
  }

  Stack buildCard(String name, Color pokemonColor, String type, String image, Details details) {
    double hp = details.stats[0].baseStat.toDouble();
    print((hp*0.01));
    double attack = details.stats[1].baseStat.toDouble();
    double defense = details.stats[2].baseStat.toDouble();
    double specialAttack = details.stats[3].baseStat.toDouble();
    double specialDefense = details.stats[4].baseStat.toDouble();
    double speed = details.stats[5].baseStat.toDouble();
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.only(top: 80),
          elevation: 15,
          child: Column(
            children: [
              ListTile(
                title: Text("$name", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                subtitle: Row(
                  children: [
                    Icon (Icons.star, color: pokemonColor,size: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("$type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red[100],
                      height: 50,
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text("Height", style: TextStyle(color: pokemonColor, fontWeight: FontWeight.bold),),
                          ),
                          Text("${details.height}", style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.red[100],
                      height: 50,
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text("Weight", style: TextStyle(color: pokemonColor, fontWeight: FontWeight.bold),),
                          ),
                          Text("${details.weight}"+"lbs", style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.red[100],
                      height: 50,
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text("Category", style: TextStyle(color: pokemonColor, fontWeight: FontWeight.bold),),
                          ),
                          Text("Unknown", style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.red[100],
                      height: 50,
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text("Abilities,", style: TextStyle(color: pokemonColor, fontWeight: FontWeight.bold),),
                          ),
                          Text("${details.abilities[0].ability.name}", style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  "En la opción del menu numero dos se tiene que implementar un calendario customizable en"
                  +"donde se puedan visualizar los días test en color verde los holiday en rojo y event en amarillo",
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                // color: Colors.red[100],
                height: 130,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: pokemonColor,
                      height: 130 * (hp*0.01),
                      width: 38,
                    ),
                    Container(
                      color: pokemonColor,
                      height: 130 * (attack*0.01),
                      width: 38,
                    ),
                    Container(
                      color: pokemonColor,
                      height: 130 * (defense*0.01),
                      width: 38,
                    ),
                    Container(
                      color: pokemonColor,
                      height: 130 * (specialAttack*0.01),
                      width: 38,
                    ),
                    Container(
                      color: pokemonColor,
                      height: 130 * (specialDefense*0.01),
                      width: 38,
                    ),
                    Container(
                      color: pokemonColor,
                      height: 130 * (speed*0.01),
                      width: 38,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                // color: Colors.red[100],
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 50, child: Text("HP", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                    Container(width: 50, child: Text("Attack", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                    Container(width: 50, child: Text("Defense", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                    Container(width: 50, child: Text("Special\nAtack", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                    Container(width: 50, child: Text("Special\nDefense", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                    Container(width: 50, child: Text("Speed", textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: 170,
          right: 0.0, top: 0.0,
          child: Image.network('$image',
            fit: BoxFit.fill,
            // placeholder: 'assets/images/loading.gif', 
          ),
        ),
      ],
    );
  }
}