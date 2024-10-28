// import 'package:flutter/material.dart';
// import 'qr_scanner.dart'; // Import QRScannerPage
// import 'show_attendance.dart'; // Import AttendanceViewPage
//
// class EventDetailPage extends StatelessWidget {
//   final String eventName;
//   final String venue;
//   final String filePath; // Add this line
//
//   EventDetailPage({required this.eventName, required this.venue, required this.filePath}); // Update constructor
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(eventName)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
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
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ViewAttendanceScreen(
//                       eventName: eventName,
//                       filePath: filePath, // Pass the filePath here
//                     ),
//                   ),
//                 );
//               },
//               child: Text('View Attendance'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'qr_scanner.dart'; // Import QRScannerPage
import 'show_attendance.dart'; // Import AttendanceViewPage

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final String venue;
  final String filePath; // Added filePath as a required parameter

  EventDetailPage({
    required this.eventName,
    required this.venue,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAttendanceScreen(
                      eventName: eventName,
                      filePath: filePath, // Pass the filePath
                    ),
                  ),
                );
              },
              child: Text('View Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
