import 'package:flutter/material.dart';
import 'package:myproject/pushNotifications/notifications_services.dart';

class NotificationScreen extends StatefulWidget {
  final String? id;

  NotificationScreen({super.key, required this.id});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.firebaseInitMessage(context);
    notificationService.requestNotificationPermission();
    notificationService.initialBackgroundMessage(context);
    notificationService.getDeviceToken().then((value) => {
          debugPrint("Device token: $value"),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notificationService.notifications.length,
        itemBuilder: (context, index) {
          final notification = notificationService.notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text(notification.notification?.title ?? 'No Title'),
              subtitle: Text(notification.notification?.body ?? 'No Body'),
              trailing: Text(
                  notification.sentTime != null
                      ? notification.sentTime!.toLocal().toString()
                      : 'No Time',
                  style: TextStyle(fontSize: 10)),
            ),
          );
        },
      ),
    );
  }
}
