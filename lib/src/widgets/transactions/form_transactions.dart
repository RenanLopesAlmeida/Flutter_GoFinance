import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormTransactions extends StatefulWidget {
  final Function addTransaction;

  FormTransactions(this.addTransaction);

  @override
  _FormTransactionsState createState() => _FormTransactionsState();
}

class _FormTransactionsState extends State<FormTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _handleSubmitTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(_enteredTitle, _enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        height: 400,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    labelText: 'Title', hintText: 'Type what you bought'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _handleSubmitTransaction(),
                decoration: InputDecoration(
                    labelText: 'Amount', hintText: 'How much it costed?'),
              ),
              Container(
                height: 90,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _handleSubmitTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
