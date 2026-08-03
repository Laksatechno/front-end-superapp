import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/page/register/bloc/register_bloc.dart';
import 'package:yofa/page/register/pick_location_page.dart';
import 'package:yofa/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  final namaInstansiCtrl = TextEditingController();
  final namaPicCtrl = TextEditingController();
  final nomorPicCtrl = TextEditingController();
  final alamatCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  double? lat;
  double? lng;

  bool hidePass = true;
  bool hideConfirm = true;
  int _currentStep = 0;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    namaInstansiCtrl.dispose();
    namaPicCtrl.dispose();
    nomorPicCtrl.dispose();
    alamatCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  bool get _isStep1Valid =>
      namaInstansiCtrl.text.isNotEmpty &&
      namaPicCtrl.text.isNotEmpty &&
      nomorPicCtrl.text.isNotEmpty &&
      alamatCtrl.text.isNotEmpty;

  bool get _isStep2Valid =>
      emailCtrl.text.isNotEmpty &&
      passCtrl.text.isNotEmpty &&
      passCtrl.text == confirmCtrl.text;

  bool get _isValid => _isStep1Valid && _isStep2Valid;

  void _nextStep() {
    if (_currentStep == 0 && !_isStep1Valid) {
      _showSnack('Lengkapi semua informasi instansi terlebih dahulu');
      return;
    }
    setState(() => _currentStep = 1);
    _fadeCtrl.forward(from: 0);
  }

  void _prevStep() {
    setState(() => _currentStep = 0);
    _fadeCtrl.forward(from: 0);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }

  void submit() {
    if (!_isValid) {
      _showSnack('Lengkapi semua field dan pastikan password cocok');
      return;
    }
    context.read<RegisterBloc>().add(
          RegisterEvent.register(
            namaInstansi: namaInstansiCtrl.text.trim(),
            namaPic: namaPicCtrl.text.trim(),
            nomorPic: nomorPicCtrl.text.trim(),
            alamat: alamatCtrl.text.trim(),
            email: emailCtrl.text.trim(),
            password: passCtrl.text,
            passwordConfirmation: confirmCtrl.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
            _showSnack('Pendaftaran berhasil! Silakan masuk.');
            Navigator.pop(context);
          },
          error: (e) => _showSnack(e),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(loading: () => true, orElse: () => false);
        return Scaffold(
          backgroundColor: const Color(0xFFF7F3F6),
          body: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                        child: FadeTransition(
                          opacity: _fadeAnim,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildStepIndicator(),
                              const SizedBox(height: 24),
                              _buildFormCard(loading),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF651769), Color(0xFF8B3D8F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 4),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'YF',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOFA CORPORA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'Pendaftaran Pelanggan Baru',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _stepDot(0, 'Info Instansi', Icons.business_rounded),
        Expanded(
          child: Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: _currentStep >= 1
                  ? AppTheme.primary
                  : const Color(0xFFDDD0DB),
            ),
          ),
        ),
        _stepDot(1, 'Akun & Keamanan', Icons.shield_rounded),
      ],
    );
  }

  Widget _stepDot(int step, String label, IconData icon) {
    final isActive = _currentStep == step;
    final isDone = _currentStep > step;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppTheme.primary
                : isDone
                    ? AppTheme.primary.withOpacity(0.85)
                    : const Color(0xFFE8DEE6),
            boxShadow: isActive
                ? [BoxShadow(color: AppTheme.primary.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))]
                : [],
          ),
          alignment: Alignment.center,
          child: isDone
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
              : Icon(icon, color: isActive ? Colors.white : const Color(0xFFB09AB0), size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? AppTheme.primary : const Color(0xFF9A8F97),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(bool loading) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCardHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: _currentStep == 0 ? _buildStep1() : _buildStep2(loading),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    final titles = ['Informasi Instansi', 'Akun & Keamanan'];
    final subtitles = [
      'Isi data perusahaan atau institusi Anda',
      'Buat kredensial untuk masuk ke akun',
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0E8EF), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              '${_currentStep + 1}',
              style: const TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titles[_currentStep],
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                subtitles[_currentStep],
                style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        _buildLabel('Nama Instansi', Icons.business_outlined),
        const SizedBox(height: 8),
        _buildField(
          controller: namaInstansiCtrl,
          hint: 'Contoh: PT. Sumber Makmur',
          prefixIcon: Icons.business_outlined,
        ),
        const SizedBox(height: 16),
        _buildLabel('Nama PIC', Icons.person_outline_rounded),
        const SizedBox(height: 8),
        _buildField(
          controller: namaPicCtrl,
          hint: 'Nama penanggung jawab',
          prefixIcon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 16),
        _buildLabel('Nomor PIC', Icons.phone_outlined),
        const SizedBox(height: 8),
        _buildField(
          controller: nomorPicCtrl,
          hint: '08xxxxxxxxxx',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildLabel('Alamat', Icons.location_on_outlined),
        const SizedBox(height: 8),
        _buildAlamatField(),
        const SizedBox(height: 28),
        _buildNextButton(),
        const SizedBox(height: 12),
        _buildLoginLink(),
      ],
    );
  }

  Widget _buildStep2(bool loading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        _buildLabel('Email', Icons.email_outlined),
        const SizedBox(height: 8),
        _buildField(
          controller: emailCtrl,
          hint: 'contoh@email.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        _buildLabel('Password', Icons.lock_outline_rounded),
        const SizedBox(height: 8),
        _buildPasswordField(
          controller: passCtrl,
          hint: 'Minimal 8 karakter',
          hide: hidePass,
          onToggle: () => setState(() => hidePass = !hidePass),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 8),
        _buildPasswordStrength(),
        const SizedBox(height: 16),
        _buildLabel('Konfirmasi Password', Icons.lock_outline_rounded),
        const SizedBox(height: 8),
        _buildPasswordField(
          controller: confirmCtrl,
          hint: 'Ulangi password',
          hide: hideConfirm,
          onToggle: () => setState(() => hideConfirm = !hideConfirm),
          onChanged: (_) => setState(() {}),
          isConfirm: true,
        ),
        if (confirmCtrl.text.isNotEmpty && passCtrl.text != confirmCtrl.text)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Row(
              children: const [
                Icon(Icons.info_outline_rounded, size: 13, color: Color(0xFFE53935)),
                SizedBox(width: 4),
                Text(
                  'Password tidak cocok',
                  style: TextStyle(fontSize: 11.5, color: Color(0xFFE53935), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: loading ? null : _prevStep,
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
                label: const Text('Kembali'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  side: const BorderSide(color: AppTheme.primary, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: _buildSubmitButton(loading),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildLoginLink(),
      ],
    );
  }

  Widget _buildPasswordStrength() {
    if (passCtrl.text.isEmpty) return const SizedBox.shrink();
    final len = passCtrl.text.length;
    final hasUpper = passCtrl.text.contains(RegExp(r'[A-Z]'));
    final hasNum = passCtrl.text.contains(RegExp(r'[0-9]'));
    final score = (len >= 8 ? 1 : 0) + (hasUpper ? 1 : 0) + (hasNum ? 1 : 0);
    final labels = ['Lemah', 'Cukup', 'Kuat'];
    final colors = [const Color(0xFFE53935), const Color(0xFFFFA726), const Color(0xFF43A047)];
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          ...List.generate(3, (i) => Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: i < score ? colors[score - 1] : const Color(0xFFEDE3EC),
              ),
            ),
          )),
          const SizedBox(width: 8),
          Text(
            score > 0 ? labels[score - 1] : '',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: score > 0 ? colors[score - 1] : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onChanged: onChanged ?? (_) => setState(() {}),
      style: const TextStyle(fontSize: 14, color: AppTheme.textDark, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13.5, color: AppTheme.hint, fontWeight: FontWeight.w400),
        prefixIcon: Icon(prefixIcon, size: 18, color: AppTheme.hint),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFFAF7FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Color(0xFFE7DAE3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Color(0xFFE7DAE3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.8),
        ),
      ),
    );
  }

  Widget _buildAlamatField() {
    return TextField(
      controller: alamatCtrl,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(fontSize: 14, color: AppTheme.textDark, fontWeight: FontWeight.w500),
      maxLines: 2,
      minLines: 1,
      decoration: InputDecoration(
        hintText: 'Jl. contoh No. 1, Kota',
        hintStyle: const TextStyle(fontSize: 13.5, color: AppTheme.hint, fontWeight: FontWeight.w400),
        prefixIcon: const Icon(Icons.location_on_outlined, size: 18, color: AppTheme.hint),
        suffixIcon: IconButton(
          icon: const Icon(Icons.map_outlined, color: AppTheme.primary, size: 20),
          tooltip: 'Pilih lokasi di peta',
          onPressed: () async {
            final res = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PickLocationPage()),
            );
            if (res != null) {
              setState(() {
                alamatCtrl.text = res['address'] ?? '';
                lat = res['lat'];
                lng = res['lng'];
              });
            }
          },
        ),
        filled: true,
        fillColor: const Color(0xFFFAF7FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Color(0xFFE7DAE3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Color(0xFFE7DAE3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.8),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool hide,
    required VoidCallback onToggle,
    void Function(String)? onChanged,
    bool isConfirm = false,
  }) {
    final mismatch = isConfirm && controller.text.isNotEmpty && passCtrl.text != controller.text;
    return TextField(
      controller: controller,
      obscureText: hide,
      onChanged: onChanged ?? (_) => setState(() {}),
      style: const TextStyle(fontSize: 14, color: AppTheme.textDark, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13.5, color: AppTheme.hint, fontWeight: FontWeight.w400),
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppTheme.hint),
        suffixIcon: IconButton(
          icon: Icon(
            hide ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 20,
            color: AppTheme.hint,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: const Color(0xFFFAF7FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: mismatch ? const Color(0xFFE53935) : const Color(0xFFE7DAE3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: mismatch ? const Color(0xFFE53935) : const Color(0xFFE7DAE3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: mismatch ? const Color(0xFFE53935) : AppTheme.primary,
            width: 1.8,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final enabled = _isStep1Valid;
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: enabled ? _nextStep : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          disabledBackgroundColor: const Color(0xFFCFBFCE),
          foregroundColor: Colors.white,
          elevation: enabled ? 2 : 0,
          shadowColor: AppTheme.primary.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Lanjutkan', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool loading) {
    final enabled = _isStep2Valid && !loading;
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: enabled ? submit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          disabledBackgroundColor: const Color(0xFFCFBFCE),
          foregroundColor: Colors.white,
          elevation: enabled ? 2 : 0,
          shadowColor: AppTheme.primary.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.how_to_reg_rounded, size: 18),
                  SizedBox(width: 8),
                  Text('Daftar Sekarang', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ],
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sudah punya akun?',
            style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              foregroundColor: AppTheme.primary,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Masuk di sini',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
