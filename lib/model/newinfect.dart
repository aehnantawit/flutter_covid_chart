class NewInfect {
  final String date;
  final int total;

  NewInfect({this.date, this.total});

  factory NewInfect.fromJson(Map<String, dynamic> json) {
    return NewInfect(
      date: json['Date'],
      total: json['NewConfirmed'],
    );
  }
}