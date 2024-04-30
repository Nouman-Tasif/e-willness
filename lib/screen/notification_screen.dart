// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   List<String> notifications = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     tz.initializeTimeZones();
//     final location = tz.getLocation('America/New_York'); // Replace with your timezone
//     tz.setLocalLocation(location);
//
//     var initializationSettingsAndroid =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     // Schedule the first notification
//     _scheduleNotification();
//   }
//
//   Future<void> _scheduleNotification() async {
//     var androidPlatformChannelSpecifics =  const AndroidNotificationDetails(
//         'drink_water_channel', 'Drink Water Channel',"",
//         importance: Importance.high, priority: Priority.high);
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Drink Water',
//       'It\'s time to drink water!',
//       _nextInstanceOfHalfAnHour(),
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   tz.TZDateTime _nextInstanceOfHalfAnHour() {
//     final now = tz.TZDateTime.now(tz.local);
//     final nextInstance = now.add(const Duration(seconds: 1));
//     return nextInstance;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Drink Water Reminder'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: const Text(
//               'Notifications',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(notifications[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
