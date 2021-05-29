import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Travel',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoe',
      amount: 50.29,
      date: DateTime.now(),
    )
  ];
  //String titleInput;
  //String amountInput;
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  @override
  Widget build(BuildContext conext) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Expense App'),
          ),
          body: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
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
                Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                              decoration: InputDecoration(labelText: 'Title'),
                              controller:titleController,
                              ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Amount'),
                            controller:amountController,
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.purple)),
                              child: Text('Add Transaction'),
                              onPressed: () {
                                print(titleController.text);
                                print(amountController.text);
                              }),
                        ]),
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
                          color: Colors.purple,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text('\$${tx.amount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.purple)),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tx.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(DateFormat.yMMMd().format(tx.date),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                          ]),
                    ]),
                  );
                }).toList())
              ])),
    );
  }
}
