// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
//
// class ViewAttendanceScreen extends StatefulWidget {
//   final String eventName;
//   final String filePath;
//
//   ViewAttendanceScreen({required this.eventName, required this.filePath});
//
//   @override
//   _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
// }
//
// class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
//   List<List<dynamic>>? _attendanceData;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAttendanceData();
//   }
//
//   Future<void> _loadAttendanceData() async {
//     var file = File(widget.filePath);
//
//     if (await file.exists()) {
//       var bytes = file.readAsBytesSync();
//       var excel = Excel.decodeBytes(bytes);
//       List<List<dynamic>> attendanceList = [];
//
//       for (var table in excel.tables.keys) {
//         for (var row in excel.tables[table]!.rows) {
//           attendanceList.add(row.map((cell) => cell?.value ?? '').toList());
//         }
//       }
//
//       setState(() {
//         _attendanceData = attendanceList;
//       });
//     } else {
//       setState(() {
//         _attendanceData = [];
//       });
//     }
//   }
//
//   void _openExcelFile() async {
//     OpenFile.open(widget.filePath);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Attendance for ${widget.eventName}')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ElevatedButton(
//             onPressed: _openExcelFile,
//             child: Text('Open Attendance Sheet'),
//           ),
//           Expanded(
//             child: _attendanceData == null
//                 ? Center(child: CircularProgressIndicator())
//                 : _attendanceData!.isEmpty
//                 ? Center(child: Text('No attendance records found.'))
//                 : ListView.builder(
//               itemCount: _attendanceData!.length,
//               itemBuilder: (context, index) {
//                 var row = _attendanceData![index];
//                 return ListTile(
//                   title: Text(
//                     '${row[0] ?? ''} - ${row[1] ?? ''} - ${row[2] ?? ''}',
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String eventName;

  ViewAttendanceScreen({required this.eventName, required String filePath});

  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  List<List<dynamic>>? _attendanceData;
  late String filePath;

  @override
  void initState() {
    super.initState();
    _setFilePath();
  }

  Future<void> _setFilePath() async {
    final directory = await getExternalStorageDirectory();
    final appFolder = Directory('${directory!.path}/com.example.qr_scanner_app');

    // Ensure the directory exists
    if (!(await appFolder.exists())) {
      await appFolder.create(recursive: true);
    }

    // Set the file path for the attendance Excel file
    filePath = '${appFolder.path}/attendance_${widget.eventName}.xlsx';
    _loadAttendanceData();
  }

  Future<void> _loadAttendanceData() async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        var bytes = await file.readAsBytes();
        var excel = Excel.decodeBytes(bytes);
        List<List<dynamic>> attendanceList = [];

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            attendanceList.add(row.map((cell) => cell?.value ?? '').toList());
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
    } catch (e) {
      print('Error loading attendance data: $e');
      setState(() {
        _attendanceData = [];
      });
    }
  }

  Future<void> _openExcelFile() async {
    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the file. Please check the file path.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance for ${widget.eventName}')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _openExcelFile,
              child: Text('Open Attendance Sheet'),
            ),
          ),
          Expanded(
            child: _attendanceData == null
                ? Center(child: CircularProgressIndicator())
                : _attendanceData!.isEmpty
                ? Center(child: Text('No attendance records found.'))
                : ListView.builder(
              itemCount: _attendanceData!.length,
              itemBuilder: (context, index) {
                var row = _attendanceData![index];
                return ListTile(
                  title: Text(
                    '${row[0] ?? 'No Name'} - ${row[1] ?? 'No Roll Number'} - ${row[2] ?? 'No Timestamp'}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

