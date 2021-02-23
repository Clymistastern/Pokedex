import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  Map data;

  SecondPage(this.data);

  _SecondState createState() => _SecondState();
}

class _SecondState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    ferchdata2();
  }

  Map post;
  bool isLoad = true;

  ferchdata2() async {
    setState(() {
      isLoad = true;
    });
    var url = widget.data["url"];
    final response = await http.get(url);
    if (response.statusCode == 200) {
      post = json.decode(response.body.toString());
      setState(() {
        isLoad = false;
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pokedetail(context),
    );
  }

  Widget pokedetail(BuildContext context) {
    if (isLoad) return Center(child: CircularProgressIndicator());
    return Container(
      padding: EdgeInsets.all(1.1),
      child: Container(
        decoration: BoxDecoration(color: Colors.black87),
         child:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          Image.network( post['sprites']['other']['official-artwork']['front_default'],width: 500.0,height: 500.0,scale: 0.1,),
          Text(post['name'].toString().toUpperCase(),style: TextStyle(color: Colors.white),),
          Text("Base Experience :",style: TextStyle(color: Colors.white)),
          Text(post['base_experience'].toString(),style: TextStyle(color: Colors.white)),
          Text("Weight :",style: TextStyle(color: Colors.white)),
          Text(post['weight'].toString(),style: TextStyle(color: Colors.white)),
          Text("Height :",style: TextStyle(color: Colors.white)),
          Text(post['height'].toString(),style: TextStyle(color: Colors.white)),
        ],
       ),
        ),
    );
  }
}