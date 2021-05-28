import 'package:flutter/material.dart';
import './transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'travel',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoe',
      amount: 500,
      date: DateTime.now(),
    )
  ];
  Widget build(BuildContext conext) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Expense App'),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Text('Graph Card'),
                    color: Colors.blue,
                    elevation: 5,
                  ),
                ),
                Column(
                    children: transactions.map((tx) {
                  return Card(
                    child: Row(children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )),
                        child: Text(tx.amount.toString()),
                        padding:EdgeInsets.all(10)
                      ),
                      Column(children: <Widget>[
                        Text(tx.title),
                        Text(tx.date.toString()),
                      ]),
                    ]),
                  );
                }).toList())
              ])),
    );
  }
}
