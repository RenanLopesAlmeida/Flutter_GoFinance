import 'package:flutter/material.dart';
import './empty_transactions.dart';
import './transaction_item_card.dart';

import '../../models/transaction.model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? EmptyTransactions()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItemCard(
                transactions: transactions,
                index: index,
              );
            },
          );
  }
}
