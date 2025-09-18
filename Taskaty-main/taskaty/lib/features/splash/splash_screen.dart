import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskaty/core/extensions/navigation.dart';
import 'package:taskaty/core/utils/text_styles.dart';
import 'package:taskaty/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      pushWithReplacement(context, const UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // spacing: 20,
          children: [
            // image
            Lottie.asset('assets/images/logo.json', width: 250),
            Text('Taskati', style: TextStyles.getTitle()),
            const Gap(10),
            Text('It\'s time to be organized!', style: TextStyles.getBody()),
          ],
        ),
      ),
    );
  }
}
