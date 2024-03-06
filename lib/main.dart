import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/firebase_options.dart';
import 'package:pagepals/providers/cart_provider.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Declare client as a global variable
ValueNotifier<GraphQLClient>? client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await dotenv.load(fileName: ".env");
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://pagepals.azurewebsites.net/graphql',
  );

  client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client!,
      child: MaterialApp(
        title: 'Page Pals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lexend().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
