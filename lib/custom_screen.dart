import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  List<Photos> PhotosList = [];
  Future<List<Photos>> getPhotosAPI() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id'],);
        PhotosList.add(photos);
      }
      return PhotosList;
    } else {
      return PhotosList;
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
                  future: getPhotosAPI(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                    return ListView.builder(
                        itemCount: PhotosList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString()),
                            ),
                            subtitle: Text('Notes id:'+snapshot.data![index].id.toString()) ,
                            title: Text(snapshot.data![index].title.toString()),
                          );
                        });
                  }),
            )
          ],
        ));
  }
}

class Photos {
  String title, url;
 int id;
  Photos({required this.title, required this.url,required this.id});
}
