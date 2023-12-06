import 'package:flutter/material.dart';
import 'package:neurogine_app/models/game_model.dart';

class DetailsPage extends StatelessWidget {
  final Results data;

  DetailsPage({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.name!)),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 200,
          child: Image.network(
            data.backgroundImage!,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(data.slug!),
        SizedBox(
          height: 10,
        ),
        Text(
          "Genres",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.genres!.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Chip(label: Text(data.genres![index].name!)));
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Screenshots",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.shortScreenshots!.length,
                itemBuilder: ((context, index) {
                  return Card(
                      child: Container(
                    height: 150,
                    // width: 150,
                    child: Image.network(data.shortScreenshots![index].image!),
                  ));
                })))
      ]),
    );
  }
}
