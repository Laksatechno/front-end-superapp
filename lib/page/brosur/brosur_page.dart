import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class BrosurPage extends StatefulWidget {
  const BrosurPage({super.key});

  @override
  State<BrosurPage> createState() => _BrosurPageState();
}

class _BrosurPageState extends State<BrosurPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<_BrosurItem> _items = const [
    _BrosurItem(
      title: 'Brosur Gethscale',
      desc: 'Informasi produk Hemoscale, spesifikasi, keunggulan, dan cara penggunaan.',
    ),
    _BrosurItem(
      title: 'Brosur Hemoglobin Meter',
      desc: 'Panduan singkat hemoglobin meter, fitur utama, dan kelengkapan paket.',
    ),
    _BrosurItem(
      title: 'Brosur Vacutainer',
      desc: 'Daftar consumables laboratorium, varian produk, dan rekomendasi pemakaian.',
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onDownload(_BrosurItem item) {
    // TODO: implement download file
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download: ${item.title} (TODO)')),
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
          )
        ],
      ),
      child: child,
    );
  }

  Widget _searchBox() {
    return Container(
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
                hintText: 'Cari brosur...',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _searchCtrl.text.trim().toLowerCase();
    final filtered = q.isEmpty
        ? _items
        : _items
            .where((e) =>
                e.title.toLowerCase().contains(q) ||
                e.desc.toLowerCase().contains(q))
            .toList();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Brosur'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: _searchBox(),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final it = filtered[i];
                return _card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              it.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              it.desc,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6F646B),
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () => _onDownload(it),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4ECF2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEADDE6)),
                          ),
                          child: const Icon(
                            Icons.download_rounded,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                'Brosur tidak ditemukan',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.45),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BrosurItem {
  final String title;
  final String desc;
  const _BrosurItem({required this.title, required this.desc});
}
