import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/notifications_screen.dart';
import 'services/firebase_messaging_service.dart';
import 'services/firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter FCM Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        home: const HomeScreen(),
        routes: {
          '/homeScreen': (context) => const HomeScreen(),
          '/notificationsScreen': (context) => const NotificationsScreen(),
        },
      ),
    );
  }
}
