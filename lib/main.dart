import 'package:flutter/material.dart';
// import 'package:flutter_test_girman_tech/firebase_options.dart';
import 'package:flutter_test_girman_tech/services/firebase_service.dart';
import 'package:flutter_test_girman_tech/view/home_screen.dart';
import 'package:flutter_test_girman_tech/view/search_results_screen.dart';
import 'package:provider/provider.dart';

import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/search_results_viewmodel.dart';
import 'services/user_service.dart';
// import 'viewmodels/search_results_viewmodel.dart';
import 'widgets/custom_app_bar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
      print("Firebase initialized successfully");
    } else {
      Firebase.app(); // if already initialized, use that one
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String data = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _signInAnonymously();
  //   // _readData();
  // }

  // Future<void> _signInAnonymously() async {
  //   try {
  //     await Firebase.initializeApp();
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInAnonymously();
  //     print('Signed in anonymously with UID: ${userCredential.user!.uid}');
  //     _readData();
  //   } catch (e) {
  //     print('Error signing in anonymously: $e');
  //   }
  // }

  // Future<void> _readData() async {
  //   try {
  //     DataSnapshot snapshot = await FirebaseDatabase.instanceFor(
  //       app: Firebase.app(),
  //       databaseURL:
  //           'https://girman-test-default-rtdb.asia-southeast1.firebasedatabase.app/',
  //     ).ref().get();
  //     print(snapshot.value.toString());
  //     print(snapshot);
  //     print(1);
  //   } catch (e) {
  //     print('Error reading data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => UserService()),
        Provider<FirebaseService>(create: (_) => FirebaseService()),
        ChangeNotifierProxyProvider<UserService, HomeViewModel>(
          create: (context) => HomeViewModel(context.read<UserService>()),
          update: (context, userService, previous) =>
              HomeViewModel(userService),
        ),
        ChangeNotifierProxyProvider<FirebaseService, SearchResultsViewModel>(
          create: (context) =>
              SearchResultsViewModel(context.read<FirebaseService>()),
          update: (context, firebaseService, previous) =>
              SearchResultsViewModel(firebaseService),
        ),
        // Provider<FirebaseService>(
        //   create: (_) => FirebaseService(),
        // ),
        // ChangeNotifierProxyProvider<FirebaseService, SearchResultsViewModel>(
        //   create: (context) =>
        //       SearchResultsViewModel(context.read<FirebaseService>()),
        //   update: (context, firebaseService, previous) =>
        //       previous ?? SearchResultsViewModel(firebaseService),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Girman Search App',
        theme: ThemeData(
          primaryColor: Color(0xFF3063E6),
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppScaffold(child: HomeScreen()),
        routes: {
          '/search_results': (context) =>
              AppScaffold(child: SearchResultsScreen()),
        },
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Stack(
        children: [
          // Background image

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  const Color(0xFFB1CBFF), // Very light blue
                ],
                // stops: [0.0, 1.0],
                stops: [0.3, 1],
              ),
            ),
          ),

          Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/bg_image.png',
              fit: BoxFit.fill,
              width: double.maxFinite,
              height: 800,
            ),
          ),
          // Child widget
          child,
        ],
      ),
    );
  }
}
