import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final WebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://your-backend-server-url');
  bool _isCheckedIn = false;
  DateTime _checkInTime;

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isCheckedIn
                ? Column(
                    children: [
                      Text(
                        'You are checked in at ${_checkInTime.toIso8601String()}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _handleCheckOut,
                        child: Text('Check Out'),
                      )
                    ],
                  )
                : ElevatedButton(
                    onPressed: _handleCheckIn,
                    child: Text('Check In'),
                  ),
          ],
        ),
      ),
    );
  }

  void _handleCheckIn() {
    // Use your barcode scanner or NFC reader to identify the user
    String userId = 'user123';
    DateTime checkInTime = DateTime.now();

    // Send the check-in message to the backend system
    Map<String, dynamic> checkInMessage = {
      'userId': userId,
      'checkInTime': checkInTime.toIso8601String()
    };
    _channel.sink.add(jsonEncode(checkInMessage));

    // Update the UI
    setState(() {
      _isCheckedIn = true;
      _checkInTime = checkInTime;
    });
  }

  void _handleCheckOut() {
    // Use your barcode scanner or NFC reader to identify the user
    String userId = 'user123';
    DateTime checkOutTime = DateTime.now();

    // Send the check-out message to the backend system
    Map<String, dynamic> checkOutMessage = {
      'userId': userId,
      'checkOutTime': checkOutTime.toIso8601String()
    };
    _channel.sink.add(jsonEncode(checkOutMessage));

    // Update the UI
    setState(() {
      _isCheckedIn = false;
    });
  }
}
