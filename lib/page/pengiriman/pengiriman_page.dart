import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';
import 'detail_pengiriman_page.dart';

class PengirimanPage extends StatefulWidget {
  const PengirimanPage({super.key});

  @override
  State<PengirimanPage> createState() => _PengirimanPageState();
}

class _PengirimanPageState extends State<PengirimanPage> {
  final _searchCtrl = TextEditingController();

  final List<PengirimanItem> _items = [
    PengirimanItem(
      invoice: 'INV-2026-0012',
      customer: 'RS Sumber Sehat',
      sentAt: DateTime(2026, 1, 23, 10, 12),
      statusText: 'Pesanan Sudah diserahkan ke logistik',
      stage: ShippingStage.handover,
      proofUrl:
          'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=1200',
    ),
    PengirimanItem(
      invoice: 'INV-2026-0013',
      customer: 'Klinik Maju Jaya',
      sentAt: DateTime(2026, 1, 23, 13, 35),
      statusText: 'Pesanan Sedang perjalanan',
      stage: ShippingStage.onTheWay,
      proofUrl:
          'https://images.unsplash.com/photo-1529070538774-1843cb3265df?w=1200',
    ),
    PengirimanItem(
      invoice: 'INV-2026-0014',
      customer: 'Apotek Sehat Selalu',
      sentAt: DateTime(2026, 1, 22, 16, 5),
      statusText: 'Barang sampai',
      stage: ShippingStage.delivered,
      proofUrl:
          'https://images.unsplash.com/photo-1600566753051-f0fbc6a58656?w=1200',
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String _fmtDateTime(DateTime dt) {
    String two(int x) => x.toString().padLeft(2, '0');
    const months = [
      'Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'
    ];
    final m = months[(dt.month - 1).clamp(0, 11)];
    return '${dt.day} $m ${dt.year} • ${two(dt.hour)}:${two(dt.minute)}';
  }

  List<PengirimanItem> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((e) {
      return e.invoice.toLowerCase().contains(q) ||
          e.customer.toLowerCase().contains(q);
    }).toList();
  }

  Color _statusColor(ShippingStage s) {
    // soft purple theme
    return AppTheme.primary;
  }

  Widget _pill(String text, {bool solid = false, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : const Color(0xFFF4ECF2),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: solid ? Colors.white : AppTheme.primary),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: solid ? Colors.white : AppTheme.primary,
            ),
          ),
        ],
      ),
    );
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
          ),
        ],
      ),
      child: child,
    );
  }

  void _openDetail(PengirimanItem it) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPengirimanPage(item: it)),
    );
  }

  void _processShipping(PengirimanItem it) {
    // dummy: update tahap + status
    setState(() {
      if (it.stage == ShippingStage.handover) {
        it.stage = ShippingStage.onTheWay;
        it.statusText = 'Pesanan Sedang perjalanan';
      } else if (it.stage == ShippingStage.onTheWay) {
        it.stage = ShippingStage.delivered;
        it.statusText = 'Barang sampai';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update status: ${it.invoice}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Pengiriman'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // search
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Cari no invoice / customer...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  if (_searchCtrl.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                    ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final it = items[i];
                return _card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // left info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              it.invoice,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              it.customer,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF6F646B),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _pill('Dikirim: ${_fmtDateTime(it.sentAt)}',
                                    icon: Icons.local_shipping_outlined),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _pill(it.statusText, solid: false, icon: Icons.info_outline_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // right actions
                      Column(
                        children: [
                          SizedBox(
                            height: 38,
                            child: OutlinedButton(
                              onPressed: () => _openDetail(it),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.primary,
                                side: const BorderSide(color: Color(0xFFEADDE6)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: const Text(
                                'Detail',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              onPressed: () => _processShipping(it),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _statusColor(it.stage),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: const Text(
                                'Proses',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum ShippingStage { handover, onTheWay, delivered }

class PengirimanItem {
  String invoice;
  String customer;
  DateTime sentAt;
  String statusText;
  ShippingStage stage;
  String proofUrl;

  PengirimanItem({
    required this.invoice,
    required this.customer,
    required this.sentAt,
    required this.statusText,
    required this.stage,
    required this.proofUrl,
  });
}
