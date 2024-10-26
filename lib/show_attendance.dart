import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatelessWidget {
  final String eventName;
  final String filePath;

  ViewAttendanceScreen({required this.eventName, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance for $eventName'),
      ),
      body: Center(
        child: Text('Attendance records saved at: $filePath'),
      ),
    );
  }
}
