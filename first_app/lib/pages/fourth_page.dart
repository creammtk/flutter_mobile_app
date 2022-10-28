import 'package:first_app/pages/fifth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 4'),
      ),
      body: Center(
        child: Consumer<FoodPreferenceModel>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Meat : ${value.preferredMeat}'),
                Text('Drink : ${value.preferredDrink}'),
                Text('Appetizer : ${value.preferredAppetizer}'),
                Text('Dessert : ${value.preferredDessert}'),
                ElevatedButton(
                  onPressed: () {
                    value
                      ..preferredMeat = ''
                      ..preferredDrink = ''
                      ..preferredAppetizer = ''
                      ..preferredDessert = '';
                  },
                  child: Text('Clear food preference'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}