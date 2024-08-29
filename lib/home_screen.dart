import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:push_notification_app/notification_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 NotificationServices notificationServices = NotificationServices();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.setupInteractMessage(context);
    notificationServices.FirebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Notification'),
      backgroundColor: Colors.blue,
      centerTitle:  true,),
      body: TextButton(onPressed: (){
        notificationServices.getDeviceToken() .then((value) async {
          var data = {
            'to' : value.toString(),
            'priority': 'high',
            'notification' : {
              'title' : 'Waleed',
              'body': 'Hello world',
            },
            'data' : {
              'type': 'msj',
              'id': 'waleed678',
            }
          };
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
           body: jsonEncode(data),
           headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authentication': 'AIzaSyBIUSXWNBXdtSz0sV2zjCSb9sHZv4VX2gc',
           }
           );
        });  
      }, 
      child: Text('Send Notifications')),
    );
  }
}