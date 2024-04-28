import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pagepals/firebase_options.dart';
import 'package:pagepals/providers/cart_provider.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/providers/locale_provider.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:pagepals/providers/reader_update_provider.dart';
import 'package:pagepals/screens/screens_customer/customer_wallet_screen/payment_response_screen.dart';
import 'package:pagepals/services/firebase_message_service.dart';
import 'package:pagepals/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Declare client as a global variable
ValueNotifier<GraphQLClient>? client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://pagepals.azurewebsites.net/graphql',
  );

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? token = prefs.getString('accessToken');
  // print('Token: $token');
  //
  // FirebaseMessageService firebaseMessageService = FirebaseMessageService();
  // await firebaseMessageService.initialize();
  // String? fcmToken = await firebaseMessageService.getFCMToken();
  // prefs.setString('fcmToken', fcmToken!);
  // print('FCM Token: $fcmToken');
  //
  // if (token != null) {
  //   int exp = JWT.decode(token).payload['exp'];
  //   DateTime expirationDateTime =
  //       DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  //   print('expirationDateTime: $expirationDateTime');
  //   if (DateTime.now().isAfter(expirationDateTime)) {
  //     prefs.clear();
  //     token = null;
  //   }
  // }

  client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ReaderRequestProvider()),
        ChangeNotifierProvider(create: (_) => ReaderUpdateProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void firebaseMessageService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Token: $token');

    FirebaseMessageService firebaseMessageService = FirebaseMessageService(context: context);
    await firebaseMessageService.initialize();
    String? fcmToken = await firebaseMessageService.getFCMToken();
    prefs.setString('fcmToken', fcmToken!);
    print('FCM Token: $fcmToken');

    // if (token != null) {
    //   int exp = JWT.decode(token).payload['exp'];
    //   DateTime expirationDateTime =
    //   DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    //   print('expirationDateTime: $expirationDateTime');
    //   if (DateTime.now().isAfter(expirationDateTime)) {
    //     prefs.clear();
    //     token = null;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    firebaseMessageService(context);
    var localeId = context.watch<LocaleProvider>().locale;

    return GraphQLProvider(
      client: client!,
      child: MaterialApp(
        title: 'PagePals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lexend().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('vi')],
        locale: localeId,
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          final fullRoute = settings.name;
          if (fullRoute == null) {
            return null;
          }
          final routeData = Uri.tryParse(fullRoute);
          if (routeData == null) {
            return null;
          }
          final queryParameters = routeData.queryParameters;
          return MaterialPageRoute(
            builder: (context) => PaymentResponseScreen(
              data: queryParameters,
            ),
          );
        },
      ),
    );
  }
}
