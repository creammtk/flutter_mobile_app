import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/add_new_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionFullPage extends StatelessWidget {
  const TransactionFullPage(
      {super.key,
      required this.cardNumber,
      required this.cardExpiration,
      required this.cardCVV,
      required this.color});

  final String cardNumber;
  final String cardCVV;
  final String cardExpiration;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: TransactionList(
          cardNumber: cardNumber, cardExpiration: cardExpiration, color: color, cardCVV: cardCVV),
    );
  }
}

class TransactionList extends StatefulWidget {
  const TransactionList(
      {super.key,
      required this.cardNumber,
      required this.cardExpiration,
      required this.cardCVV,
      required this.color});

  final String cardNumber;
  final String cardCVV;
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
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.toList().isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCreditCard(
                    color: widget.color,
                    cardExpiration: widget.cardExpiration,
                    cardNumber: widget.cardNumber,
                    cardCVV: widget.cardCVV,
                    totalAmount: 0,
                  ),
                ),
                Center(child: Text('No transaction.'))
              ],
            );
          }
          final amountList = snapshot.data!.docs.toList().map((element) => element['Amount']);
          final totalAmount = amountList.reduce((value, element) => value + element) as int;

          return ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTitleSection(
                      title: 'Hello Cream', subtitle: 'Welcome back...'),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 16.0, bottom: 20.0),
                    child: FloatingActionButton.small(
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewCardState()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildCreditCard(
                        color: widget.color,
                        cardExpiration: widget.cardExpiration,
                        cardNumber: widget.cardNumber,
                        cardCVV: widget.cardCVV,
                        totalAmount: totalAmount,
                        ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 20.0, top: 20.0),
                child: Text(
                  'Recent Transactions',
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
        });
  }
}

Widget _buildTransactionCard({
  required String Type,
  required String TransactionId,
  required int Amount,
}) {
  var bgColorSets = {
    'Shopping': Color.fromARGB(255, 164, 97, 172),
    'Netflix': Color.fromARGB(255, 206, 94, 94),
    'Salary': Color.fromARGB(255, 88, 199, 198),
    'Lineman': Color.fromARGB(255, 86, 205, 77),
    'Prize': Color.fromARGB(255, 202, 190, 62),
  };
  return Card(
      color: bgColorSets[Type],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
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
                    child: Icon(size: 40, Icons.wallet),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Type,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(TransactionId,
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
                        Amount < 0
                            ? "-\$" + (-Amount).toString()
                            : "\$" + Amount.toString(),
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
    required String cardExpiration,
    required String cardCVV,
    required int totalAmount,
    }
    ) {
  return Card(
    elevation: 4.0,
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    child: Container(
      height: 230,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildLogoBlock(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              totalAmount.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'CourrierPrime'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              cardNumber,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'CourrierPrime'),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildingDetailBlock(label: 'CVV', value: cardCVV),
              _buildingDetailBlock(label: 'VALID THRU', value: cardExpiration),
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
      Text(
        'Balance',
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Image.asset("images/master.png", height: 50, width: 50)
    ],
  );
}

Widget _buildTitleSection({required title, required subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Text(
          '$title',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        child: Text(
          '$subtitle',
          style: TextStyle(fontSize: 18.0, color: Colors.black45),
        ),
      )
    ],
  );
}





