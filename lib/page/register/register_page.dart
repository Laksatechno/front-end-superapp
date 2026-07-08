import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/page/register/bloc/register_bloc.dart';
import 'package:yofa/page/register/pick_location_page.dart';
import 'package:yofa/pageadmin/sales/marketing/bloc/marketing_bloc.dart';
import 'package:yofa/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _controller = PageController();
  int _step = 0;

  // controllers
  final namaCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final hpCtrl = TextEditingController();
  final alamatCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  String? jenis;
  String? tipe;
  int? marketingId;

  double? lat;
  double? lng;

  bool hidePass = true;
  bool hideConfirm = true;

  final jenisList = ['NON PMI', 'PMI'];
  final tipeList = ['Reguler', 'Subdis'];

  @override
  void dispose() {
    _controller.dispose();
    namaCtrl.dispose();
    emailCtrl.dispose();
    hpCtrl.dispose();
    alamatCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void next() {
    if (!validateStep(_step)) return;

    if (_step < 3) {
      setState(() => _step++);
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      submit();
    }
  }

  void back() {
    if (_step == 0) return;

    setState(() => _step--);
    _controller.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  bool validateStep(int step) {
    switch (step) {
      case 0:
        return namaCtrl.text.isNotEmpty &&
            jenis != null &&
            tipe != null;

      case 1:
        return marketingId != null;

      case 2:
        return emailCtrl.text.isNotEmpty &&
            hpCtrl.text.isNotEmpty &&
            alamatCtrl.text.isNotEmpty;

      case 3:
        return passCtrl.text.isNotEmpty &&
            passCtrl.text == confirmCtrl.text;

      default:
        return false;
    }
  }

  void submit() {
    if (marketingId == null) return;

    context.read<RegisterBloc>().add(
          RegisterEvent.register(
            name: namaCtrl.text.trim(),
            email: emailCtrl.text.trim(),
            password: passCtrl.text,
            passwordConfirmation: confirmCtrl.text,
            noHp: hpCtrl.text,
            alamat: alamatCtrl.text,
            tipePelanggan: tipe!,
            jenisInstitusi: jenis!,
            marketingId: marketingId!,
          ),
        );
  }

  Widget progress() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (_step + 1) / 4,
          color: AppTheme.primary,
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(height: 10),
        Text(
          "Step ${_step + 1} of 4",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget btnNav() {
    return Row(
      children: [
        if (_step > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: back,
              child: const Text("Kembali"),
            ),
          ),
        if (_step > 0) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: next,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(_step == 3 ? "Daftar" : "Lanjut"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration success")),
            );
            Navigator.pop(context);
          },
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e)),
            );
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
          backgroundColor: AppTheme.bg,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Pendaftaran Pelanggan Baru",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 12),
                      progress(),
                      const SizedBox(height: 18),

                      Expanded(
                        child: PageView(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            step1(),
                            step2(),
                            step3(),
                            step4(),
                          ],
                        ),
                      ),

                      if (loading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: LinearProgressIndicator(),
                        ),

                      btnNav(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= STEP 1 =================
  Widget step1() {
    return Column(
      children: [
        TextField(
          controller: namaCtrl,
          decoration: input("Nama Institusi"),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField(
          value: jenis,
          items: jenisList
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => jenis = v),
          decoration: input("Jenis Institusi"),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField(
          value: tipe,
          items: tipeList
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => tipe = v),
          decoration: input("Tipe Pelanggan"),
        ),
      ],
    );
  }

  // ================= STEP 2 =================
  Widget step2() {
    return BlocBuilder<MarketingBloc, MarketingState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<MarketingBloc>().add(
                      const MarketingEvent.get(),
                    );
              },
              child: const Text("Load Marketing"),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e) => Center(child: Text(e)),
          loaded: (items) {
            return DropdownButtonFormField<int>(
              value: marketingId,
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => marketingId = v),
              decoration: input("Marketing"),
            );
          },
        );
      },
    );
  }

  // ================= STEP 3 =================
Widget step3() {
  return Column(
    children: [
      TextField(
        controller: emailCtrl,
        decoration: input("Email"),
      ),
      const SizedBox(height: 12),

      TextField(
        controller: hpCtrl,
        decoration: input("No HP"),
      ),
      const SizedBox(height: 12),

      TextField(
        controller: alamatCtrl,
        readOnly: false, // 🔥 bisa ketik manual
        decoration: input("Alamat").copyWith(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.map_outlined,
              color: Colors.grey,
            ),
            onPressed: () async {
              final res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PickLocationPage(),
                ),
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
        ),
      ),
    ],
  );
}

  // ================= STEP 4 =================
Widget step4() {
  return Column(
    children: [
      TextField(
        controller: passCtrl,
        obscureText: hidePass,
        decoration: input("Password").copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              hidePass
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                hidePass = !hidePass;
              });
            },
          ),
        ),
      ),

      const SizedBox(height: 12),

      TextField(
        controller: confirmCtrl,
        obscureText: hideConfirm,
        decoration: input("Konfirmasi Password").copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              hideConfirm
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                hideConfirm = !hideConfirm;
              });
            },
          ),
        ),
      ),
    ],
  );
}

  InputDecoration input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}