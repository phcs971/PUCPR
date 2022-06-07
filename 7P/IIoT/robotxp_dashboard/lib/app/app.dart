import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:robotxp_dashboard/app/pages/startup_page.dart';
import 'package:robotxp_dashboard/app/stores/home_store.dart';

import 'pages/home_page.dart';

class RobotXPApp extends StatefulWidget {
  const RobotXPApp({Key? key}) : super(key: key);

  @override
  State<RobotXPApp> createState() => _RobotXPAppState();
}

class _RobotXPAppState extends State<RobotXPApp> {
  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton(HomeStore());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot XP Dashboard',
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const StartupPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
