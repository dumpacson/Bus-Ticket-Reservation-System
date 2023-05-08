class Seat implements Iterable<Seat> {
  String seatNumber;
  String seatType;
  bool isReserved;
  double seatPrice;
  String? _passengerName; // private field for passenger name

  Seat(this.seatNumber, this.seatType, this.isReserved, this.seatPrice);

  String? get passengerName => _passengerName;

  getSeatType() => seatType;

  getSeatPrice() => seatPrice;

  String? getPassengerName() => _passengerName;

  getSeatNumber() => seatNumber;

  @override
  Iterator<Seat> get iterator => <Seat>[this].iterator;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

