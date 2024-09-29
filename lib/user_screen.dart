import 'dart:convert';

import 'package:api_practice/Models/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
List<UserModal> usersList = [];
Future<List<UserModal>> GetUserAPI() async{
final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
var data = jsonDecode(response.body.toString());

if (response.statusCode == 200) {
for (Map<String , dynamic> i in data) {
usersList.add(UserModal.fromJson(i));
}

  return usersList;
}else{
  return usersList;
}


}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          "API Practice",
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
      ),
      body: Column(children: [
        
      ],),
    );
  }
}