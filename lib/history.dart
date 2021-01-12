import 'package:flutter/material.dart';
import 'package:hacker_news/global.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visited links',
        ),
      ),
      body: ListView.builder(
              itemCount: Provider.of<Global>(context).clickedItems.length,
              itemBuilder: (context, index) {
                       return Provider.of<Global>(context).clickedItems.elementAt(index);
              },
            ),
    );
  }
}