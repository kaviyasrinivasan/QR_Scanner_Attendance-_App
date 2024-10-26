// // import 'package:flutter/material.dart';
// // import 'qr_scanner.dart';
// // import 'show_attendance.dart';
// //
// // class EventDetailPage extends StatelessWidget {
// //   final String eventName;
// //   final String venue;
// //   final String filePath; // Add filePath here
// //
// //   EventDetailPage({
// //     required this.eventName,
// //     required this.venue,
// //     required this.filePath, // Accept filePath in the constructor
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Event: $eventName'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: <Widget>[
// //             Text('Venue: $venue'),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => QRScannerPage(
// //                       eventName: eventName,
// //                       venue: venue,
// //                       // Pass the filePath here if needed for scanning logic
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: Text('Scan Attendance'),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ViewAttendanceScreen(
// //                       eventName: eventName,
// //                       filePath: filePath, // Pass filePath here
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: Text('View Attendance'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart'; // To open the Excel file
// import 'qr_scanner.dart';
//
// class EventDetailPage extends StatelessWidget {
//   final String eventName;
//   final String venue;
//   final String filePath; // Add filePath here
//
//   EventDetailPage({
//     required this.eventName,
//     required this.venue,
//     required this.filePath, // Accept filePath in the constructor
//   });
//
//   // Function to open the Excel file
//   void openAttendanceFile(String filePath) async {
//     final result = await OpenFile.open(filePath);
//     if (result.type != ResultType.done) {
//       print('Error opening file: ${result.message}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event: $eventName'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text('Venue: $venue'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => QRScannerPage(
//                       eventName: eventName,
//                       venue: venue,
//                     ),
//                   ),
//                 );
//               },
//               child: Text('Scan Attendance'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 openAttendanceFile(filePath); // Open Excel when clicking View Attendance
//               },
//               child: Text('View Attendance'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart'; // To open the Excel file
// import 'package:path_provider/path_provider.dart';
// import 'qr_scanner.dart';
//
// class EventDetailPage extends StatelessWidget {
//   final String eventName;
//   final String venue;
//   final String filePath; // Add filePath here
//
//   EventDetailPage({
//     required this.eventName,
//     required this.venue,
//     required this.filePath, // Accept filePath in the constructor
//   });
//
//   Future<String> getExcelFilePath() async {
//     final directory = await getApplicationDocumentsDirectory();
//     String fileName = '${eventName}_attendance.xlsx'; // Use eventName directly
//     return '${directory.path}/$fileName';
//   }
//
//   // Function to open the Excel file
//   void openAttendanceFile() async {
//     String excelFilePath = await getExcelFilePath(); // Fetch the file path first
//     final result = await OpenFile.open(excelFilePath); // Open the file with the correct path
//
//     if (result.type != ResultType.done) {
//       print('Error opening file: ${result.message}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event: $eventName'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text('Venue: $venue'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => QRScannerPage(
//                       eventName: eventName,
//                       venue: venue,
//                     ),
//                   ),
//                 );
//               },
//               child: Text('Scan Attendance'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: openAttendanceFile, // Call openAttendanceFile when the button is pressed
//               child: Text('View Attendance'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart'; // To open the Excel file
import 'package:path_provider/path_provider.dart';
import 'qr_scanner.dart';

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final String venue;

  EventDetailPage({
    required this.eventName,
    required this.venue, required String filePath,
  });

  Future<String> getExcelFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    String fileName = '${eventName}_attendance.xlsx'; // Use eventName directly
    return '${directory.path}/$fileName';
  }

  // Function to open the Excel file
  void openAttendanceFile(BuildContext context) async {
    String excelFilePath = await getExcelFilePath(); // Fetch the file path first
    final result = await OpenFile.open(excelFilePath); // Open the file with the correct path

    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: ${result.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event: $eventName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Venue: $venue'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScannerPage(
                      eventName: eventName,
                      venue: venue,
                    ),
                  ),
                );
              },
              child: Text('Scan Attendance'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => openAttendanceFile(context), // Open Excel when clicking View Attendance
              child: Text('View Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
