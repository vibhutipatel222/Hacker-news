import 'package:flutter/material.dart';
import 'package:hacker_news/feed.dart';
import 'package:hacker_news/global.dart';
import 'package:hacker_news/history.dart';
import 'package:hacker_news/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Global>(
      create: (context){ return Global();},
     // builder: (context,lo) => Global(),
          child: ScreenUtilInit(
        designSize: Size(360, 640),
        allowFontScaling: true,
            child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hacker News',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Hello,',
                  style: mainheading,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'You have clicked on ' + Provider.of<Global>(context).count.toString() + ' links',
                      style: heading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Feed()));
              },
              child: Text(
                'News Feed',
                style: heading.copyWith(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
