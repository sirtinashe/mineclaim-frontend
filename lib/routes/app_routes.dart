import 'package:flutter/material.dart';
import 'package:mineclaim/presentation/splash_screen/splash_screen.dart';
import 'package:mineclaim/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:mineclaim/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mineclaim/presentation/sign_up_screen/sign_up_screen.dart';

import 'package:mineclaim/presentation/notification_screen/notification_screen.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/home_page.dart';


import 'package:mineclaim/presentation/confirm_request_screen/confirm_request_screen.dart';
import 'package:mineclaim/presentation/settings_screen/settings_screen.dart';
import 'package:mineclaim/presentation/faqs_get_help_screen/faqs_get_help_screen.dart';

import 'package:mineclaim/presentation/edit_profile_screen/edit_profile_screen.dart';


import '../presentation/add_new_mine_screen/add_new_mine_screen.dart';

import '../presentation/location_screens/location_picker_screen.dart';
import '../presentation/owned_mines_screen/owned_mines_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String onboardingScreen = '/onboarding_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String homeAlarmScreen = '/home_alarm_screen';

  static const String notificationScreen = '/notification_screen';

  static const String notificationEmptyStatesScreen =
      '/notification_empty_states_screen';

  static const String messagePage = '/message_page';

  static const String messageChatScreen = '/message_chat_screen';

  static const String myHomeEmptyScreen = '/my_home_empty_screen';

  static const String myHomePage = '/my_home_page';

  static const String addNewPropertyAddressScreen =
      '/add_new_property_address_screen';

  static const String addNewPropertyMeetWithAAgentScreen =
      '/add_new_property_meet_with_a_agent_screen';

  static const String addNewPropertyTimeToSellScreen =
      '/add_new_property_time_to_sell_screen';

  static const String addNewPropertyReasonSellingHomeScreen =
      '/add_new_property_reason_selling_home_screen';

  static const String addNewPropertyDecsriptionScreen =
      '/add_new_property_decsription_screen';

  static const String addNewPropertyHomeFactsScreen =
      '/add_new_property_home_facts_screen';

  static const String addNewPropertyContactScreen =
      '/add_new_property_contact_screen';

  static const String addNewPropertySelectAmenitiesScreen =
      '/add_new_property_select_amenities_screen';

  static const String addNewPropertyDetailsScreen =
      '/add_new_property_details_screen';

  static const String homeListingScreen = '/home_listing_screen';

  static const String homeListingSateliteScreen =
      '/home_listing_satelite_screen';

  static const String homeListingDrawScreen = '/home_listing_draw_screen';

  static const String filterPage = '/filter_page';

  static const String filterTabContainerScreen = '/filter_tab_container_screen';

  static const String homeSearchPage = '/home_search_page';

  static const String productDetailsScreen = '/product_details_screen';

  static const String pickDateScreen = '/pick_date_screen';

  static const String verifyPhoneNumberScreen = '/verify_phone_number_screen';

  static const String selectVirtualAppScreen = '/select_virtual_app_screen';

  static const String selectAppAlarmScreen = '/select_app_alarm_screen';

  static const String confirmRequestScreen = '/confirm_request_screen';

  static const String profilePage = '/profile_page';

  static const String settingsScreen = '/settings_screen';

  static const String faqsGetHelpScreen = '/faqs_get_help_screen';

  static const String pastToursScreen = '/past_tours_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String recentlyViewsScreen = '/recently_views_screen';

  static const String favoriteScreen = '/favorite_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const  String mapsDemo = '/maps_demo';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    signInScreen: (context) => SignInScreen(),
    signUpScreen: (context) => SignUpScreen(),
    notificationScreen: (context) => NotificationScreen(),
    myHomeEmptyScreen: (context) => MineclaimHome(),
    addNewPropertyAddressScreen: (context) => AddNewMineScreen(),
    confirmRequestScreen: (context) => ConfirmRequestScreen(),
    settingsScreen: (context) => SettingsScreen(),
    faqsGetHelpScreen: (context) => FaqsGetHelpScreen(),
    pastToursScreen: (context) => OwnedMines(),
    editProfileScreen: (context) => EditProfileScreen(),
    
    mapsDemo: (context) => LocationPickerScreen(),
  };
}
