import 'package:flutter/material.dart';
import 'package:yofa/page/kunjungan/KunjunganCameraPage.dart';
import 'package:yofa/page/kunjungan/unplan_page.dart';
import '../../theme/app_theme.dart';

class KunjunganPage extends StatefulWidget {
  const KunjunganPage({super.key});

  @override
  State<KunjunganPage> createState() => _KunjunganPageState();
}

class _KunjunganPageState extends State<KunjunganPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  // dummy data (ganti dari API kamu)
  final List<VisitItem> _all = [
    VisitItem(
      outlet: 'PMI Sleman',
      date: 'Senin, 19 Jan 2026',
      note: 'Kunjungan rutin - Followup HB Meter',
    ),
    VisitItem(
      outlet: 'RS PKU Yogyakarta',
      date: 'Selasa, 20 Jan 2026',
      note: 'Follow up penawaran & demo alat',
    ),
    VisitItem(
      outlet: 'PMI Gunungkidul',
      date: 'Rabu, 21 Jan 2026',
      note: 'Presentasi Produk',
    ),
  ];

  String _keyword = '';

  List<VisitItem> get _filtered {
    if (_keyword.trim().isEmpty) return _all;
    final q = _keyword.toLowerCase();
    return _all.where((e) {
      return e.outlet.toLowerCase().contains(q) ||
          e.note.toLowerCase().contains(q) ||
          e.date.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

    void _openCamera(VisitItem item) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Kunjungancamerapage(item: item),
        ),
      );
    }


  void _unplan() {
          Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UnplanCameraPage(),
        ),
      );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF9B8F97)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _keyword = v),
              decoration: const InputDecoration(
                hintText: 'Cari outlet / tanggal / keterangan...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_keyword.isNotEmpty)
            InkWell(
              onTap: () {
                _searchCtrl.clear();
                setState(() => _keyword = '');
              },
              borderRadius: BorderRadius.circular(999),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.close_rounded, color: Color(0xFF9B8F97)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _visitCard(VisitItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.outlet,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded,
                        size: 16, color: AppTheme.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7C6F77),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.notes_rounded,
                        size: 16, color: AppTheme.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.note,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6F646B),
                          fontSize: 12,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // right camera rounded
          InkWell(
            onTap: () => _openCamera(item),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF4ECF2),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEADDE6)),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unplanButton() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _unplan,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'UNPLAN',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.3),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Kunjungan'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: _searchBar(),
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Text(
                      'Data kunjungan tidak ditemukan',
                      style: TextStyle(
                        color: Color(0xFF7C6F77),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _visitCard(list[i]),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _unplanButton(),
    );
  }
}

class VisitItem {
  final String outlet;
  final String date;
  final String note;

  VisitItem({
    required this.outlet,
    required this.date,
    required this.note,
  });
}
