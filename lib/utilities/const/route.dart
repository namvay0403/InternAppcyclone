import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_appcyclone/practice/week02/firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:intern_appcyclone/travel_app/navigation/navigation.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/account_page.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/booking_flight.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/checkout_page_step1.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/checkout_page_step2.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/widgets/step2/add_card.dart';
import 'package:intern_appcyclone/travel_app/pages/detail_hotel_page/detail_hotel_page.dart';
import 'package:intern_appcyclone/travel_app/pages/favourite_page/favourite_page.dart';
import 'package:intern_appcyclone/travel_app/pages/home_page/home_page.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/hotel_page.dart';
import 'package:intern_appcyclone/travel_app/pages/onboarding_page/onboarding_view.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/room_page.dart';
import 'package:intern_appcyclone/travel_app/pages/splash_page/splash_page.dart';

import '../../travel_app/pages/account_page/widgets/change_profile.dart';
import '../../travel_app/pages/booking_flight/booking_flight_step2.dart';
import '../../travel_app/pages/booking_flight/booking_flight_step3.dart';
import '../../travel_app/pages/booking_flight/booking_flight_step4.dart';
import '../../travel_app/pages/booking_flight/booking_flight_step5.dart';
import '../../travel_app/pages/booking_flight/booking_flight_step6.dart';
import '../../travel_app/pages/booking_flight/models/filter_info.dart';
import '../../travel_app/pages/booking_flight/models/flight.dart';
import '../../travel_app/pages/booking_flight/widgets/step4/change_passenger_info.dart';
import '../../travel_app/pages/checkout_page/checkout_page_step3.dart';
import '../../travel_app/pages/checkout_page/widgets/step1/change_contact.dart';
import '../../travel_app/pages/hotel_page/models/hotel.dart';
import 'page_name.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case PageName.Home:
      return PageRoute.page(const HomePage());
    case PageName.Hotel:
      return PageRoute.page(const HotelPage());
    case PageName.DetailHotel:
      return PageRoute.page(DetailHotelPage(
        hotelModel: settings.arguments as HotelModel,
      ));
    case PageName.Room:
      return PageRoute.page(RoomPage(
        hotelId: settings.arguments as String,
      ));
    case PageName.CheckOut:
      return PageRoute.page(
          CheckOutPage(roomModel: settings.arguments as RoomModel));
    case PageName.CheckOut2:
      return PageRoute.page(const CheckOutPageStep2());
    case PageName.CheckOut3:
      return PageRoute.page(const CheckOutStep3());
    case PageName.ChangeContact:
      return PageRoute.page(ChangeContact());
    case PageName.AddCard:
      return PageRoute.page(AddCard());
    case PageName.BookingFlight:
      return PageRoute.page(BookingFlight());
    case PageName.BookingFlightStep2:
      return PageRoute.page(
          BookingFlightStep2(filterInfo: settings.arguments as FilterInfo));
    case PageName.BookingFlightStep3:
      return PageRoute.page(
          BookingFlightStep3(filterInfo: settings.arguments as FilterInfo));
    case PageName.BookingFlightStep4:
      return PageRoute.page(const BookingFlightStep4());
    case PageName.ChangePassengerInfo:
      return PageRoute.page(const ChangePassengerInfo());
    case PageName.BookingFlightStep5:
      return PageRoute.page(const BookingFlightStep5());
    case PageName.BookingFlightStep6:
      return PageRoute.page(const BookingFlightStep6());
    case PageName.ChangeProfile:
      return PageRoute.page(const ChangeProfile());
      case PageName.NavBar:
      return PageRoute.page(NavBar());
    default:
      return PageRoute.page(NavBar());
  }
}

class PageRoute {
  static MaterialPageRoute page(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}


// class RouterCustom {
//   final GoRouter router = GoRouter(
//     debugLogDiagnostics: true,
//     initialLocation: '/',
//     routes: <RouteBase>[
//       GoRoute(
//         path: '/',
//         name: 'splash',
//         builder: (BuildContext context, GoRouterState state) {
//           return const SplashPage(onBoarding: true);
//         },
//         routes: [
//           GoRoute(
//             path: 'login',
//             name: 'login',
//             builder: (BuildContext context, GoRouterState state) {
//               return const LoginPage();
//             },
//           ),
//           GoRoute(
//             path: 'onBoarding',
//             name: 'onBoarding',
//             builder: (BuildContext context, GoRouterState state) {
//               return const OnboardingView();
//             },
//           ),
//           GoRoute(
//             path: 'home',
//             name: 'home',
//             builder: (BuildContext context, GoRouterState state) {
//               return const HomePage();
//             },
//             routes: [
//               GoRoute(
//                 path: 'hotel',
//                 name: 'hotel',
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const HotelPage();
//                 },
//                 routes: [
//                   GoRoute(
//                     path: 'hotel/detail',
//                     name: 'detail',
//                     builder: (BuildContext context, GoRouterState state) {
//                       return DetailHotelPage(
//                         hotelModel: state.extra as HotelModel,
//                       );
//                     },
//                     routes: [
//                       GoRoute(
//                         path: 'hotel/detail/room/:hotelId',
//                         name: 'room',
//                         builder: (BuildContext context, GoRouterState state) {
//                           return RoomPage(
//                             hotelId: state.pathParameters["hotelId"]!,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           GoRoute(
//             path: 'favorite',
//             name: 'favorite',
//             builder: (BuildContext context, GoRouterState state) {
//               return const FavoritePage();
//             },
//           ),
//           GoRoute(
//             path: 'setting',
//             name: 'setting',
//             builder: (BuildContext context, GoRouterState state) {
//               return const AccountPage();
//             },
//           ),
//         ],
//       ),
//     ],
//   );
// }

