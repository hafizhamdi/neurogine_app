import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurogine_app/controllers/rawg_controller.dart';

class NeurogineApp extends StatelessWidget {
  RawgController rawgController = Get.put(RawgController());

  @override
  Widget build(BuildContext context) {
    final data = rawgController;

    return Scaffold(
        appBar: AppBar(
          title: Text("Games"),
        ),
        body: Obx(
          () => data.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : data.gameModel != null?ListView.builder(
                  itemCount: data.gameModel!.results!.length,
                  itemBuilder: ((context, index) {
                    return CardItem(
                      src: data.gameModel!.results![index].backgroundImage!,
                      title: data.gameModel!.results![index].name!,
                    );
                  })): Center(child: Text("Data failed to fetch")),
        ));
  }
}

class CardItem extends StatelessWidget {
  final String src;
  final String title;
  CardItem({required this.src, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        SizedBox(
          height: 200,
          child: Image.network(src),
        ),
        Column(
          children: [
            Text("$title"),
          ],
        )
      ]),
    );
  }
}
