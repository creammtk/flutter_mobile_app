
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/first_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Page'),
      ),
      body: Consumer<FormReviewModel>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Text('Restaurant name: ${value.name}', style: const TextStyle(fontSize: 20)),
             Text('Review: ${value.review}', style: const TextStyle(fontSize: 20)),
             Row(
              children: [
                const Text('Rating: ', style: TextStyle(fontSize: 20)),
                RatingBar.builder(
                    minRating: 1,
                    itemBuilder: (context, _) => const Icon(Icons.star, color:Color.fromARGB(255, 226, 154, 178)),
                    initialRating:value.stars,
                    itemSize: 20,
                    ignoreGestures: true,
                    onRatingUpdate: (double value) { return;},
                  ),
              ],
             ),
             
             ElevatedButton(
                  onPressed: () {
                    value
                      ..name = ''
                      ..review = ''
                      ..stars= 0.0;
                  },
                  child: const Text('Clear Review'),
                ),
            ],
          );
        }
    ),
    );
  }
}

