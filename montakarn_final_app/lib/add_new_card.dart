import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/class_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class AddNewCardState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add New Card'),
      ),
      body: SingleChildScrollView(
        child: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm>  {

  final _formKey = GlobalKey<FormState>();
  // late String _cardNumber;
  // late String _cardExp;
  // late String _cardCVV;

  mtk_card myCard = 
    mtk_card(card_number: "",card_exp: "", cvv: "");

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _cardCollection = FirebaseFirestore.instance.collection("montakarn_cards");

  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    // ignore: prefer_const_constructors
                    // initialValue: context.read<FormAddCard>().cardNumber,
                    inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.solid)),
                      hintText: "Card Number",
                      prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.add_card),
                        ),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }

                      if (value.length < 16) {
                        return 'Card number must be at least 16 charactors';
                      }

                      return null;
                    },
                    onSaved: (String? card_number){
                      // _cardNumber = card_number!;
                      myCard.card_number = card_number!;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // initialValue: context.read<FormAddCard>().cardExp,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.solid)),
                        hintText: 'MM/YY',
                        prefixIcon:  Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.calendar_month),
                        ),
                          hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card expired';
                      }

                      if (value.length < 4) {
                        return 'Year must be 20xx';
                      }

                      return null;
                    },
                      onSaved: (String? card_exp){
                        // _cardExp = card_exp!;
                        myCard.card_exp = card_exp!;
                    },
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: TextFormField(
                      // initialValue: context.read<FormAddCard>().cardCVV,
                      inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.solid)),
                        hintText: 'CVV',
                        prefixIcon:  Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.sd_card_sharp),
                        ),
                          hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CVV';
                      }

                      if (value.length < 2) {
                        return 'CVV must be at least 3 charactors';
                      }

                      return null;
                    },
                      onSaved: (String? cvv){
                        // _cardCVV = cvv!;
                        myCard.cvv = cvv!;
                    },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed:() async{
                if(_formKey.currentState!.validate()) {
                   _formKey.currentState!.save();
                   await _cardCollection.add({
                    "card_number": myCard.card_number,
                    "card_exp": myCard.card_exp,
                    "cvv": myCard.cvv,
                    "createDate": DateTime.now().toString(),
                   });
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                }
              },
              child: Text('Save')
            ),
          ],
        ),
      ),
    );
  }
}

// class FormAddCard extends ChangeNotifier {
//   String _cardNumber = '';
//   String _cardExp = '';
//   String _cardCVV = '';
//  get cardNumber => this._cardNumber;
//  set cardNumber(value){
//   this._cardNumber = value;
//   notifyListeners();
//  }
 
//  get cardExp => this._cardExp;
//  set cardExp(value){
//   this._cardExp = value;
//   notifyListeners();
//  } 

//  get cardCVV => this._cardCVV;
//  set cardCVV(value){
//   this._cardCVV = value;
//   notifyListeners();
//  } 

// }