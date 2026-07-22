import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yofa/pagecustomer/tagihan/bloc/payment_bloc.dart';
import 'package:yofa/pagecustomer/tagihan/datasource/payment_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/tagihan_model.dart';
import 'package:yofa/theme/app_theme.dart';

class PaymentPage extends StatelessWidget {
  final Tagihan invoice;

  const PaymentPage({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(
        PaymentDatasource(),
      )..add(const PaymentEvent.load()),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (data) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bukti pembayaran berhasil diunggah.'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: const Color(0xffF7F8FA),
          appBar: AppBar(
            title: const Text(
              'Pembayaran',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: _PaymentView(invoice: invoice),
        ),
      ),
    );
  }
}

class _PaymentView extends StatefulWidget {
  final Tagihan invoice;

  const _PaymentView({required this.invoice});

  @override
  State<_PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<_PaymentView> {
  String? fileName;

  Future<void> _uploadBukti() async {
    try {
      final XFile? result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (result == null || !mounted) return;

      setState(() {
        fileName = result.name;
      });

      context.read<PaymentBloc>().add(
            PaymentEvent.upload(
              tagihanId: widget.invoice.id,
              file: File(result.path),
            ),
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _copyRekening() {
    Clipboard.setData(const ClipboardData(text: '1234567890'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primary,
        content: const Text('Nomor rekening berhasil disalin'),
      ),
    );
  }

  Widget _buildInstruction(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.purple.shade900,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Transfer Bank',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    color: AppTheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'BCA',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.account_balance,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nomor Rekening',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '1234567890',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                  letterSpacing: 1.5,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Material(
                              color: AppTheme.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: _copyRekening,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        size: 16,
                                        color: AppTheme.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Salin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 18,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'PT Laksa Medika Internusa',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.purple.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Petunjuk Transfer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.purple.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildInstruction('1.', 'Salin nomor rekening di atas.'),
                _buildInstruction('2.', 'Buka aplikasi bank/e-wallet Anda.'),
                _buildInstruction('3.', 'Pilih menu Transfer ke rekening BCA.'),
                _buildInstruction(
                    '4.', 'Masukkan nominal sesuai total pembayaran.'),
                _buildInstruction(
                    '5.', 'Upload bukti pembayaran di bawah ini.'),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primary,
                  AppTheme.primary.withOpacity(.7),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Pembayaran',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${widget.invoice.total}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          if (fileName != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(fileName!),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _uploadBukti,
              icon: const Icon(Icons.cloud_upload),
              label: const Text(
                'Upload Bukti Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return Stack(
          children: [
            _buildBody(),
            if (isLoading)
              const ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
