import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/class_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  mtk_card myCard = 
    mtk_card(card_number: "", card_holder: "", card_exp: "", cvv: "");

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
                    onSaved: (String? card_number){
                      myCard.card_number = card_number!;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.solid)),
                      hintText: "Card Color",
                      prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.color_lens),
                        ),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                    ),
                    // onSaved: (String? color){
                    //   myCard.color = color!;
                    // },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    // ignore: prefer_const_constructors
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.solid)),
                      hintText: "Card Holder",
                      prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.people),
                        ),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                    ),
                    onSaved: (String? card_holder){
                      myCard.card_holder = card_holder!;
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
                      onSaved: (String? card_exp){
                      myCard.card_exp = card_exp!;
                    },
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: TextFormField(
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
                      onSaved: (String? cvv){
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
                    // "color": myCard.color.toString(),
                    "card_holder": myCard.card_holder,
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