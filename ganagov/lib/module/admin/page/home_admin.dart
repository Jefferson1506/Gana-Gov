import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/module/admin/page/Breed.dart';
import 'package:ganagov/module/admin/page/new_admin.dart';
import 'package:ganagov/module/admin/page/statistics.dart';
import 'package:ganagov/module/admin/page/user_control_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserManagementPage(),
    StatisticsPage(),
    const BreedCrudPage(),
    const NewAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusAdmi = statusAdminh();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 48, 39),
      appBar: AppBar(
        shape: LinearBorder.bottom(
            side: const BorderSide(color: Colors.white, width: 10)),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
        leading: null,
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: const Icon(
                Icons.people,
                color: Colors.cyanAccent,
              )),
          IconButton(
              onPressed: () => exitApp(),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.orange,
              ))
        ],
        title: const AutoSizeText(
          'Administrador',
          minFontSize: 18,
          maxFontSize: 20,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 48, 39),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomBarInspiredInside(
        items: [
          const TabItem(
            icon: Icons.person,
            title: 'Control Usuarios',
          ),
          const TabItem(
            icon: Icons.bar_chart,
            title: 'Estadísticas',
          ),
          const TabItem(
            icon: Icons.pets,
            title: 'CRUD Razas',
          ),
          if (statusAdmi == true)
            const TabItem(
              icon: Icons.settings,
              title: 'Admin',
            ),
        ],
        backgroundColor: colorScheme.secondary,
        color: const Color.fromARGB(255, 39, 48, 39),
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

Future<void> logout(BuildContext context) async {
  var box = Hive.box<UserModel>('users');
  await box.clear();

  Navigator.pushReplacementNamed(context, 'login');
}

Future<bool> statusAdminh() async {
  final box = Hive.box<UserModel>('users');

  if (box.isNotEmpty) {
    UserModel user = box.getAt(0)!;

    return user.superAdmin ?? false;
  }

  return false;
}

void exitApp() {
  SystemNavigator.pop();
}
