import 'package:flutter/material.dart';
import 'package:untitled2/providers/AuthProvider.dart';
import 'package:untitled2/providers/CategoryProvider.dart';
import 'package:untitled2/providers/TransactionProvider.dart';
import 'package:untitled2/screens/categories.dart';
import 'package:untitled2/screens/home.dart';
import 'package:untitled2/screens/login.dart';
import 'package:untitled2/screens/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider(authProvider)),
                ChangeNotifierProvider<TransactionProvider>(
                    create: (context) => TransactionProvider(authProvider))
              ],
              child: MaterialApp(title: 'Welcome to Flutter', routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return Home();
                  } else {
                    return Login();
                  }
                },
                '/login': (context) => Login(),
                '/register': (context) => Register(),
                '/home': (context) => Home(),
                '/categories': (context) => Categories(),
              }));
        }));
  }
}