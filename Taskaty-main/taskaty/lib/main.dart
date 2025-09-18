import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taskaty/core/utils/colors.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/features/splash/splash_screen.dart';
import 'package:taskaty/features/home/page/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalHelper.init();
  runApp(const TaskatyApp());
}

// import 'package:flutter/scheduler.dart';

class TaskatyApp extends StatefulWidget {
  const TaskatyApp({super.key});

  @override
  State<TaskatyApp> createState() => _TaskatyAppState();
}

class _TaskatyAppState extends State<TaskatyApp> {
  static final themeModeNotifier = ValueNotifier<ThemeMode>(_getInitialThemeMode());

  static ThemeMode _getInitialThemeMode() {
    final isDark = LocalHelper.getData(LocalHelper.kIsDark);
    if (isDark == null) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Taskaty',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, brightness: Brightness.dark),
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: mode,
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
