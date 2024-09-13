import 'dart:convert';

import 'package:api_practice/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //we need to intilize list because the name of thr array is not defined in the API 
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostAPI() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      //here we are taking two values string, dynamic it means that key is always in strimg while value can be of any type
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostAPI(),
                builder: (context, snapshot) {
                  //If the data hasn't arrived yet, it shows a simple Text widget saying "Loading." This informs the user that the app is fetching the data.
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
              //ListView.builder is used to display a scrollable list of items dynamically. In this case, the list will show the posts fetched from the API.
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title\n'+postList[index].title.toString()),
                                SizedBox(height: 20,),
                                Text('Description\n'+postList[index].title.toString())

                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
