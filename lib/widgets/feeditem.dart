import 'package:flutter/material.dart';
import 'package:hacker_news/global.dart';
import 'package:hacker_news/widgets/roundedItem.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hacker_news/styles.dart';

class FeedItem extends StatelessWidget {
  FeedItem({@required this.by,@required this.title,@required this.url,@required this.time,@required this.comments,@required this.score});

  final String by,title,url,time;
  final int score,comments;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        Provider.of<Global>(context, listen: false).addClickedURL(this);
      if (await canLaunch(url)) {
         await launch(url);
      } else {
          throw 'Could not launch url';
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('by: '+by,style: heading3.copyWith(color:Colors.blue),),
                    Text(time,style: heading3,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:12.0),
                  child: Text(title,style: heading2,),
                ),
                Row(children: [
                  RoundedItem(type: 'points', text: score.toString()),
                  RoundedItem(icon: Icons.comment_rounded, text: comments.toString()),
                ],),
                
              ],
            ),
          ),
          Divider(
                thickness: 2.5,
                color: Colors.grey[400],
              ),
        ],
      ),
    );
  }
}