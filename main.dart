import 'dart:html';
import 'bus.dart';
import 'Seat.dart';

void main() {
  // Create a new Bus object with 30 standard seats
  Bus bus = Bus();

  // Get a reference to the 'seats' div in the HTML document
  DivElement seatsDiv = querySelector('#seats') as DivElement;

  // Display the available seats in the 'seats' div
  displaySeats(seatsDiv, bus);

  // Get a reference to the 'booking-receipt' div in the HTML document
  DivElement receiptDiv = querySelector('#booking-receipt') as DivElement;

  // Create a table element and add the table headers
  TableElement table = TableElement();
  table.className = 'reserved-seats-table';
  TableRowElement headerRow = TableRowElement();
  table.append(headerRow);

  TableCellElement passengerHeader = TableCellElement();
  passengerHeader.text = 'Seat Number';
  passengerHeader.style.fontWeight = 'bold';
  headerRow.append(passengerHeader);

  TableCellElement seatHeader = TableCellElement();
  seatHeader.text = 'Passenger Name';
  seatHeader.style.fontWeight = 'bold';
  headerRow.append(seatHeader);

  // Add the table to the container element
  DivElement container = DivElement();
  container.append(table);
  document.body!.append(container);

  // Get a reference to the 'reserve' button in the HTML document
  ButtonElement reserveButton =
      querySelector('#reserve-button') as ButtonElement;

  // Add a click event listener to the 'reserve' button
  reserveButton.onClick.listen((event) {
    // Get the selected seat from the input field
    InputElement seatInput = querySelector('#seat-input') as InputElement;
    String selectedSeat = seatInput.value!.toUpperCase(); // ! null check operator because seat cannot be null
    InputElement nameInput = querySelector('#name-input') as InputElement;
    String selectedName = nameInput.value!.toUpperCase();

    if (selectedName.isEmpty || selectedSeat.isEmpty) {
      window.alert('Error! Please enter a name and a seat.');
      return; // Exit the function
    }

    // Attempt to reserve the selected seat
    bool success = bus.reserveSeat(selectedSeat, selectedName);

    // If the seat was reserved successfully, update the display
    if (success) {
      displaySeats(seatsDiv, bus);
      printTicket(
          receiptDiv,
          selectedName,
          selectedSeat,
          bus.getSeat(selectedSeat)!.getSeatType(),
          bus.getSeat(selectedSeat)!.getSeatPrice());

      // Call the displayReservedSeats function to populate the table with reserved seats
      displayReservedSeats(table, bus, selectedName, selectedSeat);

      // Clear the input field
      nameInput.value = '';
      seatInput.value = '';
    } else {
      // Otherwise, display an error message
      window.alert('Error! Please select another seat.');

      // Clear the input field
      seatInput.value = '';
    }
  });
}

void displaySeats(DivElement seatsDiv, Bus bus) {
  // Clear the seats div
  seatsDiv.children.clear();

  // Create a table element to display the seats
  TableElement seatsTable = TableElement();

  // Add a row for each group of 3 rows of seats on the bus
  for (int i = 0; i < bus.seats.length; i += 3) {
    // Create a new table row to hold the 3 rows of seats
    TableRowElement row = TableRowElement();

    // Add a cell for each seat in each row of seats
    for (int j = i; j < i + 3 && j < bus.seats.length; j++) {
      for (Seat seat in bus.seats[j]) {
        // Create a new table cell to hold the seat number
        TableCellElement cell = TableCellElement();

        // Set the cell text to the seat number and color based on availability
        if (seat.isReserved) {
          cell.text = 'X';
          cell.style.color = '#F9F6F0';
          cell.style.backgroundColor = '#28282B';
        } else {
          cell.text = seat.seatNumber;
          cell.style.backgroundColor = '#4CAF50';
        }
        cell.style.textAlign = 'center';

        // Add the cell to the current row
        row.children.add(cell);
      }
    }
    // Add the current row to the table
    seatsTable.children.add(row);
  }
  // Add the table to the seats div
  seatsDiv.children.add(seatsTable);
}

void printTicket(Element receiptDiv, String passengerName, String seatNumber,
    String seatType, double seatPrice) {
  // Create the receipt HTML
  String receiptHTML = '''
    <h3>Ticket Detail</h3>
    <p><strong>Passenger  Name:</strong> $passengerName</p>
    <p><strong>Seat Number:</strong> $seatNumber</p>
    <p><strong>Seat Type:</strong> $seatType</p>
    <p><strong>Seat Price:</strong> RM${seatPrice.toStringAsFixed(2)}</p>
  
    <hr/><h3>Reserved Seats</h3>
  ''';

  // Display the receipt in the receiptDiv element
  receiptDiv.innerHtml = receiptHTML;
}

void displayReservedSeats(TableElement table, Bus bus, String name, String seatnum) {

  TableElement reservedSeatsTable = TableElement();
  reservedSeatsTable.classes.add('reserved-seats-table');

  // Create a table row for each reserved seat
  TableRowElement seatRow = TableRowElement();
  table.append(seatRow);

  // Create a cell for the seat number
  TableCellElement seatCell = TableCellElement();
  seatCell.text = seatnum;
  seatRow.append(seatCell);

  // Create a cell for the passenger name
  TableCellElement passengerCell = TableCellElement();
  passengerCell.text = name;
  seatRow.append(passengerCell);
}
