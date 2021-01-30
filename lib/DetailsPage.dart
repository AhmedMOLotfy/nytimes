import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/MainSection/parsedclass.dart';
import 'package:nytimes/webView.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final Results results;
  DetailsPage({this.results});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(widget.results.section.toUpperCase()),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.results.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'BerkshireSwash',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text(
              widget.results.abstract,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
              ),
            ),
          ),
          Hero(
            tag: 'tag',
            child: Padding(
              padding: EdgeInsets.only(
                top: 6,
              ),
              child: CachedNetworkImage(
                placeholder: (context, String url) =>
                    CircularProgressIndicator(),
                imageUrl: widget.results.multiMedia.first.url,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.results.byline,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  widget.results.updatedDate,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Full Article"),
              Row(
                children: [
                  TextButton(
                    child: Text(widget.results.shortUrl),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebV(url: widget.results.url);
                      }));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: () {
                      launch(widget.results.url);
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
// launch(results.url);
