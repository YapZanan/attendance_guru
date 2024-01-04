import 'dart:async';

class GetDay {
  // Controller to update the widget
  final StreamController<String> _timeController = StreamController<String>();

  // Stream for the updated time
  Stream<String> get timeStream => _timeController.stream;

  // Function to update the time
  void updateTime() {
    _timeController.add(getCurrentDay());
  }

  String getCurrentDay() {
    DateTime now = DateTime.now();

    // List of month names
    List<String> monthNames = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    // Get the month name
    String monthName = monthNames[now.month - 1];

    // Format day and year as before
    String formattedDay = now.day.toString().padLeft(2, '0');
    String formattedYear = now.year.toString().padLeft(2, '0');

    // Return the formatted date
    return '$formattedDay $monthName $formattedYear';
  }


  // Start updating the time every second
  void startUpdatingTime() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  // Dispose the stream controller when it's no longer needed
  void dispose() {
    _timeController.close();
  }
}