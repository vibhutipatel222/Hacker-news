import 'package:flutter/material.dart';
import 'package:hacker_news/widgets/feeditem.dart';

class Global extends ChangeNotifier {
  int count = 0;
  List<FeedItem> clickedItems= [];
  
  void addClickedURL(FeedItem newVal){
    

    if ((clickedItems.singleWhere((it) => it == newVal,
          orElse: () => null)) != null) {
    
    print('Already exists!');
  } else {
    print('Added!');
    count++;
    clickedItems.add(newVal);
  }

    notifyListeners();
  }
}