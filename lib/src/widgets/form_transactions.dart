import 'package:flutter/material.dart';

class FormTransactions extends StatefulWidget {
  final Function addTransaction;

  FormTransactions(this.addTransaction);

  @override
  _FormTransactionsState createState() => _FormTransactionsState();
}

class _FormTransactionsState extends State<FormTransactions> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void handleSubmitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) return;

    widget.addTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        child: Container(
          height: 400,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Type what you bought'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => handleSubmitTransaction(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    hintText: 'How much it costed?'),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: handleSubmitTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
