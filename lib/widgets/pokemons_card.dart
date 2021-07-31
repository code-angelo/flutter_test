import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/providers/pokemon_provider.dart';

class PokemonCard extends StatelessWidget {
  final provider = new PokemonProvider();
  List<Result> lista;
  final pokemonProvider = new PokemonProvider();
  PokemonCard({required this.lista});

  Map<String, dynamic> color = {
    "black": Colors.black,
    "blue": Colors.blue,
    "brown": Colors.brown,
    "gray": Colors.grey,
    "green": Colors.green,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "red": Colors.red,
    "white": Colors.grey,
    "yellow": Colors.yellow
  };
  

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int i){
        Map<String, dynamic> details = {};        
        return Container(
          height: 150,
          child: MediaQuery.removePadding(
            context: context,
            removeRight: true,
            child: InkWell(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                elevation: 10.0,
                child: Stack(
                  children: <Widget>[
                    FutureBuilder(
                      future: provider.getPokemonColor("${lista[i].name}"),
                      builder: (context, snap){
                        if (snap.connectionState != ConnectionState.done) {
                          //print('project snapshot data is: ${snap.data}');
                          return Center(child: Text("Cargando..."));
                        } else {
                          if (snap.hasError) {
                            return Text("${[snap.error.toString()]}"); 
                          }
                          else {
                            if (snap.hasData) {
                              String jsoncol = "${snap.data}";
                              Color myColor = color[jsoncol];
                              return InkWell(
                                splashColor: myColor,
                                onTap: (){
                                  Navigator.pushNamed(context, 'details', arguments: details);
                                  // print("${lista[i].name}");
                                },
                                child: ListTile(
                                  title: Text("${lista[i].name[0].toUpperCase() + lista[i].name.substring(1)}", style: TextStyle(fontSize: 40, color: myColor, fontWeight: FontWeight.bold),),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.star, color: myColor, size: 16,),
                                      SizedBox(width: 5,),
                                      FutureBuilder(
                                        future: provider.getPokemonType("${lista[i].name}"),
                                        builder: (context, snaptype){
                                          if(snaptype.connectionState != ConnectionState.done){
                                            return Text("Cargando...");
                                          }else{
                                            if(snaptype.hasError){
                                              return Text("${[snaptype.error.toString()]}");
                                            }
                                            else{
                                              if(snaptype.hasData){
                                                String type = snaptype.data.toString();
                                                 details = {
                                                  "name" : "${lista[i].name[0].toUpperCase() + lista[i].name.substring(1)}",
                                                  "type" : "${type[0].toUpperCase()}${type.substring(1)}",
                                                  "color" : "$myColor",
                                                  "image" : "${lista[i].getImage(i+1)}"
                                                };
                                                return Text("${type[0].toUpperCase()}${type.substring(1)}", style: TextStyle(color: myColor, fontWeight: FontWeight.bold, fontSize: 16));
                                              } else{
                                                return Text("No hay información");
                                              }
                                            }
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Text("No hay información");
                            }
                          }
                        }
                      },
                    ),
                    Positioned(
                      width: 170,
                      right: 0.0, top: 0.0,
                      child: Image.network(
                        '${lista[i].getImage(i+1)}',
                        fit: BoxFit.fill,
                        // placeholder: 'assets/images/loading.gif', 
                      ),
                    ),
                  ],
                  
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}