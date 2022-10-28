
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:midterm_app/main.dart';
import 'package:midterm_app/pages/second_page.dart';
import 'package:provider/provider.dart';


class ReviewFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Form Page'),
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm>{
  final _formKey = GlobalKey<FormState>();
  double rating = 0;
  late String _name;
  late String _review;
  late double _stars;
  var _pass;

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: context.read<FormReviewModel>().name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter restaurant name ',
                icon: Icon(Icons.badge),
              ),
                validator: (value) {
                _pass = value;
                if (value == null || value.isEmpty){
                  return 'Please enter restaurant name';
                }

                if (value.length < 5) {
                  return 'Restaurant name must be at least 5 charactors';
                }

                return null;
              },
              onSaved: (newValue){
                _name = newValue!;

              },
            ),
           ),
           
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: context.read<FormReviewModel>().review,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Review the restaurant ',
                icon: Icon(Icons.chat),
              ),
              validator: (value) {
                _pass = value;
                if (value == null || value.isEmpty){
                  return 'Please enter review';
                }
                return null;
              },
              onSaved: (newValue){
                _review = newValue!;

              },
            ),
          ),

           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Rate restaurant:'),
                  RatingBar.builder(
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(Icons.star, color:Color.fromARGB(255, 226, 154, 178)),
                    onRatingUpdate: (rating) => {
                      setState(() {
                      this.rating = rating;
                    }),
                    _stars = rating
                  },
                  ),
                ],
              ),
            ),
            
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 ElevatedButton (
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                        _formKey.currentState!.save();

                        context.read<FormReviewModel>()
                        ..name = _name
                        ..review = _review
                        ..stars = _stars;
                        Navigator.pushNamed(context, '/2');
                    }
                  },
                  child: Text('Review'),
                 ),
                ],
              ),
            ),

          ],
        ),
    );
  }
}

class FormReviewModel extends ChangeNotifier {
  String _name = '';
  String _review = '';
  double _stars = 0;
 get name => this._name;
 set name(value){
  this._name = value;
  notifyListeners();
 }
 
 get review => this._review;
 set review(value){
  this._review = value;
  notifyListeners();
 } 

 get stars => this._stars;
 set stars(value){
  this._stars = value;
  notifyListeners();
 } 

}




