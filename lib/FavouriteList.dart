import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/DetailsPage.dart';
import 'package:nytimes/MainSection/parsedclass.dart';
import 'package:share/share.dart';

class FavouriteList extends StatefulWidget {
  final List<Results> results;
  FavouriteList({this.results});
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Favourite List"),
      ),
      body: ListView(
        children: widget.results.map((e) => _buildItem(e, context)).toList(),
      ),
    );
  }
}

Widget _buildItem(Results results, BuildContext context) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(2),
        ),
        height: 7.0,
      ),
      Card(
        child: Column(
          children: [
            Hero(
              tag: 'tag',
              child: CachedNetworkImage(
                placeholder: (BuildContext context, String url) =>
                    CircularProgressIndicator(),
                imageUrl: results.multiMedia.first.url.toString(),
              ),
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: Text(
                """${results.title}""",
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(results.title,
                              subject: 'NYTimes Article');
                        }),
                    Icon(Icons.favorite),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPage(
                                results: results,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
