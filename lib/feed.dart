import 'dart:convert';
import 'package:hacker_news/styles.dart';
import 'package:hacker_news/widgets/feeditem.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  bool show = false;
  bool full = false;
  bool loadmore = false;

  List<FeedItem> items = [];
  Response response;
  int count = 0;
  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future getAll() async {
      print('starting getall..');
    try{
      response = await http.get(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty').timeout(Duration(seconds: 5));
        if (response.statusCode >= 400 && response.statusCode < 600) {
      throw Exception("Bad response from server");
    }
    if (response.statusCode == 200) {
      print('recieved response..');
      populateTopStories();
    } else {
      //throw Exception("Unable to fetch data!");
    }
    }
    catch(e){
      showDialog( 
                context: context, 
                builder: (ctx) => AlertDialog( 
                  title: Text("Unable to fetch data"), 
                  content: Text("Please check your internet connection"), 
                  actions: <Widget>[ 
                    FlatButton( 
                      onPressed: () { 
                        Navigator.of(ctx).pop(); 
                        getAll(); 
                      }, 
                      child: Text("Retry"), 
                    ),
                    FlatButton( 
                      onPressed: () { 
                        Navigator.of(ctx).pop(); 
                        Navigator.of(ctx).pop(); 
                      }, 
                      child: Text("Cancel"), 
                    ), 
                  ], 
                ), 
              ); 
    }
  }

  Future<List<Response>> getTopStories() async {
    print('in function gettopstories');
    Iterable storyIds = jsonDecode(response.body);
        print(count);
   if(storyIds.length< (count+1)*10){
       setState(() {
        full=true;
       });
        print('fulll');
      }
    return Future.wait(storyIds.skip(count * 10).take(10).map((storyId) {
      return http.get(
          'https://hacker-news.firebaseio.com/v0/item/${storyId}.json?print=pretty');
    }));
  }

  void populateTopStories() async {
    setState(() {
      loadmore = true;
    });
    List<Response> responsess;
    try{responsess = await getTopStories();
    count++;}
    catch(e){
      showDialog( 
                context: context, 
                builder: (ctx) => AlertDialog( 
                  title: Text("Unable to fetch data"), 
                  content: Text("Please check your internet connection"), 
                  actions: <Widget>[ 
                    FlatButton( 
                      onPressed: () { 
                        getAll(); 
                      }, 
                      child: Text("Retry"), 
                    ),
                    FlatButton( 
                      onPressed: () { 
                        Navigator.of(ctx).pop(); 
                      }, 
                      child: Text("Calcel"), 
                    ), 
                  ], 
                ), 
              ); 
    }
    
    final stories = responsess.map((response) {
      final json = jsonDecode(response.body);
      items.add(FeedItem(
        by: json["by"],
        title: json["title"],
        url: json["url"].toString(),
        score: json["score"],
        time: readTimestamp(json["time"]),
        comments: (json["kids"] == null) ? 0 : json["kids"].length,
      ));
      //return Story.fromJSON(json);
    }).toList();

    setState(() {
      show = true;
      loadmore = false;

    });
    /*setState(() {
      _stories = stories; 
    });*/
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + 'h ago';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + ' min ago';
      } else
        time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' day ago';
      } else {
        time = diff.inDays.toString() + ' days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' week ago';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' weeks ago';
      }
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Stories',
        ),
      ),
      body: (show)
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (index == items.length - 1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      items.elementAt(index),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: (!full)
                            ? (loadmore)
                                ? Center(child: Wrap(children: [CircularProgressIndicator()]))
                                : InkWell(
                                  onTap:() {
                        populateTopStories();
                      },
                                           child: Text(
                                      'Load more...',
                                      style: subheading,
                                      textAlign: TextAlign.center,
                                    ),
                                )
                            : Text('- - - -  All news fetched  - - - -',
                                      style: subheading,
                                      textAlign: TextAlign.center,
                            ),
                      ),
                      SizedBox(height:10),
                    ],
                  );
                } else
                  return items.elementAt(index);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
