import 'package:flutter/material.dart';
import 'package:yofa/page/pengiriman/pengiriman_page.dart';
import 'package:yofa/pageadmin/sales/products/barang_page.dart';
import 'package:yofa/page/callplan/callplan_page.dart';
import 'package:yofa/page/cuti/cuti_page.dart';
import 'package:yofa/page/knowledge/knowledge_page.dart';
import 'package:yofa/page/laporanharian/laporanharian_page.dart';
import 'package:yofa/pageadmin/sales/order/order_page.dart';
import 'package:yofa/page/scanalat/scanalat_page.dart';
import 'package:yofa/pageadmin/karyawanku/kelolapresensi/kelolapresensi_page.dart';
import 'package:yofa/pageadmin/sales/page/customer_page.dart';
import 'package:yofa/pageadmin/sales/tagihansales/tagihan_sales.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/widgets/more_menu_modal.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Sales'),
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
      _MenuItemData('Order', Icons.access_time_outlined),
      _MenuItemData('Customer', Icons.beach_access_outlined),
      _MenuItemData('Barang', Icons.note_alt_outlined),
      _MenuItemData('Tagihan', Icons.receipt_long_outlined),
      _MenuItemData('Pengiriman', Icons.local_shipping_outlined),
      _MenuItemData('Laporan', Icons.qr_code_scanner_outlined),
      _MenuItemData('Brosur', Icons.edit_note_outlined),
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
              if (it.label == 'Order') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderPage()),
                );
                return;
              }

              if (it.label == 'Customer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerPage()),
                );
                return;
              }

              if (it.label == 'Tagihan') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TagihanSales()),
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


              if (it.label == 'Prngiriman') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PengirimanPage()),
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
                  MaterialPageRoute(builder: (_) => const ScanAlatPage()),
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