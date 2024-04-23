import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/routes/go_router.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) {
        /// Device info and theme should be declared first, with the first screen or build context

        DeviceInfo().init(context);

        return AppStrings.appName;
      },

      // TODO: Set theme data
      theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor),
    );
  }
}
