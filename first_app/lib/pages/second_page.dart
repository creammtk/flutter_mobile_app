import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> entries = <String> ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    List<int> colorCodes = <int> [700, 500, 300, 700, 500, 300, 700];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hello ${entries[index]}'),
                    ),
                  );
                },
                child: Text('Entry ${entries[index]}')
                ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ), 
    );
  }
}




