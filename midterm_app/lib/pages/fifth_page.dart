import 'package:flutter/material.dart';

class BlankPagefive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page 5'),
        ),
        body: Container(
          margin: const EdgeInsets.only(top:250.0),
          child: Center(
            child: Column(
              children: [
                const Icon(Icons.error),
                const Text('Blank Page'),
              ],
            ),
          ),
        )
        );
  }
}
