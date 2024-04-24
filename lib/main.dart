import 'package:ecom/src/app.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:ecom/src/routes/go_router.dart';
import 'package:ecom/src/utils/favourites.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(ProductsAdapter());
  Favourites.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Something went wrong"),
      ),
      body: Center(
        child: Text(details.toString()),
      ),
    );
  };
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: goRouter,
//       debugShowCheckedModeBanner: false,
//       title: AppStrings.appName,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
