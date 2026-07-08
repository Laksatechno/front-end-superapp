import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/bloc/auth/login_bloc.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/page/login/lupapassword_page.dart';
import 'package:yofa/page/app_shell.dart';
import 'package:yofa/page/register/register_page.dart';
import 'package:yofa/pageadmin/app_shell_admin.dart';
import 'package:yofa/pagecustomer/app_shell_customer.dart';
import '../../widgets/login_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _obscure = true;
  bool _remember = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submitLogin(BuildContext context) {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi')),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(LoginEvent.login(email, pass));
  }

  @override
  Widget build(BuildContext context) {
    // Jangan buat BlocProvider lagi di sini (sudah di main.dart)
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        state.maybeWhen(
          success: (data) async {
            await AuthLocalDatasource().saveAuthData(data);

            final role = (data.user?.role ?? '').toLowerCase().trim();

            final Widget target;

            if (role == 'superadmin') {
              target = const AppShellAdmin();
            } else if (role == 'customer') {
              target = const AppShellCustomer();
            } else {
              target = const AppShell();
            }

            if (!mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => target),
              (route) => false,
            );
          },
          error: (msg) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: LoginCard(
                    emailController: _emailCtrl,
                    passwordController: _passCtrl,
                    obscure: _obscure,
                    onToggleObscure: loading
                        ? () {}
                        : () => setState(() => _obscure = !_obscure),
                    remember: _remember,
                    onRememberChanged: loading
                        ? (_) {}
                        : (v) => setState(() => _remember = v),
                    onForgotPassword: loading
                        ? () {}
                        : () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LupaPasswordPage(),
                              ),
                            );
                          },
                    onLogin: loading ? () {} : () => _submitLogin(context),
                    loading: loading,
                    onRegister: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
