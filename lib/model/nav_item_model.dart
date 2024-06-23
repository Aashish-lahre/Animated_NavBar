import 'package:animated_nav_rive/model/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

final List<NavItemModel> bottomNavItem = [
  NavItemModel(
    title: 'Chat',
    rive: RiveModel(
        src: 'assets/icons.riv',
        artBoard: 'CHAT',
        stateMachineName: 'CHAT_Interactivity'),
  ),
  NavItemModel(
    title: 'Search',
    rive: RiveModel(
        src: 'assets/icons.riv',
        artBoard: 'SEARCH',
        stateMachineName: 'SEARCH_Interactivity'),
  ),
  NavItemModel(
    title: 'Notification',
    rive: RiveModel(
        src: 'assets/icons.riv',
        artBoard: 'BELL',
        stateMachineName: 'BELL_Interactivity'),
  ),
  NavItemModel(
    title: 'Timer',
    rive: RiveModel(
        src: 'assets/icons.riv',
        artBoard: 'TIMER',
        stateMachineName: 'TIMER_Interactivity'),
  ),
  NavItemModel(
    title: 'Profile',
    rive: RiveModel(
        src: 'assets/icons.riv',
        artBoard: 'USER',
        stateMachineName: 'USER_Interactivity'),
  ),
];
