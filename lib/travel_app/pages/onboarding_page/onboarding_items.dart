import 'package:intern_appcyclone/utilities/const/const.dart';

import '../../../utilities/const/app_assets.dart';
import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Book a flight",
      descriptions:
          "Found a flight that matches your destination and schedule? Book it instantly.",
      image: AppAssets.intro1,
    ),
    OnboardingInfo(
      title: "Find a hotel room",
      descriptions:
          "Select the day, book your room. We give you the best price.",
      image: AppAssets.intro2,
    ),
    OnboardingInfo(
      title: "Enjoy your trip",
      descriptions:
          "Easy discovering new places and share these between your friends and travel together.",
      image: AppAssets.intro3,
    ),
  ];
}
