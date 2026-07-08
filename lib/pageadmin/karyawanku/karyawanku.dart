import 'package:flutter/material.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/screens/alat_page.dart';
import 'package:yofa/pageadmin/sales/products/barang_page.dart';
import 'package:yofa/page/callplan/callplan_page.dart';
import 'package:yofa/page/cuti/cuti_page.dart';
import 'package:yofa/page/knowledge/knowledge_page.dart';
import 'package:yofa/page/laporanharian/laporanharian_page.dart';
import 'package:yofa/pageadmin/karyawanku/kelolapresensi/kelolapresensi_page.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/widgets/more_menu_modal.dart';

class KaryawankuPage extends StatefulWidget {
  const KaryawankuPage({super.key});

  @override
  State<KaryawankuPage> createState() => _KaryawankuPageState();
}

class _KaryawankuPageState extends State<KaryawankuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Karyawanku'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                children: [
                  _menuGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


    Widget _menuGrid() {
    final items = <_MenuItemData>[
      _MenuItemData('Kehadiran', Icons.access_time_outlined),
      _MenuItemData('Cuti', Icons.beach_access_outlined),
      _MenuItemData('Laporan\nHarian', Icons.note_alt_outlined),
      _MenuItemData('Callplan', Icons.map_outlined),
      _MenuItemData('Scan Alat', Icons.qr_code_scanner_outlined),
      _MenuItemData('Knowledge', Icons.edit_note_outlined),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, i) {
          final it = items[i];
          return InkWell(
            onTap: () {
              

              // Arahkan ke halaman Karyawanku
              if (it.label == 'Kehadiran') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KelolapresensiPage()),
                );
                return;
              }

              if (it.label == 'Cuti') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CutiPage()),
                );
                return;
              }

              if (it.label == 'Laporan\nHarian') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LaporanHarianPage()),
                );
                return;
              }

              if (it.label == 'Barang') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarangPage()),
                );
                return;
              }


              if (it.label == 'Callplan') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CallplanPage()),
                );
                return;
              }
              if (it.label == 'Knowledge') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KnowledgePage()),
                );
                return;
              }
              if (it.label == 'Scan Alat') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AlatPage()),
                );
                return;
              }

              //menu selanjutnya
            },

            borderRadius: BorderRadius.circular(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4ECF2),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFEADDE6)),
                  ),
                  child: Icon(it.icon, color: AppTheme.primary, size: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  it.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6F646B),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
class _MenuItemData {
  final String label;
  final IconData icon;
  _MenuItemData(this.label, this.icon);
}