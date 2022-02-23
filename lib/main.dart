import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'カウントダウン',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer cd = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = cd.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("おわり");
      sub.cancel();
      _current = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$_current秒",
              //style: Theme.of(context).textTheme.display1,
            ),
            Container(
                //'$_counter',
                //style: Theme.of(context).textTheme.headline4,
                ),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Text("start"),
            )
          ],
        ),
      ),
    );
  }
}
