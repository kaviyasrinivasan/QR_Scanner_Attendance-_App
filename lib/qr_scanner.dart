// // import 'package:flutter/material.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
// // import 'package:excel/excel.dart';
// // import 'dart:io';
// // import 'package:path_provider/path_provider.dart';
// //
// // class QRScannerPage extends StatefulWidget {
// //   final String eventName;
// //   final String venue;
// //
// //   QRScannerPage({required this.eventName, required this.venue});
// //
// //   @override
// //   _QRScannerPageState createState() => _QRScannerPageState();
// // }
// //
// // class _QRScannerPageState extends State<QRScannerPage> {
// //   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// //   QRViewController? controller;
// //   Barcode? result;
// //
// //   @override
// //   void dispose() {
// //     controller?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Scan for ${widget.eventName}'),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           Expanded(
// //             flex: 5,
// //             child: QRView(
// //               key: qrKey,
// //               onQRViewCreated: _onQRViewCreated,
// //             ),
// //           ),
// //           Expanded(
// //             flex: 1,
// //             child: Center(
// //               child: (result != null)
// //                   ? Text('Data: ${result!.code}')
// //                   : Text('Scan a code'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _onQRViewCreated(QRViewController controller) {
// //     setState(() {
// //       this.controller = controller;
// //     });
// //     controller.scannedDataStream.listen((scanData) {
// //       setState(() {
// //         result = scanData;
// //       });
// //       // Assuming the scanned data is in the format "Name,Roll Number,Department"
// //       List<String> scannedData = scanData.code!.split(',');
// //       if (scannedData.length == 3) {
// //         String name = scannedData[0];
// //         String rollNumber = scannedData[1];
// //         String department = scannedData[2];
// //         _showConfirmationDialog(name, rollNumber, department);
// //       }
// //     });
// //   }
// //
// //   // Show a confirmation dialog before saving attendance
// //   Future<void> _showConfirmationDialog(String name, String rollNumber, String department) async {
// //     return showDialog<void>(
// //       context: context,
// //       barrierDismissible: false, // Prevent closing by tapping outside
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Confirm Attendance'),
// //           content: SingleChildScrollView(
// //             child: ListBody(
// //               children: <Widget>[
// //                 Text('Do you want to save the following details?'),
// //                 Text('Name: $name'),
// //                 Text('Roll Number: $rollNumber'),
// //                 Text('Department: $department'),
// //               ],
// //             ),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('Cancel'),
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //             ),
// //             TextButton(
// //               child: Text('Confirm'),
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Close the dialog
// //                 _saveAttendance(name, rollNumber, department); // Save the attendance if confirmed
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   // Save attendance data in an Excel file
// //   Future<void> _saveAttendance(String name, String rollNumber, String department) async {
// //     var excel = Excel.createExcel();
// //     var sheet = excel['Attendance'];
// //     sheet.appendRow(['Name', 'Roll Number', 'Department', 'Venue', 'Timestamp']);
// //
// //     // Insert attendance data
// //     sheet.appendRow([name, rollNumber, department, widget.venue, DateTime.now().toString()]);
// //
// //     // Save the file
// //     Directory? directory = await getExternalStorageDirectory();
// //     String filePath = '${directory!.path}/${widget.eventName}.xlsx';
// //     File(filePath)
// //       ..createSync(recursive: true)
// //       ..writeAsBytesSync(excel.encode()!);
// //
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Attendance saved for $name')),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'show_attendance.dart'; // Import the attendance view screen
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
//   Barcode? result;
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan for ${widget.eventName}'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text('Data: ${result!.code}')
//                   : Text('Scan a code'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//       // Assuming the scanned data is in the format "Name,Roll Number,Department"
//       List<String> scannedData = scanData.code!.split(',');
//       if (scannedData.length == 3) {
//         String name = scannedData[0];
//         String rollNumber = scannedData[1];
//         String department = scannedData[2];
//         _showConfirmationDialog(name, rollNumber, department);
//       }
//     });
//   }
//
//   // Show a confirmation dialog before saving attendance
//   Future<void> _showConfirmationDialog(String name, String rollNumber, String department) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Attendance'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Do you want to save the following details?'),
//                 Text('Name: $name'),
//                 Text('Roll Number: $rollNumber'),
//                 Text('Department: $department'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 _saveAttendance(name, rollNumber, department); // Save the attendance if confirmed
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Save attendance data in an Excel file and navigate to the attendance view
//   Future<void> _saveAttendance(String name, String rollNumber, String department) async {
//     var excel = Excel.createExcel();
//     var sheet = excel['Attendance'];
//     sheet.appendRow(['Name', 'Roll Number', 'Department', 'Venue', 'Timestamp']);
//
//     // Insert attendance data
//     sheet.appendRow([name, rollNumber, department, widget.venue, DateTime.now().toString()]);
//
//     // Save the file
//     Directory? directory = await getExternalStorageDirectory();
//     String filePath = '${directory!.path}/${widget.eventName}.xlsx';
//     File(filePath)
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(excel.encode()!);
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Attendance saved for $name')),
//     );
//
//     // Navigate to the attendance view page with the file path
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ViewAttendanceScreen(filePath: filePath), // Pass the file path to the view screen
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
// import 'show_attendance.dart'; // Import ViewAttendanceScreen
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
//   QRViewController? controller;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   Future<String> getExcelFilePath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     return '${directory.path}/$fileName';
//   }
//
//   Future<void> saveAttendance(List<Map<String, String>> attendanceData) async {
//     String filePath = await getExcelFilePath();
//     var excel = Excel.createExcel();
//     Sheet sheet = excel['Attendance'];
//     sheet.appendRow(['Name', 'Roll Number', 'Department']);
//
//     for (var data in attendanceData) {
//       sheet.appendRow([
//         data['name'],
//         data['rollNumber'],
//         data['department'],
//       ]);
//     }
//
//     File(filePath).writeAsBytesSync(excel.encode()!);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Attendance saved at $filePath')),
//     );
//
//     // Navigate to the View Attendance Screen with the file path
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ViewAttendanceScreen(
//           eventName: widget.eventName, // Pass the event name
//           filePath: filePath, // Pass the file path
//         ),
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       String scannedData = scanData.code!;
//       List<String> parts = scannedData.split(',');
//       if (parts.length == 3) {
//         List<Map<String, String>> attendanceData = [
//           {
//             'name': parts[0],
//             'rollNumber': parts[1],
//             'department': parts[2],
//           }
//         ];
//         saveAttendance(attendanceData);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: QRView(
//         key: GlobalKey(debugLabel: 'QR'),
//         onQRViewCreated: _onQRViewCreated,
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
// import 'show_attendance.dart';
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
//   QRViewController? controller;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   Future<String> getExcelFilePath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     return '${directory.path}/$fileName';
//   }
//
//   Future<void> saveAttendance(List<Map<String, String>> attendanceData) async {
//     String filePath = await getExcelFilePath();
//     var excel = Excel.createExcel();
//     Sheet sheet = excel['Attendance'];
//     sheet.appendRow(['Name', 'Roll Number', 'Department']);
//
//     for (var data in attendanceData) {
//       sheet.appendRow([
//         data['name'],
//         data['rollNumber'],
//         data['department'],
//       ]);
//     }
//
//     File(filePath).writeAsBytesSync(excel.encode()!);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Attendance saved at $filePath')),
//     );
//
//     // Here you can return the filePath to the EventDetailPage
//     Navigator.pop(context, filePath); // Return the file path
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       String scannedData = scanData.code!;
//       List<String> parts = scannedData.split(',');
//       if (parts.length == 3) {
//         List<Map<String, String>> attendanceData = [
//           {
//             'name': parts[0],
//             'rollNumber': parts[1],
//             'department': parts[2],
//           }
//         ];
//         saveAttendance(attendanceData);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: QRView(
//         key: GlobalKey(debugLabel: 'QR'),
//         onQRViewCreated: _onQRViewCreated,
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
//   QRViewController? controller;
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   Future<String> getExcelFilePath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     return '${directory.path}/$fileName';
//   }
//
//   Future<void> saveAttendance(List<Map<String, String>> attendanceData) async {
//     String filePath = await getExcelFilePath();
//     var excel = Excel.createExcel();
//     Sheet sheet = excel['Attendance'];
//     sheet.appendRow(['Name', 'Roll Number', 'Department']);
//
//     for (var data in attendanceData) {
//       sheet.appendRow([
//         data['name'],
//         data['rollNumber'],
//         data['department'],
//       ]);
//     }
//
//     File(filePath).writeAsBytesSync(excel.encode()!);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Attendance saved at $filePath')),
//     );
//
//     Navigator.pop(context, filePath); // Return the file path back to EventDetailPage
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       String scannedData = scanData.code!;
//       List<String> parts = scannedData.split(',');
//       if (parts.length == 3) {
//         List<Map<String, String>> attendanceData = [
//           {
//             'name': parts[0],
//             'rollNumber': parts[1],
//             'department': parts[2],
//           }
//         ];
//         saveAttendance(attendanceData);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: QRView(
//         key: GlobalKey(debugLabel: 'QR'),
//         onQRViewCreated: _onQRViewCreated,
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
//   Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     filePath = '${directory.path}/$fileName';
//
//     var file = File(filePath!);
//     var bytes = file.existsSync() ? file.readAsBytesSync() : null;
//     var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();
//
//     // Use the default sheet or create a new one
//     var sheetObject = excel.sheets[excel.getDefaultSheet()!];
//     if (sheetObject == null) {
//       sheetObject = excel['Attendance']; // If there's no default sheet, create a new one
//     }
//
//     // Write headers only if the sheet is empty
//     if (sheetObject.rows.isEmpty) {
//       sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
//     }
//
//     // Append the scanned data
//     sheetObject.appendRow([name, rollNumber, department]);
//
//     // Save to file
//     var excelBytes = excel.save();
//     file.writeAsBytesSync(excelBytes!);
//   }
//
//   // Show confirmation dialog
//   void _showConfirmDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Attendance'),
//           content: Text('Do you want to confirm the attendance for $scannedData?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 controller?.resumeCamera(); // Resume camera on cancel
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Save the attendance to Excel
//                 var dataParts = scannedData.split(',');
//                 String name = dataParts[0];
//                 String rollNumber = dataParts[1];
//                 String department = dataParts[2];
//                 saveAttendanceToExcel(name, rollNumber, department);
//
//                 Navigator.of(context).pop(); // Close dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Attendance confirmed!')),
//                 );
//               },
//               child: Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (scannedData.isNotEmpty)
//                   ? Text('Scanned Data: $scannedData')
//                   : Text('Scan a code'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
//   Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     filePath = '${directory.path}/$fileName';
//
//     var file = File(filePath!);
//     var bytes = file.existsSync() ? file.readAsBytesSync() : null;
//     var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();
//
//     // Use the default sheet or create a new one
//     var sheetObject = excel.sheets[excel.getDefaultSheet()!];
//     if (sheetObject == null) {
//       sheetObject = excel['Attendance']; // Create a new sheet if none exists
//     }
//
//     // Write headers only if the sheet is empty
//     if (sheetObject.rows.isEmpty) {
//       sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
//     }
//
//     // Append the scanned data
//     sheetObject.appendRow([name, rollNumber, department]);
//
//     // Save to file
//     var excelBytes = excel.save();
//     file.writeAsBytesSync(excelBytes!);
//   }
//
//   // Show confirmation dialog
//   void _showConfirmDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Attendance'),
//           content: Text('Do you want to confirm attendance for $scannedData?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 controller?.resumeCamera(); // Resume camera on cancel
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Split scannedData and save the attendance
//                 var dataParts = scannedData.split(','); // Expecting comma-separated values
//                 if (dataParts.length == 3) {
//                   String name = dataParts[0].trim();       // Name
//                   String rollNumber = dataParts[1].trim(); // Roll Number
//                   String department = dataParts[2].trim(); // Department
//
//                   saveAttendanceToExcel(name, rollNumber, department);
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Attendance confirmed for $name!')),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Invalid QR Code format')),
//                   );
//                 }
//
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (scannedData.isNotEmpty)
//                   ? Text('Scanned Data: $scannedData')
//                   : Text('Scan a code'),
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
//   Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${widget.eventName}_attendance.xlsx';
//     filePath = '${directory.path}/$fileName';
//
//     var file = File(filePath!);
//     var bytes = file.existsSync() ? file.readAsBytesSync() : null;
//     var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();
//
//     // Use the default sheet or create a new one
//     var sheetObject = excel.sheets[excel.getDefaultSheet()!];
//     if (sheetObject == null) {
//       sheetObject = excel['Attendance']; // Create a new sheet if none exists
//     }
//
//     // Write headers only if the sheet is empty
//     if (sheetObject.rows.isEmpty) {
//       sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
//     }
//
//     // Append the new data
//     sheetObject.appendRow([name, rollNumber, department]);
//
//     // Save the updated Excel file
//     file.writeAsBytesSync(excel.save()!);
//   }
//
//   // Confirm dialog after scanning
//   void _showConfirmDialog() {
//     List<String> dataParts = scannedData.split(',');
//     if (dataParts.length >= 3) {
//       String name = dataParts[0].trim();
//       String rollNumber = dataParts[1].trim();
//       String department = dataParts[2].trim();
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Confirm Details'),
//           content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//                 controller?.resumeCamera(); // Resume scanning
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 saveAttendanceToExcel(name, rollNumber, department); // Save to Excel
//                 Navigator.of(context).pop(); // Dismiss the dialog
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
//       appBar: AppBar(title: Text('QR Scanner')),
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
//               child: Text('Scan a QR code to save attendance.'),
//             ),
//           )
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

  Future<void> saveAttendanceToExcel(String name, String rollNumber, String department) async {
    final directory = await getApplicationDocumentsDirectory();
    String fileName = '${widget.eventName}_attendance.xlsx';
    filePath = '${directory.path}/$fileName';

    var file = File(filePath!);
    var bytes = file.existsSync() ? file.readAsBytesSync() : null;
    var excel = bytes != null ? Excel.decodeBytes(bytes) : Excel.createExcel();

    // Use the default sheet or create a new one
    var sheetObject = excel.sheets[excel.getDefaultSheet()!];
    if (sheetObject == null) {
      sheetObject = excel['Attendance']; // Create a new sheet if none exists
    }

    // Write headers only if the sheet is empty
    if (sheetObject.rows.isEmpty) {
      sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
    }

    // Append the new data
    sheetObject.appendRow([name, rollNumber, department]);

    // Save the updated Excel file
    file.writeAsBytesSync(excel.save()!);
  }

  // Confirm dialog after scanning
  void _showConfirmDialog() {
    List<String> dataParts = scannedData.split(',');
    if (dataParts.length >= 3) {
      String name = dataParts[0].trim();
      String rollNumber = dataParts[1].trim();
      String department = dataParts[2].trim();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Details'),
          content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                controller?.resumeCamera(); // Resume scanning
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                saveAttendanceToExcel(name, rollNumber, department); // Save to Excel
                Navigator.of(context).pop(); // Dismiss the dialog
                controller?.resumeCamera(); // Resume scanning
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
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
              child: Text('Scan a QR code to save attendance.'),
            ),
          )
        ],
      ),
    );
  }
}
