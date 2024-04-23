import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { Online, Offline }

final networkStatusProvider =
    StreamProvider<NetworkStatus>((ref) => _createNetworkStatusStream());

Stream<NetworkStatus> _createNetworkStatusStream() {
  final controller = StreamController<NetworkStatus>();

  Connectivity().onConnectivityChanged.listen((status) {
    final networkStatus = _getNetworkStatus(status.first);
    controller.add(networkStatus);
  });

  return controller.stream;
}

NetworkStatus _getNetworkStatus(ConnectivityResult status) {
  return status == ConnectivityResult.mobile ||
          status == ConnectivityResult.wifi
      ? NetworkStatus.Online
      : NetworkStatus.Offline;
}

class NetworkAware extends ConsumerWidget {
  final Widget onlineChild;
  const NetworkAware(this.onlineChild, {super.key});
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final networkStatus = ref.watch(networkStatusProvider);
          // Use networkStatus in your UI
          return networkStatus.value == NetworkStatus.Online
              ? onlineChild
              : const Center(
                  child: ListTile(
                  title: Text('No Internet Connection'),
                  subtitle: Text('Please check your internet connection'),
                ));
        },
      ),
    );
  }
}
