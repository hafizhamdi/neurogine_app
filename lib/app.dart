import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurogine_app/controllers/rawg_controller.dart';
import 'package:neurogine_app/pages/details.dart';

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
                          onTap: () {
                            rawgController.fetchDetailGame(
                                data.gameModel!.results![index].id);
                            Get.to(() => DetailsPage());
                          },
                          src: data.gameModel!.results![index].backgroundImage,
                          title: data.gameModel!.results![index].name!,
                          score: data.gameModel!.results![index].ratingsCount,
                          releaseDate:
                              data.gameModel!.results![index].released!,
                        );
                      }))
                  : Center(child: Text("Data failed to fetch")),
        ));
  }
}

class CardItem extends StatelessWidget {
  final String? src;
  final String title;
  final int? score;
  final String releaseDate;
  final Function() onTap;
  CardItem(
      {required this.src,
      required this.title,
      required this.onTap,
      this.score,
      required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: src != null ? Image.network(src!) : null,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      "$title",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Released on $releaseDate",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            "$score",
                            style: TextStyle(color: Colors.grey),
                          )
                        ])
                      ])
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }
}
