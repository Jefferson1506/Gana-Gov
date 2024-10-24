import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/buyer/page/list_sell.dart';
import 'package:ganagov/module/buyer/page/perfil_buyer.dart';
import 'package:ganagov/module/buyer/page/sell.dart';

class HomeBuyer extends StatefulWidget {
  const HomeBuyer({super.key});

  @override
  State<HomeBuyer> createState() => _HomeBuyerState();
}

class _HomeBuyerState extends State<HomeBuyer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PerfilBuyer(),
    RegistroGanadoPage(),
    MySalesPage()
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomBarInspiredInside(
        items: const [
          TabItem(
            icon: Icons.person,
            title: 'Perfil',
          ),
          TabItem(
            icon: Icons.sell,
            title: 'Vender',
          ),
          TabItem(
            icon: Icons.list,
            title: 'Ventas',
          ),
        ],
        backgroundColor: colorScheme.primary,
        color: const Color.fromARGB(255, 0, 0, 0),
        colorSelected: Colors.orange,
        indexSelected: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        animated: true,
      ),
    );
  }
}
