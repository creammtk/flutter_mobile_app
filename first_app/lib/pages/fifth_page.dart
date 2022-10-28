import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FifthPage extends StatefulWidget{
  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  String preferredMeat ='';
  String preferredDrink ='';
  String preferredAppetizer ='';
  String preferredDessert ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 5'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
             onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> MeatPreferencePage(),
                  ),
                );
             }, 
             child: Consumer<FoodPreferenceModel>(
              builder: (context, value, child) {
                return Text(
                  'Select your preferred meat - ${value.preferredMeat}');
              },
             ),
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
             onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> DrinkPreferencePage(),
                  ),
                );
             },
             child: Consumer<FoodPreferenceModel>(
              builder: (context, value, child) {
                return Text(
                  'Select your preferred drink - ${value.preferredDrink}');
              },
             ),
          ),
          ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
             onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> AppetizerPreferencePage(),
                  ),
                );
             },
             child: Consumer<FoodPreferenceModel>(
              builder: (context, value, child) {
                return Text(
                  'Select your preferred appetizer - ${value.preferredAppetizer}');
              },
             ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
             onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> DessertPreferencePage(),
                  ),
                );
             },
             child: Consumer<FoodPreferenceModel>(
              builder: (context, value, child) {
                return Text(
                  'Select your preferred dessert - ${value.preferredDessert}');
              },
             ),
          ),
          ),
        ],
      ),
    );
  }
}

class MeatPreferencePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select meat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredMeat='Beef';
                Navigator.pop(context);
              },
              child: Text('Beef'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredMeat='Chicken';
                Navigator.pop(context);
              },
              child: Text('Chicken'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredMeat='Pork';
                Navigator.pop(context);
              },
              child: Text('Pork'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredMeat='Fish';
                Navigator.pop(context);
              },
              child: Text('Fish'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredMeat='Lamb';
                Navigator.pop(context);
              },
              child: Text('Lamb'),
              ),
          ),
        ],

      ),
    );
  }
}

class DrinkPreferencePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select drink'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDrink='Wine';
                Navigator.pop(context);
              },
              child: Text('Wine'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDrink='Beer';
                Navigator.pop(context);
              },
              child: Text('Beer'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDrink='Sparkling Water';
                Navigator.pop(context);
              },
              child: Text('Sparkling Water'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDrink='Fizzy Drink';
                Navigator.pop(context);
              },
              child: Text('Fizzy Drink'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDrink='Still Water';
                Navigator.pop(context);
              },
              child: Text('Still Water'),
              ),
          ),
        ],

      ),
    );
  }
}

class AppetizerPreferencePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select appetizer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredAppetizer='Calamari';
                Navigator.pop(context);
              },
              child: Text('Calamari'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredAppetizer='Spring Rolls';
                Navigator.pop(context); 
              },
              child: Text('Spring Rolls'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredAppetizer='French Fries';
                Navigator.pop(context);
              },
              child: Text('French Fries'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredAppetizer='Chicken Wings';
                Navigator.pop(context);
              },
              child: Text('Chicken Wings'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredAppetizer='Onion Rings';
                Navigator.pop(context);
              },
              child: Text('Onion Rings'),
              ),
          ),
        ],

      ),
    );
  }
}

class DessertPreferencePage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select dessert'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDessert='Ice Cream';
                Navigator.pop(context);
              },
              child: Text('Ice Cream'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDessert='Bua Loy';
                Navigator.pop(context);
              },
              child: Text('Bua Loy'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDessert='Kanom Chan';
                Navigator.pop(context);
              },
              child: Text('Kanom Chan'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDessert='Thong Yod';
                Navigator.pop(context);
              },
              child: Text('Thong Yod'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                context.read<FoodPreferenceModel>().preferredDessert='Sarim';
                Navigator.pop(context);
              },
              child: Text('Sarim'),
              ),
          ),
        ],

      ),
    );
  }
}
 
class FoodPreferenceModel extends ChangeNotifier {
  String _preferredMeat = '';
  String _preferredDrink = '';
  String _preferredAppetizer = '';
  String _preferredDessert = '';

 get preferredMeat => this._preferredMeat;
 set preferredMeat(value) {
   this._preferredMeat = value;
   notifyListeners();
 }

 get preferredDrink => this._preferredDrink;
 set preferredDrink(value) {
   this._preferredDrink = value;
   notifyListeners();
 }

 get preferredAppetizer => this._preferredAppetizer;
 set preferredAppetizer(value) {
   this._preferredAppetizer = value;
   notifyListeners();
 }

 get preferredDessert => this._preferredDessert;
 set preferredDessert(value) {
   this._preferredDessert = value;
   notifyListeners();
 }

}