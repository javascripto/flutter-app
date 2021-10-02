import 'dart:io';
import './app_database_linux.dart' as linux;
import './app_database_mobile.dart' as mobile;
import 'package:flutter_app/models/contact.dart';

final bool supportsSqLite = Platform.isAndroid ||
    Platform.isIOS ||
    Platform.isMacOS ||
    Platform.isFuchsia;

Future<int> save(Contact contact) async {
  return supportsSqLite ? mobile.save(contact) : linux.save(contact);
}

Future<List<Contact>> findAll() async {
  return supportsSqLite ? mobile.findAll() : linux.findAll();
}

Future<Contact?> find(int id) async {
  return supportsSqLite ? mobile.find(id) : linux.find(id);
}

Future<int> delete(int id) async {
  return supportsSqLite ? mobile.delete(id) : linux.delete(id);
}
