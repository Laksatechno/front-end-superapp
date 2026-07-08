import 'package:flutter/material.dart';
import 'package:yofa/page/profile/profile_page.dart';
import '../widgets/app_bottom_nav.dart';

import 'home/home_page.dart';
import 'presensi/presensi_page.dart';
import 'cuti/cuti_page.dart';
import 'riwayat/riwayat_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _home = const HomePage();
  final _cuti = const CutiPage();
  final _riwayat = const RiwayatPage();
  final _profil = const ProfilPage();

  // penting: jangan const, karena active berubah
  final GlobalKey<PresensiPageState> _presensiKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          _home,
          PresensiPage(
            key: _presensiKey,
            active: _index == 1,
          ),
          _cuti,
          _riwayat,
          _profil,
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
