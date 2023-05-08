import 'Seat.dart';

class Bus implements Iterable<Bus> {
  List<Seat> seats = [];

  Bus() {
    // Create 10 single seats and 10 double seats
    for (int i = 1; i <= 10; i++) {
      seats.add(Seat('${i}A', 'Single', false, 50.00));
      seats.add(Seat('${i}B', 'Double-Aisle ', false, 30.00));
      seats.add(Seat('${i}C', 'Double-Window ', false, 40.00));
    }
  }

  void displaySeats() {
    print('''
  Seat A: Single [RM 50]
  Seat B: Double-Aisle [RM 30]
  Seat C: Double-Window [RM 40]
  ''');
    print('Seating Arrangement:');
    for (int row = 1; row <= 10; row++) {
      String rowString = '';
      for (int col = 1; col <= 4; col++) {
        String seatNumber = '${row}${String.fromCharCode(col + 64)}';
        Seat seat = seats.firstWhere((seat) => seat.seatNumber == seatNumber);
        if (seat.isReserved) {
          rowString += '[X] ';
        } else {
          rowString += '${[seat.seatNumber]} ';
        }
      }
      print(rowString);
    }
  }

 // Reserve a seat for the given passenger name
  bool reserveSeat(String seatNumber, String passengerName) {
    // Check if seatNumber input is numeric
    if (num.tryParse(seatNumber) != null) {
      print('Error: Seat number must be text only.');
      return false;
    }

    // Check if passengerName input is numeric
    if (num.tryParse(passengerName) != null) {
      print('Error: Passenger name must be text only.');
      return false;
    }

    for (int i = 0; i < seats.length; i++) {
      if (seats[i].seatNumber == seatNumber) {
        if (seats[i].isReserved) {
          print(
              'Seat $seatNumber is already reserved. Please choose a different seat.');
          return false;
        } else {
          seats[i].isReserved = true;
          print(
              'Seat ${seats[i].seatNumber} (${seats[i].seatType}) reserved for $passengerName.');
          print('Seat cost: RM${seats[i].seatPrice}');
          return true;
        }
      }
    }
    print(
        'Invalid seat number. Please choose a seat from the available seats list.');
    return false;
  }

  List<Seat> getSeats() => seats;

  Seat? getSeat(String seatNumber) {
    for (Seat seat in seats) {
      if (seat.getSeatNumber() == seatNumber) {
        return seat;
      }
    }
    return null;
  }

  @override
  Iterator<Bus> get iterator => <Bus>[this].iterator;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
