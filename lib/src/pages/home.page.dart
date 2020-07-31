import 'package:flutter/material.dart';
import '../widgets/charts/chart.dart';
import '../widgets/transactions/form_transactions.dart';
import '../widgets/transactions/transaction_list.dart';
import '../models/transaction.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];

  //get the transactions that happened on last week
  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return FormTransactions(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoFinance'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => this._startAddNewTransaction(context),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
        tooltip: 'Add a Transaction',
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => this._startAddNewTransaction(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(
              recentTransactions: _recentTransactions,
            ),
            Container(
              height: 350,
              child: TransactionList(
                transactions: _userTransactions,
                deleteTransaction: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
