import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool _isCheckedIn = false;
  late DateTime _checkInTime;
  late DateTime _checkOutTime;

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
                        'You are checked in at ${DateFormat('hh:mm a').format(_checkInTime)}',
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
    setState(() {
      _isCheckedIn = true;
      _checkInTime = DateTime.now();
    });
  }

  void _handleCheckOut() {
    setState(() {
      _isCheckedIn = false;
      _checkOutTime = DateTime.now();
    });
    _showDialog();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attendance Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'You checked in at ${DateFormat('hh:mm a').format(_checkInTime)}'),
              Text(
                  'You checked out at ${DateFormat('hh:mm a').format(_checkOutTime)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
