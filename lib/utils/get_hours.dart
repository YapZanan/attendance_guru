import 'dart:async';

class GetTime {
  // Controller to update the widget
  final StreamController<String> _timeController = StreamController<String>();

  // Stream for the updated time
  Stream<String> get timeStream => _timeController.stream;

  // Function to update the time
  void updateTime() {
    _timeController.add(getCurrentTime());
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedHour = now.hour.toString().padLeft(2, '0');
    String formattedMinute = now.minute.toString().padLeft(2, '0');
    String formattedSecond = now.second.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute:$formattedSecond';
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