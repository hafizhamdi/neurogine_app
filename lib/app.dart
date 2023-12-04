import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurogine_app/controllers/rawg_controller.dart';

class NeurogineApp extends StatefulWidget {
  _NeurogineApp createState() => _NeurogineApp();
}

class _NeurogineApp extends State<NeurogineApp> {
  RawgController rawgController = Get.put(RawgController());
  ScrollController? _scrollController;
  // int _pageCount = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);

    // rawgController.fetchGames(rawgController.pageCount);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
  }

  _scrollListener() {
    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      // Scroll reach bottom
      rawgController.addPageCount();
      rawgController.fetchGames(rawgController.pageCount);
    }

    if (_scrollController!.offset <=
            _scrollController!.position.minScrollExtent &&
        _scrollController!.position.outOfRange) {
      // Scroll reach top

      rawgController.removePageCount();

      rawgController.fetchGames(rawgController.pageCount);
    }
  }

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
              : data.gameModel != null
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: data.gameModel!.results!.length,
                      itemBuilder: ((context, index) {
                        return CardItem(
                          src: data.gameModel!.results![index].backgroundImage,
                          title: data.gameModel!.results![index].name!,
                        );
                      }))
                  : Center(child: Text("Data failed to fetch")),
        ));
  }
}

class CardItem extends StatelessWidget {
  final String? src;
  final String title;
  CardItem({required this.src, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        SizedBox(
          height: 200,
          child: src != null ? Image.network(src!) : null,
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
