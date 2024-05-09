import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utilities/const/app_assets.dart';
import '../../../../utilities/const/const.dart';

// class AppBarHome extends StatelessWidget {
//   const AppBarHome(
//       {super.key,
//       required this.title,
//       required this.content,
//       required this.imageUrl});

//   final String title;
//   final String content;
//   final String imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset(AppAssets.appbar,
//             fit: BoxFit.cover, width: double.infinity),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30),
//           child: Column(
//             children: [
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 200,
//                             child: Text(
//                               title,
//                               style: AppStyle.heading.copyWith(
//                                 fontSize: 25,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             content,
//                             style: AppStyle.normal,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.notifications, color: Colors.white),
//                         Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(30),
//                               color: Colors.white,
//                               image: DecorationImage(
//                                 image: NetworkImage(imageUrl),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   style: const TextStyle(fontFamily: fontApp),
//                   decoration: InputDecoration(
//                     hintText: AppLocalizations.of(context)!.search,
//                     prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

PreferredSize appBarHome(
    BuildContext context, String title, String content, String imageUrl) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(220),
    child: SizedBox(
      height: 220,
      child: Stack(
        children: [
          Image.asset(AppAssets.appbar,
              fit: BoxFit.cover, width: double.infinity),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                title,
                                style: AppStyle.heading.copyWith(
                                  fontSize: 25,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              content,
                              style: AppStyle.normal,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.notifications, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                image: imageUrl.isNotEmpty &&
                                        imageUrl.contains('http')
                                    ? DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(AppAssets.avatar),
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // const SizedBox(height: 8),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: TextFormField(
                //     style: const TextStyle(fontFamily: fontApp),
                //     decoration: InputDecoration(
                //       hintText: AppLocalizations.of(context)!.search,
                //       prefixIcon: const Icon(Icons.search, color: Colors.grey),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide.none,
                //       ),
                //       contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 20,
                //         vertical: 10,
                //       ),
                //       filled: true,
                //       fillColor: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
