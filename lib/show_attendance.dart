// import 'package:flutter/material.dart';
//
// class ViewAttendanceScreen extends StatelessWidget {
//   final String eventName;
//   final String filePath;
//
//   ViewAttendanceScreen({required this.eventName, required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance for $eventName'),
//       ),
//       body: Center(
//         child: Text('Attendance records saved at: $filePath'),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:open_file/open_file.dart'; // Import the open_file package

class ViewAttendanceScreen extends StatefulWidget {
  final String eventName;
  final String filePath;

  ViewAttendanceScreen({required this.eventName, required this.filePath});

  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  List<List<dynamic>>? _attendanceData;

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
  }

  Future<void> _loadAttendanceData() async {
    final directory = await getApplicationDocumentsDirectory();
    String fullPath = '${directory.path}/${widget.filePath}';
    var file = File(fullPath);

    if (await file.exists()) {
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      List<List<dynamic>> attendanceList = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          attendanceList.add(row.map((cell) => cell?.value).toList());
        }
      }

      setState(() {
        _attendanceData = attendanceList;
      });
    } else {
      setState(() {
        _attendanceData = [];
      });
    }
  }

  void _openExcelFile() async {
    final directory = await getApplicationDocumentsDirectory();
    String fullPath = '${directory.path}/${widget.filePath}';
    OpenFile.open(fullPath); // Open the Excel file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance for ${widget.eventName}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openExcelFile, // Open the Excel file when clicked
              child: Text('Open Attendance Sheet'),
            ),
            _attendanceData == null
                ? CircularProgressIndicator()
                : _attendanceData!.isEmpty
                ? Text('No attendance records found.')
                : Expanded(
              child: ListView.builder(
                itemCount: _attendanceData!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${_attendanceData![index][0]} - ${_attendanceData![index][1]} - ${_attendanceData![index][2]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
