import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:midterm_app/pages/fifth_page.dart';
import 'package:midterm_app/pages/first_page.dart';
import 'package:midterm_app/pages/fourth_page.dart';
import 'package:midterm_app/pages/second_page.dart';
import 'package:midterm_app/pages/sixth_page.dart';
import 'package:midterm_app/pages/third_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FormReviewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midterm Test',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),
        '/1': (context) => ReviewFormPage(),
        '/2': (context) => ReviewPage(),
        '/3': (context) => BlankPagethird(),
        '/4': (context) => BlankPagefour(),
        '/5': (context) => BlankPagefive(),
        '/6': (context) => BlankPagesix(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePagestate();
}

class _MyHomePagestate extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Cream App')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/1');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.badge),
                          Text('Review Form')
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/2');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.chat),
                          Text('Review Page')
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/3');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.error),
                          Text('Blank Page')
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/4');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.error),
                          Text('Blank Page')
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/5');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.error),
                          Text('Blank Page')
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/6');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.error),
                          Text('Blank Page')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}

