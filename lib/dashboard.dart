// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   final TextEditingController eventNameController = TextEditingController();
//   final TextEditingController venueController = TextEditingController();
//   late Box attendanceBox;
//   bool _eventSaved = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initHive();
//   }
//
//   Future<void> _initHive() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);
//     attendanceBox = await Hive.openBox('attendance');
//   }
//
//   void saveEventDetails() {
//     if (eventNameController.text.isNotEmpty && venueController.text.isNotEmpty) {
//       attendanceBox.put('eventName', eventNameController.text);
//       attendanceBox.put('venue', venueController.text);
//       setState(() {
//         _eventSaved = true; // Flag to indicate event saved
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Event details saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in both Event Name and Venue')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Event Dashboard")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: eventNameController,
//               decoration: InputDecoration(labelText: 'Event Name'),
//             ),
//             TextField(
//               controller: venueController,
//               decoration: InputDecoration(labelText: 'Venue'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: saveEventDetails,
//               child: Text("Save Event Details"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _eventSaved
//                   ? () {
//                 Navigator.pushNamed(context, '/scan');
//               }
//                   : null, // Only enabled after event is saved
//               child: Text("Scan for Attendance"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/showAttendance');
//               },
//               child: Text("Show Attendance"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'event_detail.dart'; // Import EventDetailPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController venueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: venueController,
              decoration: InputDecoration(labelText: 'Venue'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String eventName = eventNameController.text;
                String venue = venueController.text;

                if (eventName.isNotEmpty && venue.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(
                        eventName: eventName,
                        venue: venue, filePath: '',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter both event name and venue')),
                  );
                }
              },
              child: Text('Go to Event Details'),
            ),
          ],
        ),
      ),
    );
  }
}
