import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurogine_app/models/game_model.dart';

import '../controllers/rawg_controller.dart';

class DetailsPage extends StatelessWidget {
  // final int id;

  RawgController rawgController = Get.put(RawgController());

  // DetailsPage({required this.id});
  @override
  Widget build(BuildContext context) {
    final data = rawgController;
    return Scaffold(
      appBar: AppBar(title: Text("Game Details")),
      body: Obx(
        () => data.isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          data.result["background_image"],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(data.result["description"]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Genres",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.result["genres"].length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Chip(
                                    label: Text(
                                        data.result["genres"][index]["name"])));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Metacritic",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          data.result["metacritic"] ?? "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      // SizedBox(
                      //     height: 150,
                      //     child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: data.result["tags"].length,
                      //         itemBuilder: ((context, index) {
                      //           return Card(
                      //               child: Container(
                      //             height: 150,
                      //             // width: 150,
                      //             child: Image.network(
                      //                 data.result["tags"]["image_background"]),
                      //           ));
                      //         })))
                    ]),
              ),
      ),
    );
  }
}
