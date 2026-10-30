import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen(initialTab: HomeScreenTab.profile);
  }
}
