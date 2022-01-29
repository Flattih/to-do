import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/screens/home_page.dart';

import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>("Data");
  await Hive.openBox("ThemeMode");

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemData>(
      create: (context) => ItemData(),
      builder: (context, widget) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.deviceLocale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ItemData>(context).getTheme()
              ? ThemeData(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepPurpleAccent.shade700,
                  ),
                  appBarTheme: AppBarTheme(
                      color: Colors.deepPurpleAccent.shade700,
                      systemOverlayStyle:
                          const SystemUiOverlayStyle(statusBarColor: Colors.black)))
              : ThemeData.dark(),
          home: HomePage(),
        );
      },
    );
  }
}
