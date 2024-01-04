import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class GetData {

  static Future<String?> getData(String path) async {
    Completer<String?> completer = Completer<String?>();

    try {
      DatabaseReference roleRef = FirebaseDatabase.instance.ref(path);

      roleRef.onValue.listen((DatabaseEvent event){
        String data = event.snapshot.value.toString();

        // Complete the Future when data is available
        completer.complete(data);
      });

      // Return the Future from the Completer
      return completer.future;

    } catch (e) {
      // Handle errors (e.g., user not found, database error)
      print('Error getting user role: $e');
      return null;
    }
  }
}
