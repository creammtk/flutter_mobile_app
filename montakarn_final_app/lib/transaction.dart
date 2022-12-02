import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/add_new_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class TransactionFullPage extends StatelessWidget {

  const TransactionFullPage({super.key, required this.cardNumber, required this.cardExpiration, required this.color});

  final String cardNumber;
  final String cardExpiration;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
      ),
      body: TransactionList(cardNumber: cardNumber, cardExpiration: cardExpiration, color: color),
    );
  }
}
class TransactionList extends StatefulWidget {
  

  const TransactionList({super.key, required this.cardNumber, required this.cardExpiration, required this.color});

  final String cardNumber;
  final String cardExpiration;
  final Color color;

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<TransactionList> {



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("montakarn_transactions")
            .where('cardNumber', isEqualTo: widget.cardNumber)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),);
          }
          if (snapshot.data!.docs.toList().isEmpty)
          {
            return 
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildCreditCard(
                      color: widget.color,
                      cardExpiration: widget.cardExpiration,
                      cardNumber: widget.cardNumber,
                    ),
                  ),
                  Center(
              child: Text(
                'No transaction.'
              )
                  )
                ],
              );
          }
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildCreditCard(
                      color: widget.color,
                      cardExpiration: widget.cardExpiration,
                      cardNumber: widget.cardNumber,
                    ),
                  ),
                  
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Recent Transactions',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              ...snapshot.data!.docs.map((e) {
                    return _buildTransactionCard(
                      Type: e['Type'],
                      TransactionId: e.id,
                      Amount: e['Amount'],
                    );
                  }).toList()
            ],
          );
        }
    );
  }
}

 Widget _buildTransactionCard(
      {
      required String Type,
      required String TransactionId,
      required int Amount,
      }) 
      
      {
  var bgColorSets = {
      'Shopping': Color.fromARGB(255, 101, 205, 94),
      'Netflix': Color.fromARGB(255, 206, 94, 94),
      'Salary': Color.fromARGB(255, 88, 199, 198),
  };
    return Card(
        color: bgColorSets[Type],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        child: Container(
          height: 120,
          width: 400,
          padding: const EdgeInsets.all(30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 35),
                      child: Icon(
                        size: 40,
                        Icons.wallet
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Type,
                          style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(
                          TransactionId,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 10,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Amount < 0? "-\$"+(-Amount).toString(): "\$"+Amount.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogoBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildingDetailBlock(
                    label: 'VALID THRU', value: cardExpiration),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildingDetailBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildLogoBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset("images/contact.png", height: 20, width: 18),
        Image.asset("images/master.png", height: 50, width: 50)
      ],
    );
  }

Widget _buildTitleSection({required title, required subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 6.0),
        child: Text(
          '$title',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
        child: Text(
          '$subtitle',
          style: TextStyle(fontSize: 21.0, color: Colors.black45),
        ),
      )
    ],
  );
}

//   class TransactionModel extends ChangeNotifier {
//   String _cardType = '';
//   int _Amount = 0;
//  get cardType => this._cardType;
//  set cardType(value){
//   this._cardType = value;
//   notifyListeners();
//  }
 
//  get Amount => this._Amount;
//  set Amount(value){
//   this._Amount = value;
//   notifyListeners();
//  }

// }



