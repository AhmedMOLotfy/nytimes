import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/FavouriteList.dart';
import 'package:nytimes/MainSection/parsedclass.dart';
import 'package:nytimes/Models/SectionTile.dart';
import 'package:nytimes/Routes.dart';
import 'package:nytimes/fetchData.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _saved = [];
  List<Results> _savedArticle = [];

  Widget _buildItem(Results results) {
    final added = _saved.contains(results.title);
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              CachedNetworkImage(
                fadeInCurve: Curves.easeInOut,
                fadeInDuration: Duration(
                  seconds: 1,
                ),
                placeholder: (BuildContext context, String url) =>
                    CircularProgressIndicator(),
                imageUrl: results.multiMedia.first.url.toString(),
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
                                subject: 'Ny Times ${results.section}');
                          }),
                      IconButton(
                        icon: Icon(
                            added ? Icons.favorite : Icons.favorite_outline),
                        onPressed: () {
                          setState(() {
                            if (added) {
                              _saved.remove(results.title);
                              _savedArticle.remove(results);
                            } else {
                              _saved.add(results.title);
                              _savedArticle.add(results);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.of(context).push(route(results));
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

  Future<NYTimes> futureNews;
  @override
  void initState() {
    futureNews = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "NEW York Times",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontFamily: 'UnifrakturCook',
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            OpenContainer(
              closedBuilder: (BuildContext context, VoidCallback action) {
                return ListTile(
                  leading: Text("Favorite List"),
                  trailing: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                );
              },
              openBuilder:
                  (BuildContext context, CloseContainerActionCallback action) {
                var abc = _savedArticle.map((e) => e).toList();
                return FavouriteList(
                  results: abc,
                );
              },
            ),
            ExpansionTile(
              title: Text("Sections"),
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SectionTile(
                        icon: Icons.business_sharp,
                        text: "Business",
                      ),
                      Divider(),
                      SectionTile(
                        text: "Health",
                        icon: Icons.medical_services,
                      ),
                      Divider(),
                      SectionTile(
                        icon: Icons.food_bank_outlined,
                        text: "Food",
                      ),
                      Divider(),
                      SectionTile(
                        text: "Sports",
                        icon: Icons.sports,
                      ),
                      Divider(),
                      SectionTile(
                        text: "science",
                        icon: Icons.science,
                      ),
                      Divider(),
                      SectionTile(
                        text: "Technology",
                        icon: Icons.computer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white12,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.5,
        backgroundColor: Colors.black,
        title: Text(
          "New York Times",
          style: TextStyle(
            fontFamily: 'UnifrakturCook',
            fontSize: 25,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureNews = fetchAlbum();
          });
        },
        child: Center(
          child: FutureBuilder<NYTimes>(
            future: futureNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        " ${snapshot.data.section.toUpperCase()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Last Updated: ${snapshot.data.lastUpdated}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                      children: snapshot.data.results
                          .map((e) => _buildItem(e))
                          .toList())
                ]);
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
