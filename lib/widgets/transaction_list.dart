import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 340,
        child: transactions.isEmpty
            ? Column(children: <Widget>[
                Text('No Transactions Yet',
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ])
            : ListView.builder(
                itemBuilder: (cntxt, index) {
                  return Card(margin:EdgeInsets.symmetric(vertical:8,horizontal:5),elevation:5,child:ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(padding:EdgeInsets.all(6),child:FittedBox(
                              child: Text('\$${transactions[index].amount}',
                                  style: Theme.of(context).textTheme.title)))),
                                  title:Text(transactions[index].title,style:Theme.of(context).textTheme.title),
                                  subtitle: Text(DateFormat.yMMMMd().format(transactions[index].date),)));
                },
                itemCount: transactions.length));
  }
}
