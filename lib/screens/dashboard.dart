import 'package:flutter/material.dart';
import 'package:flutter_app/screens/contacts_list.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';
import 'package:flutter_app/screens/transactions_list.dart';

teste() {}

class Dashboard extends StatelessWidget {
  void _navigateTo(BuildContext context, Widget Function() widgetFactoryFn) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (builder) => widgetFactoryFn()),
    );
  }

  void _navigateToTransfers(BuildContext context) async {
    // await contactDAO.seed();
    _navigateTo(context, () => ContactsList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem(
                  name: 'Transfer',
                  icon: Icons.monetization_on,
                  onTap: () => _navigateToTransfers(context),
                ),
                _FeatureItem(
                  name: 'Transaction Feed',
                  icon: Icons.description,
                  onTap: () => _navigateTo(context, () => TransactionsList()),
                ),
                _FeatureItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  static _onTap() {}

  final void Function()? onTap;
  final IconData? icon;
  final String name;

  _FeatureItem({this.onTap = _onTap, this.name = '', this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 150,
            height: 100,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
