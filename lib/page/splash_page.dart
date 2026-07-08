import 'package:flutter/material.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/page/app_shell.dart';
import 'package:yofa/page/login/login_page.dart';
import 'package:yofa/pageadmin/app_shell_admin.dart';
import 'package:yofa/pagecustomer/app_shell_customer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashDecision {
  final bool isAuth;
  final String? role;
  const _SplashDecision({required this.isAuth, required this.role});
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;

  void _go(Widget page) {
    if (!mounted || _navigated) return;
    _navigated = true;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<_SplashDecision> _load() async {
    final authDs = AuthLocalDatasource();
    final isAuth = await authDs.isAuth();
    if (!isAuth) return const _SplashDecision(isAuth: false, role: null);

    final auth = await authDs.getAuthData(); // AuthResponseModel?
    final role = auth?.user?.role;           // ambil role dari user
    final position = auth?.employee?.position;   // ambil posisi dari user
    print ('SplashPage: user role = $position $role'); // debug
    return _SplashDecision(isAuth: true, role: role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<_SplashDecision>(
        future: _load(),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              children: [
                Spacer(),
                // TODO: logo / loading widget
                CircularProgressIndicator(),
                Spacer(),
              ],
            );
          }

          // error -> login
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(seconds: 1), () => _go(const LoginPage()));
            });
            return const Column(
              children: [
                Spacer(),
                Text('Terjadi kesalahan...'),
                Spacer(),
              ],
            );
          }

          final decision = snapshot.data ?? const _SplashDecision(isAuth: false, role: null);

          // tentukan tujuan
          final Widget target;
          if (!decision.isAuth) {
            target = const LoginPage();
          } else if ((decision.role ?? '').toLowerCase() == 'superadmin') {
            print ('SplashPage: user is superadmin, navigating to AppShellAdmin');
            target = const AppShellAdmin(); // ✅ khusus superadmin
          }
          else if ((decision.role ?? '').toLowerCase() == 'customer') {
            print ('SplashPage: user is customer, navigating to AppShellCustomer');
            target = const AppShellCustomer(); //  khusus customer
          } 
          
          else {
            target = const AppShell(); // ✅ user biasa
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(seconds: 1), () => _go(target));
          });

          return const Column(
            children: [
              Spacer(),
              // TODO: logo
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}
