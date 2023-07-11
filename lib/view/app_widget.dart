import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/controller/controller.dart';
import 'package:translate_app/data/store/store.dart';
import 'package:translate_app/view/initial/splash_screen.dart';
import 'Style/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppController(),
      child: const AppWidget(),
    );
  }
}


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  getTheme() async {
    var isChangeTheme = await LocalStore.getTheme();
    // ignore: use_build_context_synchronously
    context.read<AppController>().setTheme(isChangeTheme);
  }


  @override
  void initState() {
    getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<AppController>().isChangeTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeStyle.lightTheme,
      darkTheme: ThemeStyle.darkTheme,
      title: 'Translate',
      home: const SplashScreen(),
    );
  }
}
