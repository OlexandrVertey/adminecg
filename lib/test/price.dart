class Price {
  Price({this.mrp, this.currency});

  final double? mrp;
  final String? currency;

  String get representablePrice => '$currency$mrp';
}
