import 'dart:async';

import 'package:first_app/pages/sixth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/first_page.dart';
import 'pages/fourth_page.dart';
import 'pages/second_page.dart';
import 'pages/third_page.dart';
import 'pages/fifth_page.dart';
import 'pages/sixth_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FoodPreferenceModel()),
      ChangeNotifierProvider(create: (context) => LoginProfileModel()),
    ],
    child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/1',
      routes: {
        '/':(context) => const MyHomePage(title: 'Home'),
        '/1' :(context) => FirstPage(),
        '/2' :(context) => SecondPage(),
        '/3' :(context) => ThirdPage(),
        '/4' :(context) => FourthPage(),
        '/5' :(context) => FifthPage(),
        '/6' :(context) => SixthPage(),
        },
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
  int _counter = 0;
  String _image = 'images/sampleduffy.png';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 100.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              child: Image.asset(
                _image,
                width: 200,
                ),
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text('My first text'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter--;
                        _image = 'images/angry-bear.jpg';
                      });
                    },
                    child: Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                        _image = 'images/sampleduffy.png';
                      });
                    },
                    child: Text('reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter++;
                        _image = 'images/smile.jpg';
                      });
                    }, 
                    child: Text('+'), 
                  ),
                ],
              ),
              MyDynamicButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
              MyButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}

class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('My Button')
    );
  }
}

class MyDynamicButton extends StatefulWidget{
  @override
  State<MyDynamicButton> createState() => _MyDynamicButtonState();
}

class _MyDynamicButtonState extends State<MyDynamicButton> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _counter++;
        });
      }, 
      child: Text('$_counter')
    );
  }
}

