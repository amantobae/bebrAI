import 'package:bebra_ai/features/chat/screens/my_home_page.dart';
import 'package:bebra_ai/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'You AI Assistant',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Using this software, you can ask you questions and receive articles using artificial intelligence assistant ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: context.isDarkMode ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            onboardingImage(),
            SizedBox(
              height: 32.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: context.isDarkMode ? Colors.white : Colors.white,
                  ),
                ],
              ),
            ),
            Text(
              'created by bebrik_2007',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: context.isDarkMode ? Colors.grey : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Image onboardingImage() => Image.asset('assets/onboarding.png');
}
