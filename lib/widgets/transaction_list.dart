import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTX;
  TransactionList(this.transactions, this.deleteTX);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (cntx, constraints) {
            return Column(children: <Widget>[
              Text('No Transactions Yet',
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover))
            ]);
          })
        : ListView.builder(
            itemBuilder: (cntxt, index) {
              return TransactionItem(transaction: transactions[index], deleteTX: deleteTX);
            },
            itemCount: transactions.length);
  }
}

