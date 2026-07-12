import 'package:ecommerce/core/features/Loginscreen/login_view.dart';
import 'package:ecommerce/core/features/Loginscreen/login_viewmodel.dart';
import 'package:ecommerce/core/features/homescreen/home_viewmodel.dart';
import 'package:ecommerce/core/themepro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          darkTheme: ThemeData.light(),
          themeMode: themeProvider.themeMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
