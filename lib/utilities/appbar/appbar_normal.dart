// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart';

// import '../const/app_assets.dart';
// import '../const/styles.dart';

// class AppBarNormal extends StatelessWidget {
//   const AppBarNormal(
//       {super.key,
//       required this.title,
//       required this.isBack,
//       required this.prefixIcon,
//       this.content});

//   final String title;
//   final bool isBack;
//   final bool prefixIcon;
//   final Widget? content;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset(
//           AppAssets.appbar,
//           fit: BoxFit.cover,
//           width: MediaQuery.of(context).size.width,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         isBack
//                             ? Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 10),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Icon(
//                                         Icons.arrow_back,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   title,
//                                   style: AppStyle.heading.copyWith(
//                                     fontSize: 25,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             ),
//                           ),
//                         ),
//                         prefixIcon
//                             ? Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: InkWell(
//                                       onTap: () {},
//                                       child: const Icon(
//                                         Icons.filter_list,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(height: 35, width: 35),
//                       ],
//                     ),
//                     content ?? Container(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
