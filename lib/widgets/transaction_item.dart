import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTX,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTX;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgcolor;
  @override
  void initState() {
    const availableColors = [
      Colors.indigo,
      Colors.purple,
      Colors.green,
      Colors.lightGreen
    ];
    _bgcolor=availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        elevation: 5,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _bgcolor,
                radius: 30,
                child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('\$${widget.transaction.amount}',
                            style: Theme.of(context).textTheme.title)))),
            title: Text(widget.transaction.title,
                style: Theme.of(context).textTheme.title),
            subtitle: Text(
              DateFormat.yMMMMd().format(widget.transaction.date),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    onPressed: () => widget.deleteTX(widget.transaction.id),
                    icon: Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    label: Text('DELETE'))
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTX(widget.transaction.id),
                  )));
  }
}
