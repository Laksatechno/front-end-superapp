import 'package:flutter/material.dart';
import 'package:yofa/page/profile/profile_page.dart';
import 'package:yofa/pageadmin/home_admin.dart';
import 'package:yofa/pageadmin/widget/app_bottom_navigate.dart';




class AppShellAdmin extends StatefulWidget {
  const AppShellAdmin({super.key});

  @override
  State<AppShellAdmin> createState() => _AppShellAdminState();
}

class _AppShellAdminState extends State<AppShellAdmin> {
  int _index = 0;

  final _home = const HomeAdminPage();
  final _profil = const ProfilPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          _home,
          _profil,
        ],
      ),
      bottomNavigationBar: AppBottomNavAdmin(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
