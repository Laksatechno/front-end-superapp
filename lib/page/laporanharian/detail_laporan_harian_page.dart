import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yofa/models/laporanharianmodels/laporan_harian_models.dart';
import '../../theme/app_theme.dart';
import 'edit_laporan_harian_page.dart';

class DetailLaporanHarianPage extends StatelessWidget {
  final LaporanHarianItem item;
  const DetailLaporanHarianPage({super.key, required this.item});

  Widget _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: item.status.bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        item.status.label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: item.status.fg,
          fontSize: 11.5,
        ),
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
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final submitted = item.status == LaporanStatus.submitted;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Detail Laporan Harian'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          _card(
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded, color: AppTheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    formatDate(item.date),
                    style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                  ),
                ),
                _badge(),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _actionBtn(
                  context,
                  icon: Icons.copy_rounded,
                  label: 'Copy',
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: item.activity));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Aktivitas disalin')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: submitted
                    ? _actionBtn(
                        context,
                        icon: Icons.share_outlined,
                        label: 'Share',
                        solid: true,
                        onTap: () {
                          // TODO: implement share (share_plus)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('TODO: Share laporan')),
                          );
                        },
                      )
                    : _actionBtn(
                        context,
                        icon: Icons.edit_outlined,
                        label: 'Edit',
                        solid: true,
                        onTap: () async {
                          final res = await Navigator.push<LaporanHarianItem>(
                            context,
                            MaterialPageRoute(builder: (_) => EditLaporanHarianPage(item: item)),
                          );
                          if (!context.mounted) return;
                          if (res != null) Navigator.pop(context, res);
                        },
                      ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Aktivitas', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 10),
                Text(
                  item.activity,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F646B),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool solid = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: solid ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEFE6EC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: solid ? Colors.white : AppTheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: solid ? Colors.white : AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
