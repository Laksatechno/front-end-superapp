import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_text_field.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool obscure;
  final VoidCallback onToggleObscure;

  final bool remember;
  final ValueChanged<bool> onRememberChanged;

  final VoidCallback onForgotPassword;
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  final bool loading; // << tambah

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscure,
    required this.onToggleObscure,
    required this.remember,
    required this.onRememberChanged,
    required this.onForgotPassword,
    required this.onLogin,
    required this.onRegister,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading, // blok interaksi saat loading
      child: Opacity(
        opacity: loading ? 0.98 : 1,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'YF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOFA CORPORA',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textDark,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Masuk untuk melanjutkan',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email ',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: emailController,
                    hint: 'contoh@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 14),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: passwordController,
                    hint: '••••••••',
                    obscureText: obscure,
                    suffixIcon: IconButton(
                      onPressed: onToggleObscure,
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF8B7F87),
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => onRememberChanged(!remember),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: remember,
                                  onChanged: (v) => onRememberChanged(v ?? false),
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                    color: Color(0xFFBEB2BA),
                                    width: 1.2,
                                  ),
                                  activeColor: AppTheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Ingat saya',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF5E525A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: onForgotPassword,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          foregroundColor: AppTheme.primary,
                        ),
                        child: const Text(
                          'Lupa password?',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (loading) ...[
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.3,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Memproses...',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                              ),
                            ),
                          ] else ...[
                            const Text(
                              'Masuk',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // Tombol Register Customer
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: onRegister,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      foregroundColor: AppTheme.primary,
                    ),
                    child: const Text(
                      'Belum punya akun? Daftar sekarang',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    '© 2026 YOFA CORPORA',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF8E828A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // overlay tipis saat loading (optional)
            if (loading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
