class Contact {
  int? id;
  String name;
  int? accountNumber;

  Contact({this.id, this.name = '', this.accountNumber});

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }
}
