import 'package:flutter/material.dart';

class BlankPagesix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page 6'),
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
