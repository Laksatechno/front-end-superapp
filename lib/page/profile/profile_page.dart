import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/about/about_page.dart';
import 'package:yofa/bloc/logout/logout_bloc.dart';
import 'package:yofa/core/extensions/build_context.ext.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/page/login/login_page.dart';
import 'package:yofa/page/profile/identitas.dart';
import 'package:yofa/widgets/update_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../theme/app_theme.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _name = '-';
  String _role = '-';
  bool _loadingUser = true;
  late String appVersion = '-';
  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
  final info = await PackageInfo.fromPlatform();

  setState(() {
    appVersion = info.version;
  });
}

  Future<void> _loadUser() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      // Sesuaikan field sesuai model Auth kamu.
      // Umumnya: authData.user?.name / authData.user?.role
      final user = authData?.user;

      final name = (user?.name ?? '').toString().trim();
      final role = (user?.role ??  '').toString().trim();

      if (!mounted) return;
      setState(() {
        _name = name.isEmpty ? '-' : name;
        _role = role.isEmpty ? '-' : role;
        _loadingUser = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _name = '-';
        _role = '-';
        _loadingUser = false;
      });
    }
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    String subtitle = '',
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F6F8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEADDE6)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF4ECF2),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEADDE6)),
              ),
              child: Icon(icon, color: AppTheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F646B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF8B7F86)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          // ===== HEADER PROFILE =====
          _card(
            child: Column(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF4ECF2),
                    border: Border.all(color: const Color(0xFFEADDE6), width: 1.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: const Icon(Icons.person_rounded, color: AppTheme.primary, size: 46),
                ),
                const SizedBox(height: 12),

                // NAMA (dari auth local)
                Text(
                  _loadingUser ? 'Memuat...' : _name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                // ROLE (dari auth local)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4ECF2),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFEADDE6)),
                  ),
                  child: Text(
                    _loadingUser ? '...' : _role,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== MENU =====
          _card(
            child: Column(
              children: [
                _menuTile(
                  icon: Icons.badge_outlined,
                  title: 'Data Pribadi',
                  subtitle: 'Nama, email, No HP, alamat',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const IdentitasPage()),
                    ).then((_) {
                      // kalau habis update identitas dan auth local ikut berubah:
                      _loadUser();
                    });
                  },
                ),
                const SizedBox(height: 10),
                _menuTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'Preferensi aplikasi & akun',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings Coming soon')),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _menuTile(
                  icon: Icons.help_outline_rounded,
                  title: 'FAQs',
                  subtitle: 'Pertanyaan yang sering ditanyakan',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('FAQs Coming soon')),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _menuTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Kebijakan Privasi',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Privacy Policy Coming soon')),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _menuTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About',
                  subtitle: 'Tentang Aplikasi',
                  onTap: () {
                    // AboutPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _menuTile(
                  icon: Icons.update_outlined,
                  title: 'Periksa Update',
                  subtitle: 'Cek versi terbaru aplikasi',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // penting: hindari race condition
                      builder: (_) => UpdateDialog(
                        apiBaseUrl: 'https://app.yofacorpora.com/api',
                        token: null, // atau user token kalau ada
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // informasi tambahan: versi aplikasi
          const SizedBox(height: 12),
          _card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Versi Aplikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                    fontSize: 14,
                  ),
                ),
                Text(
                  appVersion,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  context.pushReplacement(const LoginPage());
                },
                error: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.error),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<LogoutBloc>().add(const LogoutEvent.logout());
                      },
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w900)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}
