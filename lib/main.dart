import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dashboard.dart';
import 'event_detail.dart';
import 'qr_scanner.dart'; // Import QRScannerPage
import 'show_attendance.dart'; // Import ViewAttendanceScreen
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('attendance');

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Attendance App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/eventDetail': (context) => EventDetailPage(eventName: '', venue: '', filePath: ''), // Placeholder
        '/scan': (context) => QRScannerPage(eventName: '', venue: ''), // Placeholder
        '/showAttendance': (context) => ViewAttendanceScreen(eventName: '', filePath: ''), // Placeholder
      },
    );
  }
}
