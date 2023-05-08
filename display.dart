import 'dart:io';
import 'bus.dart';
// import 'reservations.dart';

class Display {
  bool menu_status = false;
  // Reservations res = new Reservations();
    
  mainmenu() {
    Bus bus = Bus();

    print('''
  
  WELCOME TO BUS TICKET REGISTRATION SYSTEM!
    ''');

    while (true) {
      print('''
  1. Display available seats
  2. Reserve a seat
  3. Exit
    ''');
      String choice = stdin.readLineSync()!;
      if (choice == '1') {
        bus.displaySeats();
      } else if (choice == '2') {
        print('Enter seat number (e.g. 1A):');
        String seatNumber = stdin.readLineSync()!;
        print('Enter passenger name:');
        String passengerName = stdin.readLineSync()!;
        bus.reserveSeat(seatNumber, passengerName);
      } else if (choice == '3') {
        break;
      }
      print('');
    }
  }
}
