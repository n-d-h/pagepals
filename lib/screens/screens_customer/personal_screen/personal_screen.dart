import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/signin_home.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        flexibleSpace: Container(
          height: 600,
          decoration: BoxDecoration(
            color: ColorHelper.getColor(ColorHelper.greenActive),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/image_reader.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: ColorHelper.getColor(ColorHelper.normal),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'MinMin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 70),
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  'My Interest',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.getColor(ColorHelper.black),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              generateMenuItem(
                'Saved list',
                FontAwesomeIcons.heart,
                ColorHelper.grey,
                ColorHelper.black,
                () {},
              ),
              generateMenuItem(
                'My interests',
                Icons.tag,
                ColorHelper.grey,
                ColorHelper.black,
                () {},
              ),
              generateMenuItem(
                'Personal Information',
                Icons.insert_invitation,
                ColorHelper.grey,
                ColorHelper.black,
                () {},
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.getColor(ColorHelper.black),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              generateMenuItem(
                'My interests',
                Icons.tag,
                ColorHelper.grey,
                ColorHelper.black,
                () {},
              ),
              generateMenuItem(
                'My interests',
                Icons.tag,
                ColorHelper.grey,
                ColorHelper.black,
                () {},
              ),
              // logout button
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 5,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorHelper.getColor(ColorHelper.green),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: ColorHelper.getColor(ColorHelper.black),
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorHelper.getColor(ColorHelper.black),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorHelper.getColor(ColorHelper.black),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const SigninHomeScreen(),
                        type: PageTransitionType.bottomToTop,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateMenuItem(
    String? title,
    IconData? icon,
    String? iconColorCode,
    String? textColorCode,
    Function() onTap,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorHelper.getColor(ColorHelper.grey),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon ?? Icons.person,
          color: ColorHelper.getColor(iconColorCode ?? ColorHelper.normal),
        ),
        title: Text(
          title ?? 'Personal Information',
          style: TextStyle(
            fontSize: 20,
            color: ColorHelper.getColor(textColorCode ?? ColorHelper.normal),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorHelper.getColor(ColorHelper.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}
