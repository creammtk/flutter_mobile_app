import 'package:first_app/pages/third_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LoginProfileModel>(
          builder: (context, value, child) {
            return Text('Hello ${value.name}');
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:Text('hello'),
                  ),
              );
            },
            icon: const Icon(Icons.tiktok),
            ),

          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/2');
            } ,
            icon: const Icon(Icons.forward),
            )
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(7,(index){
            return InkWell(
              onTap:() {
                if (index < 2){
                  return;
                }

                Navigator.pushNamed(context, '/$index');
              },
            child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of( context).primaryColor.withOpacity(0.50),
                  borderRadius: BorderRadius.circular(16.0),
                  ),
                child: Center(
                  child:Text('Page $index'),
                ),
            ),
          );
           }
          )
        ),
       ),
    );
  }

}