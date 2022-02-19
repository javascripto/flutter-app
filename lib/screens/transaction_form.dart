import 'package:flutter/material.dart';
import 'package:flutter_app/components/response_dialog.dart';
import 'package:flutter_app/components/transaction_auth_dialog.dart';
import 'package:flutter_app/http/webclients/transaction_webclient.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm({required this.contact});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final _webClient = TransactionWebClient();

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
    await Future.delayed(Duration(seconds: 1));
    _webClient.save(transactionCreated, password).then(
      (transaction) {
        showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successful transaction');
          },
        ).then((value) {
          Navigator.pop(context, transactionCreated);
        });
      },
    ).catchError(
      (e) {
        showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(e.message);
          },
        );
      },
      test: (e) => e is Exception,
    );
  }
}
