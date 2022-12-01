import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'add_new_card.dart';

var index_color = 0;
class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("montakarn_cards")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var dataList = snapshot.data!.docs.toList();
          dataList.sort((a,b) {
            var adate = a['createDate']; //before -> var adate = a.expiry;
            var bdate = b['createDate']; //before -> var bdate = b.expiry;
            return bdate.compareTo(adate); //to get the order other way just switch `adate & bdate`
          });
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildBalanceCard(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Banks and cards',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FloatingActionButton(
                child: const Icon(Icons.add),
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNewCardState()),
                  );
                },
              ),
            ],
          ),
                ],
              ),
              ...dataList.map((document) {
              var colorList = [0xFFdf3512, 0xFF3b556e, 0xFF4FC1DB];
              var color = colorList[index_color % colorList.length];
              index_color++;
              return Card(
                elevation: 4.0,
                color: Color(color),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 22.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset("images/contact.png",
                                height: 20, width: 18),
                            Image.asset("images/master.png",
                                height: 50, width: 50)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            document["card_number"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontFamily: 'CourrierPrime'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'CARDHOLDER',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  document["card_holder"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'VALID THRU',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  document["card_exp"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                ),
              );
            }).toList()
            ],
          );
        },
      );
  }
}


Widget _buildBalanceCard() {
    return Card(
        color: Color.fromARGB(0, 0, 0, 0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        child: Container(
          height: 200,
          width: 400,
          padding: const EdgeInsets.all(30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Cream...",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Balance',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text("\$0.00",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
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
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildingDetailBlock(label: 'CARDHOLDER', value: cardHolder),
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

