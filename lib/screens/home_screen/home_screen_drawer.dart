import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedLanguage =
        localeProvider.locale.languageCode == 'vi' ? 'Vietnamese' : 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Bui Le Van Minh',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              '@minmin',
              style: TextStyle(fontSize: 12),
            ),
            currentAccountPicture: const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/image_reader.png'),
            ),
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.green),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/user.svg',
              height: 24,
              colorFilter: ColorFilter.mode(
                ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
                BlendMode.srcIn,
              ),
            ),
            title: const Text('Profile'),
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
            title: const Text('My Interests'),
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
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorites screen
            },
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Colors.blueAccent,
            ),
            title: const Text('Language'),
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
            title: const Text('General'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to general settings screen
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/bell.svg',
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.brown,
                BlendMode.srcIn,
              ),
            ),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications settings screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }
}
