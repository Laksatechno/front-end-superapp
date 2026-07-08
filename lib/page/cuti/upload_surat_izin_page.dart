import 'package:flutter/material.dart';
import 'package:yofa/page/cuti/model/cuti_models.dart';
import '../../theme/app_theme.dart';


class UploadSuratIzinPage extends StatefulWidget {
  final CutiItem item;
  const UploadSuratIzinPage({super.key, required this.item});

  @override
  State<UploadSuratIzinPage> createState() => _UploadSuratIzinPageState();
}

class _UploadSuratIzinPageState extends State<UploadSuratIzinPage> {
  String? _fileName;

  void _pickFileDummy() {
    // TODO: pakai file_picker
    setState(() => _fileName = 'surat_dokter.jpg');
  }

  void _upload() {
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih file terlebih dahulu')),
      );
      return;
    }

    // TODO: call API upload
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Upload berhasil')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Upload Surat Izin'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEFE6EC)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Surat Izin / Surat Dokter',
                  style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickFileDummy,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F6F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.upload_file_rounded, color: AppTheme.primary, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _fileName ?? 'Pilih file surat izin...',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: _fileName == null ? const Color(0xFF6F646B) : AppTheme.textDark,
                            ),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded, color: Color(0xFF6F646B)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _upload,
                    child: const Text('Upload', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
