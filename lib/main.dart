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
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:pagepals/screens/screens_customer/demo_screen.dart';
import 'package:pagepals/services/firebase_message_service.dart';
import 'package:pagepals/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

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
      // statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
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

  FirebaseMessageService firebaseMessageService = FirebaseMessageService();
  await firebaseMessageService.initialize();
  String? fcmToken = await firebaseMessageService.getFCMToken();

  print('FCM Token: $fcmToken');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  print('Token: $token');
  if (token != null) {
    // get expiration time
    int exp = JWT.decode(token).payload['exp'];
    DateTime expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    print('expirationDateTime: $expirationDateTime');
    if (DateTime.now().isAfter(expirationDateTime)) {
      prefs.clear();
      token = null;
    }
  }

  prefs.setString('fcmToken', fcmToken!);

  client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  // Just for test
  printSharedPreferencesData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ReaderRequestProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Just for test
void printSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();

  print('SharedPreferences Data:');
  for (String key in keys) {
    print('$key: ${prefs.getString(key)}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          print(fullRoute);
          if (fullRoute == null) {
            return null;
          }
          final routeData = Uri.tryParse(fullRoute);
          if (routeData == null) {
            return null;
          }
          final pathParameters = routeData.pathSegments;
          final queryParameters = routeData.queryParameters;
          print('pathParameters: $pathParameters');

          final partnerCode = queryParameters['partnerCode'] ?? '';
          final orderId = queryParameters['orderId'] ?? '';
          final requestId = queryParameters['requestId'] ?? '';
          final amount = queryParameters['amount'] ?? '';
          final orderInfo = queryParameters['orderInfo'] ?? '';
          final orderType = queryParameters['orderType'] ?? '';
          final resultCode = queryParameters['resultCode'] ?? '';
          final message = queryParameters['message'] ?? '';
          final payType = queryParameters['payType'] ?? '';
          final extraData = queryParameters['extraData'] ?? '';
          final responseTime = queryParameters['responseTime'] ?? '';
          final signature = queryParameters['signature'] ?? '';
          final transId = queryParameters['transId'] ?? '';

          return MaterialPageRoute(
            builder: (context) => DemoScreen(
              partnerCode: partnerCode,
              orderId: orderId,
              requestId: requestId,
              amount: amount,
              orderInfo: orderInfo,
              orderType: orderType,
              transId: transId,
              resultCode: resultCode,
              message: message,
              payType: payType,
              responseTime: responseTime,
              extraData: extraData,
              signature: signature,
            ),
          );
        },
      ),
    );
  }
}
