// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
//
// class QRScannerPage extends StatefulWidget {
//   final String eventName;
//   final String venue;
//
//   QRScannerPage({required this.eventName, required this.venue});
//
//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }
//
// class _QRScannerPageState extends State<QRScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String scannedData = '';
//   String? filePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _setFilePath(); // Ensure the file path is set when the page initializes
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   void _onQRViewCreated(QRViewController qrController) {
//     this.controller = qrController;
//     qrController.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedData = scanData.code!;
//       });
//       qrController.pauseCamera(); // Pause the camera after scanning
//       _showConfirmDialog();
//     });
//   }
//
//   Future<void> _setFilePath() async {
//     final directory = await getExternalStorageDirectory();
//     final appFolder = Directory('${directory!.path}/com.example.qr_scanner_app');
//
//     // Ensure the directory exists
//     if (!(await appFolder.exists())) {
//       await appFolder.create(recursive: true);
//     }
//
//     // Set the file path for the attendance Excel file
//     filePath = '${appFolder.path}/attendance_${widget.eventName}.xlsx';
//   }
//
//   Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
//     var file = File(filePath!);
//     var bytes = file.existsSync() ? file.readAsBytesSync() : null;
//     var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();
//
//     // Check for existing sheets or create a new one
//     var sheetObject = excel.sheets[excel.getDefaultSheet()!];
//     if (sheetObject == null) {
//       sheetObject = excel['Attendance'] ?? excel.addSheet('Attendance');
//     }
//
//     if (sheetObject.rows.isEmpty) {
//       sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
//     }
//
//     // Append the new attendance data
//     sheetObject.appendRow([name, rollNumber, department]);
//
//     // Save the changes to the Excel file
//     final excelBytes = excel.save() ?? [];
//     await file.writeAsBytes(excelBytes);
//   }
//
//   void _showConfirmDialog() {
//     List<String> dataParts = scannedData.split(',');
//     if (dataParts.length >= 3) {
//       String name = dataParts[0].replaceFirst(RegExp(r'^Name:\s*'), '').trim();
//       String rollNumber = dataParts[1].replaceFirst(RegExp(r'^Roll_Number:\s*'), '').trim();
//       String department = dataParts[2].replaceFirst(RegExp(r'^Department:\s*'), '').trim();
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Confirm Details'),
//           content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 controller?.resumeCamera(); // Resume scanning
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await saveAttendanceToExcel(name, rollNumber, department);
//                 Navigator.of(context).pop(); // Close the dialog
//                 controller?.resumeCamera(); // Resume scanning
//               },
//               child: Text('Confirm'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Scan QR Code for ${widget.eventName}')),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text('Scanning for event: ${widget.eventName} at ${widget.venue}'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
//
// class QRScannerPage extends StatefulWidget {
//   final String eventName;
//   final String venue;
//
//   QRScannerPage({required this.eventName, required this.venue});
//
//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }
//
// class _QRScannerPageState extends State<QRScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String scannedData = '';
//   String? filePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _setFilePath(); // Ensure the file path is set when the page initializes
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   void _onQRViewCreated(QRViewController qrController) {
//     this.controller = qrController;
//     qrController.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedData = scanData.code!;
//       });
//       qrController.pauseCamera(); // Pause the camera after scanning
//       _showConfirmDialog();
//     });
//   }
//
//   Future<void> _setFilePath() async {
//     final directory = await getExternalStorageDirectory();
//     final appFolder = Directory('${directory!.path}/com.example.qr_scanner_app');
//
//     // Ensure the directory exists
//     if (!(await appFolder.exists())) {
//       await appFolder.create(recursive: true);
//     }
//
//     // Set the file path for the attendance Excel file
//     filePath = '${appFolder.path}/attendance_${widget.eventName}.xlsx';
//   }
//
//   Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
//     var file = File(filePath!);
//     var bytes = file.existsSync() ? file.readAsBytesSync() : null;
//     var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();
//
//     // Access or create the 'Attendance' sheet
//     var sheetObject = excel['Attendance'];
//     if (sheetObject == null) {
//       sheetObject = excel['Attendance']; // This will create 'Attendance' sheet if it doesn't exist
//     }
//
//     // Check if the sheet is empty and add headers if necessary
//     if (sheetObject.rows.isEmpty) {
//       sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
//     }
//
//     // Append the new attendance data
//     sheetObject.appendRow([name, rollNumber, department]);
//
//     // Save the changes to the Excel file
//     final excelBytes = excel.save() ?? [];
//     await file.writeAsBytes(excelBytes);
//   }
//
//   void _showConfirmDialog() {
//     List<String> dataParts = scannedData.split(',');
//     if (dataParts.length >= 3) {
//       String name = dataParts[0].replaceFirst(RegExp(r'^Name:\s*'), '').trim();
//       String rollNumber = dataParts[1].replaceFirst(RegExp(r'^Roll_Number:\s*'), '').trim();
//       String department = dataParts[2].replaceFirst(RegExp(r'^Department:\s*'), '').trim();
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Confirm Details'),
//           content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 controller?.resumeCamera(); // Resume scanning
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await saveAttendanceToExcel(name, rollNumber, department);
//                 Navigator.of(context).pop(); // Close the dialog
//                 controller?.resumeCamera(); // Resume scanning
//               },
//               child: Text('Confirm'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   // Function to view attendance Excel file
//   Future<void> viewAttendance() async {
//     if (filePath == null) {
//       await _setFilePath(); // Ensure filePath is set
//     }
//
//     var file = File(filePath!);
//
//     if (await file.exists()) {
//       OpenFile.open(filePath); // Open the file if it exists
//     } else {
//       // Show an error message if the file doesn't exist
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('File Not Found'),
//           content: Text('Attendance file not found. Please check the file path or save attendance first.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code for ${widget.eventName}'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.folder_open),
//             onPressed: viewAttendance, // Button to view attendance
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text('Scanning for event: ${widget.eventName} at ${widget.venue}'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class QRScannerPage extends StatefulWidget {
  final String eventName;
  final String venue;

  QRScannerPage({required this.eventName, required this.venue});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedData = '';
  String? filePath;

  @override
  void initState() {
    super.initState();
    _setFilePath(); // Ensure the file path is set when the page initializes
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    this.controller = qrController;
    qrController.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code!;
      });
      qrController.pauseCamera(); // Pause the camera after scanning
      _showConfirmDialog();
    });
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
    print('Excel file path: $filePath');
  }

  Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
    var file = File(filePath!);
    var bytes = file.existsSync() ? file.readAsBytesSync() : null;
    var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();

    // Access or create the 'Attendance' sheet
    var sheetObject = excel['Attendance'];
    if (sheetObject == null) {
      sheetObject = excel['Attendance']; // This will create 'Attendance' sheet if it doesn't exist
    }

    // Check if the sheet is empty and add headers if necessary
    if (sheetObject.rows.isEmpty) {
      sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
    }

    // Append the new attendance data
    sheetObject.appendRow([name, rollNumber, department]);

    // Save the changes to the Excel file
    final excelBytes = excel.save() ?? [];
    await file.writeAsBytes(excelBytes);
  }

  void _showConfirmDialog() {
    List<String> dataParts = scannedData.split(',');

    if (dataParts.length >= 3) {
      // Parse each part and remove the prefix as needed
      String name = dataParts[0].split(':').last.trim();         // Extract name value only
      String rollNumber = dataParts[1].split(':').last.trim();   // Extract roll number value only
      String department = dataParts[2].split(':').last.trim();   // Extract department value only

      // Debugging output to verify parsed values
      print("Parsed Name: $name");
      print("Parsed Roll Number: $rollNumber");
      print("Parsed Department: $department");

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Details'),
          content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                controller?.resumeCamera(); // Resume scanning
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await saveAttendanceToExcel(name, rollNumber, department);
                Navigator.of(context).pop(); // Close the dialog
                controller?.resumeCamera(); // Resume scanning
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      print("Error: Scanned data is not in the expected format.");
    }
  }

  // Function to view attendance Excel file
  Future<void> viewAttendance() async {
    if (filePath == null) {
      await _setFilePath(); // Ensure filePath is set
    }

    var file = File(filePath!);

    if (await file.exists()) {
      OpenFile.open(filePath); // Open the file if it exists
    } else {
      // Show an error message if the file doesn't exist
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('File Not Found'),
          content: Text('Attendance file not found. Please check the file path or save attendance first.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code for ${widget.eventName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.folder_open),
            onPressed: viewAttendance, // Button to view attendance
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scanning for event: ${widget.eventName} at ${widget.venue}'),
            ),
          ),
        ],
      ),
    );
  }
}


