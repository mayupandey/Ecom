import 'dart:developer';

import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/feature/authentication/controller/authentication_controller.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            // height: ScreenInfo.responsiveHeight(260),
            decoration: BoxDecoration(
                color: AppColors.brandColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      "Profile".toUpperCase(),
                      // style: Styles.appHeader.copyWith(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: DeviceInfo.responsiveHeight(22)),
                    ),
                  ),
                  SizedBox(
                    height: DeviceInfo.responsiveHeight(10),
                  ),
                  Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: DeviceInfo.responsiveHeight(40),
                        backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL ??
                              "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                        ),
                      ),
                      // title:
                      //     Text(FirebaseAuth.instance.currentUser!.displayName!),
                      title: Text(FirebaseAuth.instance.currentUser!.email!),
                      titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: DeviceInfo.responsiveHeight(40),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.5),
                //           spreadRadius: 1,
                //           blurRadius: 4,
                //           offset: Offset(0, 1), // changes position of shadow
                //         ),
                //       ]),
                //
                //   child: ListTile(
                //     onTap: (){
                //
                //     },
                //     leading: Text("My Bookings",
                //         style:  TextStyle(
                //             fontWeight: FontWeight.w800,
                //             color: Colors.black,
                //             fontSize: 18
                //         )),
                //     trailing: Icon(Icons.calendar_month),
                //
                //   ),
                // ),
                SizedBox(
                  height: DeviceInfo.responsiveHeight(20),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: const Text("Cancellation Policy",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 18)),
                        trailing: const Icon(Icons.help),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {},
                        leading: const Text("Terms & Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 18)),
                        trailing: const Icon(Icons.policy),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {},
                        leading: const Text("Privacy Policy",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 18)),
                        trailing: const Icon(Icons.security),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: DeviceInfo.responsiveHeight(20),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  child: ListTile(
                    onTap: () {
                      final data = ref.read(authProvider).signOut((value) {
                        if (value.item1) {
                          log("Suceess");
                        } else {
                          log("Error");
                        }
                      });
                    },
                    leading: const Text("Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 18)),
                    trailing: const Icon(Icons.exit_to_app),
                  ),
                ),
                SizedBox(
                  height: DeviceInfo.responsiveHeight(20),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
