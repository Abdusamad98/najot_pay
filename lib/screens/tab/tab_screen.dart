import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/bottom/bottom_bloc.dart';
import 'package:najot_pay/blocs/bottom/bottom_event.dart';
import 'package:najot_pay/blocs/bottom/bottom_state.dart';
import 'package:najot_pay/screens/tab/card/card_screen.dart';
import 'package:najot_pay/screens/tab/history/history_screen.dart';
import 'package:najot_pay/screens/tab/home/home_screen.dart';
import 'package:najot_pay/screens/tab/profile/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const CardScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Colors.black,
            currentIndex: state.index,
            onTap: (index) {
              context.read<BottomBloc>().add(ChangeIndexEvent(index: index));
            },
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.credit_card,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.credit_card,
                  color: Colors.grey,
                ),
                label: 'Card',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                label: 'History',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
