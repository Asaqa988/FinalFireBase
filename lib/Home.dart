import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart ' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List BreakingBadList = [];

class _HomeState extends State<Home> {
  String baseUrl = "https://jsonplaceholder.typicode.com/users";
  void get() async {
    Uri myurl = Uri.parse("$baseUrl");
    http.Response myresponse = await http.get(myurl);
    List MyData = jsonDecode(myresponse.body);

    BreakingBadList.addAll(MyData);
    // int ID = MyData[0]["char_id"];
    // print("this is the ID $ID");
    // String Name = MyData[0]["name"];
    // print("this is the name $Name");
    // String Image = MyData[0]["img"];
    // print("this is the image $Image");
    // String NickName = MyData[0]["nickname"];
    // print("this is the nickname $NickName");
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (context, i) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Image.network("${BreakingBadList[i]["img"]}"),
                  Text("${BreakingBadList[i]["id"]}"),
                  Text("${BreakingBadList[i]["username"]}"),
                  Text("${BreakingBadList[i]["email"]}"),
                ],
              ),
            );
          },
          itemCount: BreakingBadList.length,
        ));
  }
}
