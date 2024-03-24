import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/providers/locale_provider.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/signin_home.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  late String _selectedLanguage;
  AccountModel? account;

  @override
  void initState() {
    super.initState();
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedLanguage =
        localeProvider.locale.languageCode == 'vi' ? 'Vietnamese' : 'English';
    getAccount();
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      Map<String, dynamic> accountMap = json.decode(accountString);
      setState(() {
        account = AccountModel.fromJson(accountMap);
      });
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String photoUrl = user?.photoURL ??
        'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain';
    String displayName = user?.displayName ?? 'Anonymous';
    String email = user?.email ?? 'anonymous@gmail.com';

    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              account?.fullName ?? displayName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              // '@${email.substring(0, email.indexOf('@'))}',
              '@${account?.username!}',
              style: const TextStyle(fontSize: 12),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 60,
              backgroundImage:
                  NetworkImage(account?.customer?.imageUrl ?? photoUrl),
            ),
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.green),
            ),
          ),
          ListTile(
            leading: Icon(
              CustomIcons.user,
              color: ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
            ),
            title: Text(AppLocalizations.of(context)!.appProfile),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile screen
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text(AppLocalizations.of(context)!.appInterest),
            onTap: () {
              Navigator.pop(context);
              // Navigate to interests screen
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star_rounded,
              color: ColorHelper.getColor('#FFA800'),
            ),
            title: Text(AppLocalizations.of(context)!.appFavorite),
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorites screen
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.appSetting,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Colors.blueAccent,
            ),
            title: Text(AppLocalizations.of(context)!.appLanguages),
            trailing: DropdownButton<String>(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              value: _selectedLanguage,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
              onChanged: (String? newValue) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.greenAccent,
                        size: 60,
                      ),
                    );
                  },
                );
                Future.delayed(const Duration(milliseconds: 1000), () {
                  Navigator.pop(context);
                });
                setState(() {
                  _selectedLanguage = newValue!;
                  var localeProvider =
                      Provider.of<LocaleProvider>(context, listen: false);
                  if (_selectedLanguage == 'Vietnamese') {
                    localeProvider.setLocale(const Locale('vi'));
                  } else {
                    localeProvider.setLocale(const Locale('en'));
                  }
                });
              },
              items: <String>['Vietnamese', 'English']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            title: Text(AppLocalizations.of(context)!.appGeneral),
            onTap: () {
              Navigator.pop(context);
              // Navigate to general settings screen
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.brown,
            ),
            title: Text(AppLocalizations.of(context)!.appNotification),
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications settings screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              UniconsLine.icons,
              color: Colors.deepPurple,
            ),
            title: Text(AppLocalizations.of(context)!.appRequestToBeReader),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child: const ReaderRequestScreen(),
              //     type: PageTransitionType.rightToLeft,
              //     duration: const Duration(milliseconds: 300),
              //   ),
              // );
              Navigator.push(
                context,
                PageTransition(
                  child: const ReaderMainScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                ),
              );
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   PageTransition(
              //     child: const ReaderMainScreen(),
              //     type: PageTransitionType.rightToLeft,
              //     duration: const Duration(milliseconds: 300),
              //   ),
              //   (route) => false,
              // );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(AppLocalizations.of(context)!.appLogout),
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.greenAccent,
                      size: 60,
                    ),
                  );
                },
              );

              GoogleSignInProvider googleSignInProvider =
                  GoogleSignInProvider();
              await googleSignInProvider.googleLogout();

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Future.delayed(const Duration(milliseconds: 0), () {
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: const SigninHomeScreen(),
                    type: PageTransitionType.fade,
                  ),
                  (route) => false,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
