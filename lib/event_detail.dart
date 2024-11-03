// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'qr_scanner.dart'; // Import QRScannerPage
// import 'show_attendance.dart'; // Import AttendanceViewPage
//
// class EventDetailPage extends StatefulWidget {
//   final String eventName;
//   final String venue;
//   final String eventId;
//   final String filePath;// Event ID for referencing file path
//
//   EventDetailPage({
//     required this.eventName,
//     required this.venue,
//     required this.eventId,
//     required this.filePath,
//   });
//
//   @override
//   _EventDetailPageState createState() => _EventDetailPageState();
// }
//
// class _EventDetailPageState extends State<EventDetailPage> {
//   final TextEditingController _eventNameController = TextEditingController();
//   final TextEditingController _venueController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _eventNameController.text = widget.eventName;
//     _venueController.text = widget.venue;
//   }
//
//   void _updateEvent() async {
//     if (_eventNameController.text.isNotEmpty && _venueController.text.isNotEmpty) {
//       await FirebaseFirestore.instance.collection('events').doc(widget.eventId).update({
//         'eventName': _eventNameController.text,
//         'venue': _venueController.text,
//       });
//       Navigator.pop(context); // Go back to the previous page
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Event')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _eventNameController,
//               decoration: InputDecoration(labelText: 'Event Name'),
//             ),
//             TextField(
//               controller: _venueController,
//               decoration: InputDecoration(labelText: 'Venue'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _updateEvent,
//               child: Text('Save Changes'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => QRScannerPage(
//                       eventName: widget.eventName,
//                       venue: widget.venue,
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
//                       eventName: widget.eventName,
//                       filePath: widget.eventId, // Using event ID as file path
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'qr_scanner.dart'; // Import QRScannerPage
import 'show_attendance.dart'; // Import AttendanceViewPage

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final String venue;
  final String eventId;
  final String filePath; // Event ID for referencing file path

  EventDetailPage({
    required this.eventName,
    required this.venue,
    required this.eventId,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Event Name: $eventName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Venue: $venue',
              style: TextStyle(fontSize: 18),
            ),
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
                      filePath: eventId, // Using event ID as file path
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
