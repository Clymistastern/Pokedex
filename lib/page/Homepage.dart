import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pokedetail.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url = 'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0';
  List data;

   @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    var response = await http.get(url);
    var decjson = json.decode(response.body);
    setState(() {
      data = decjson["results"];
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedexs'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black54),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  contentPadding: const EdgeInsets.all(10.0),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, i) {
                    return Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: ListTile(
                      title: Image.network('https://raw.githubusercontent.com/pokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(i + 1)}.png', width: 300.0, height: 300.0,scale: 0.1,),
                      subtitle:  Text(data[i]["name"].toString().toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold) ,
                      textAlign: TextAlign.center,),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (BuildContext context) => SecondPage(data[i])));
                      },
                    ),
                    );
                  })
              )],
            ) 
        )
    );
  }
}

