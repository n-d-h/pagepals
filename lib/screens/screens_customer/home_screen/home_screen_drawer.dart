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
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/screens_customer/customer_profile/customer_profile_screen.dart';
import 'package:pagepals/screens/screens_customer/customer_wallet_screen/customer_wallet_screen.dart';
import 'package:pagepals/screens/screens_customer/request_screen/request_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_pending_screen/reader_pending_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_intro_screen.dart';
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
    String photoUrl = user?.photoURL ?? 'https://via.placeholder.com/150';
    String displayName = user?.displayName ?? 'Anonymous';
    String email = user?.email ?? 'anonymous@gmail.com';
    String accountState = account?.accountState?.name ?? 'Anonymous';
    print('accountState: $accountState');

    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          account == null
              ? UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                      image: const AssetImage('assets/reading_book.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountName: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const SigninScreen(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Sign in',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  accountEmail: null,
                )
              : UserAccountsDrawerHeader(
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
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken),
                      image: const AssetImage('assets/reading_book.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          if (account != null)
            ListTile(
              leading: Icon(
                Icons.token_sharp,
                color: Colors.deepPurpleAccent.withOpacity(0.7),
              ),
              title: Text("Token: ${account?.wallet?.tokenAmount ?? 0} pals"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: CustomerWalletScreen(account: account),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
            ),
          if (account != null)
            ListTile(
              leading: Icon(
                CustomIcons.user,
                color: ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
              ),
              title: Text(AppLocalizations.of(context)!.appProfile),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: const CustomerProfileScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
            ),
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
          if (account != null)
            ListTile(
              leading: const Icon(
                UniconsLine.icons,
                color: Colors.deepPurple,
              ),
              title: account?.reader?.id == null
                  ? Text(AppLocalizations.of(context)!.appRequestToBeReader)
                  : account?.accountState?.name == "READER_PENDING"
                      ? Text('Reader Pending')
                      : Text('Reader Profile'),
              onTap: () {
                Navigator.pop(context);
                if (account?.accountState?.name == "READER_PENDING") {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ReaderPendingScreen(readerId: account?.reader?.id),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                } else if (account?.reader?.id != null) {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ReaderMainScreen(
                        accountModel: account!,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const ReaderRequestIntroScreen(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                }
              },
            ),
          if (account != null)
            ListTile(
              leading: const Icon(
                Icons.paste_outlined,
                color: Colors.blue,
              ),
              title: Text("List Request"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: RequestScreen(
                      readerId: account?.reader?.id ?? '',
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
            ),
          if (account != null)
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
