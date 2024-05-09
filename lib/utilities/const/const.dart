import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../practice/week01/navigation/navigation.dart';

const fontApp = "Rubik";
const fontBoldApp = "Rubik-Bold";



// final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const HomeScreen();
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'details',
//           builder: (BuildContext context, GoRouterState state) {
//             return const DetailsScreen();
//           },
//           routes: [
//             GoRoute(
//               path: '2',
//               builder: (BuildContext context, GoRouterState state) {
//                 return const DetailsScreen2();
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
