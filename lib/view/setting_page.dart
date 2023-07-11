import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/components/backgroun.dart';
import 'package:translate_app/controller/controller.dart';

import '../components/custom_button.dart';
import '../components/custom_divider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        isBack: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 24, bottom: 25),
              child: Text(
                "Settings",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 30),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    text: 'Feedback',
                    onPressed: () {},
                  ),
                  const CustomDivider(),
                  CustomButton(
                    text: 'Help',
                    onPressed: () {},
                  ),
                  const CustomDivider(),
                  CustomButton(
                    text: 'About',
                    onPressed: () {},
                  ),
                  const CustomDivider(),
                  CustomButton(
                    text: 'Access To The Microphone',
                    onPressed: () {},
                  ),
                  const CustomDivider(),
                  CustomButton(
                    text: 'Clear All Data',
                    onPressed: () {
                      context.read<AppController>().clearAllData;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
