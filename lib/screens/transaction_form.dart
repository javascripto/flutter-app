import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/progress.dart';
import 'package:flutter_app/components/response_dialog.dart';
import 'package:flutter_app/components/transaction_auth_dialog.dart';
import 'package:flutter_app/http/webclients/transaction_webclient.dart';
import 'package:uuid/uuid.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm({required this.contact});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final String _transactionId = Uuid().v4();
  final TextEditingController _valueController = TextEditingController();
  final _webClient = TransactionWebClient();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _isSending,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending..'),
                ),
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () async {
                      final double value =
                          double.tryParse(_valueController.text)!;
                      final transactionCreated = Transaction(
                        id: _transactionId,
                        value: value,
                        contact: widget.contact,
                      );
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) async {
                            await _save(transactionCreated, password, context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _isSending = true;
    });
    await Future.delayed(Duration(seconds: 1));
    await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureDialog('Timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      final message = e.toString();
      _showFailureDialog(message);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _isSending = false;
      });
    });
    await _showSuccessDialog();
    Navigator.pop(context, transactionCreated);
  }

  Future _showSuccessDialog() {
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return SuccessDialog('Successful transaction');
      },
    );
  }

  Future _showFailureDialog(String message) {
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(message);
      },
    );
  }
}
