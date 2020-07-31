import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.model.dart';

class TransactionItemCard extends StatelessWidget {
  final List<Transaction> transactions;
  final int index;
  final Function deleteTransaction;

  TransactionItemCard(
      {@required this.transactions,
      @required this.index,
      @required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 30,
          child: Container(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$ ${transactions[index].amount}'),
            ),
          ),
        ),
        title: Text(
          '${transactions[index].title}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(transactions[index].date)}',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(transactions[index].id),
        ),
      ),
    );
  }
}
