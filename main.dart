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
  TableRowElement headerRow = TableRowElement();
  table.append(headerRow);
  TableCellElement seatHeader = TableCellElement();
  seatHeader.text = 'Seat Number';
  seatHeader.style.fontWeight = 'bold';
  headerRow.append(seatHeader);
  TableCellElement passengerHeader = TableCellElement();
  passengerHeader.text = 'Passenger Name';
  passengerHeader.style.fontWeight = 'bold';
  headerRow.append(passengerHeader);
  // TableCellElement priceHeader = TableCellElement();
  // priceHeader.text = 'Seat Price';
  // headerRow.append(priceHeader);

  // Add the table to the container element
  DivElement container = DivElement();
  container.append(table);
  document.body!.append(container);

  // Get a reference to the 'reserve' button in the HTML document
  ButtonElement reserveButton = querySelector('#reserve-button') as ButtonElement;
  
  // Add a click event listener to the 'reserve' button
  reserveButton.onClick.listen((event) {
    // Get the selected seat from the input field
    InputElement seatInput = querySelector('#seat-input') as InputElement;
    String selectedSeat = seatInput.value!.toUpperCase(); // ! null check operator because seat cannot be null
    InputElement nameInput = querySelector('#name-input') as InputElement;
    String selectedName = nameInput.value!.toUpperCase();
    
    // Attempt to reserve the selected seat
    bool success = bus.reserveSeat(selectedSeat, selectedName);
    
    // If the seat was reserved successfully, update the display
    if (success) {
      displaySeats(seatsDiv, bus);
      printReceipt(receiptDiv, selectedName, selectedSeat, bus.getSeat(selectedSeat)!.getSeatType(), bus.getSeat(selectedSeat)!.getSeatPrice());
      // Call the displayReservedSeats function to populate the table with reserved seats
      displayReservedSeats(table, bus);

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
          cell.style.backgroundColor = 'gray';
        } else {
          cell.text = seat.seatNumber;
          cell.style.backgroundColor = 'green';
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

void printReceipt(Element receiptDiv, String passengerName, String seatNumber, String seatType, double seatPrice) {
  // Create the receipt HTML
  String receiptHTML = '''
    <h3>Ticket Detail</h3>
    <p><strong>Passenger Name:</strong> $passengerName</p>
    <p><strong>Seat Number:</strong> $seatNumber</p>
    <p><strong>Seat Type:</strong> $seatType</p>
    <p><strong>Seat Price:</strong> RM${seatPrice.toStringAsFixed(2)}</p>
  ''';

  // Display the receipt in the receiptDiv element
  receiptDiv.innerHtml = receiptHTML;
}

void displayReservedSeats(TableElement table, Bus bus) {
  // Loop through the seats in the bus
  for (Seat? seat in bus.getSeats()) {
    if (seat != null && seat.isReserved == true) {
      // Create a table row for each reserved seat
      TableRowElement seatRow = TableRowElement();
      table.append(seatRow);

      // Create a cell for the seat number
      TableCellElement seatCell = TableCellElement();
      seatCell.text = seat.getSeatNumber();
      seatRow.append(seatCell);

      // Create a cell for the passenger name
      TableCellElement passengerCell = TableCellElement();
      passengerCell.text = seat.getPassengerName() ?? '';
      seatRow.append(passengerCell);

      // TableCellElement priceCell = TableCellElement();
      // priceCell.text = seat.getSeatPrice() ?? '';
      // seatRow.append(priceCell);
    }
  }
}

