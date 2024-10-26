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

    var sheetObject = excel.sheets[excel.getDefaultSheet()!];
    if (sheetObject == null) {
      sheetObject = excel['Attendance'];
    }

    if (sheetObject.rows.isEmpty) {
      sheetObject.appendRow(['Name', 'Roll Number', 'Department']);
    }

    sheetObject.appendRow([name, rollNumber, department]);

    file.writeAsBytesSync(excel.save()!);
  }

  void _showConfirmDialog() {
    List<String> dataParts = scannedData.split(',');
    if (dataParts.length >= 3) {
      String name = dataParts[0].replaceFirst(RegExp(r'^Name:\s*'), '').trim();
      String rollNumber = dataParts[1].replaceFirst(RegExp(r'^Roll_Number:\s*'), '').trim(); // Updated regex
      String department = dataParts[2].replaceFirst(RegExp(r'^Department:\s*'), '').trim(); // Updated regex

      // Remove unwanted prefixes
      rollNumber = rollNumber.split(':').last.trim(); // Ensure we only get the value
      department = department.split(':').last.trim(); // Ensure we only get the value

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Details'),
          content: Text('Name: $name\nRoll No: $rollNumber\nDepartment: $department'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller?.resumeCamera();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await saveAttendanceToExcel(name, rollNumber, department);
                Navigator.of(context).pop();
                controller?.resumeCamera();
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
