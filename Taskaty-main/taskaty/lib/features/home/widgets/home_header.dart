import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskaty/core/extensions/navigation.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/colors.dart';
import 'package:taskaty/core/utils/text_styles.dart';
import 'package:taskaty/features/profile/profile_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
  final name = LocalHelper.getData(LocalHelper.kName);
  final displayName = (name is String && name.isNotEmpty) ? name.split(' ').first : 'User';
  final imagePath = LocalHelper.getData(LocalHelper.kImage);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $displayName',
                style: TextStyles.getTitle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('Have a Nice Day', style: TextStyles.getBody()),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            pushTo(context, ProfileScreen()).then((value) => setState(() {}));
          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
        radius: 22,
        backgroundImage: (imagePath != null && imagePath is String && imagePath.isNotEmpty)
          ? FileImage(File(imagePath))
          : const AssetImage('assets/images/user.png') as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
