import 'package:flutter/material.dart';
import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:provider/provider.dart';

import 'injection_container.dart' as di;
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => di.sl<AlbumController>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFFBFAFA),
            primaryColor: Colors.teal),
        home: const HomePage(),
      ),
    );
  }
}
