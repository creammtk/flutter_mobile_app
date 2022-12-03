import '../class_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/class_card.dart';
import 'package:final_app/inputformat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CardProvider with ChangeNotifier {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _cardCollection = FirebaseFirestore.instance.collection("montakarn_cards");

  int _amount = 0;
  List _cards = [];

  int get amount => _amount;
  List get cards => _cards;

  

  void addCard(mtk_card myCard) async{
    //send data to fire base
    await _cardCollection.add({
                    "card_number": myCard.card_number,
                    "card_exp": myCard.card_exp,
                    "cvv": myCard.cvv,
                    "createDate": DateTime.now().toString(),
            });
    _cards.add(myCard);
    notifyListeners();
  }
}