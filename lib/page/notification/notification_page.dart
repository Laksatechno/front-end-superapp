import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yofa/page/notification/bloc/notifikasi_bloc.dart';
import 'package:yofa/page/notification/bloc/notifikasi_event.dart';
import 'package:yofa/page/notification/bloc/notifikasi_state.dart';
import 'package:yofa/page/notification/datasource/notifikasi_datasource.dart';
import 'package:yofa/page/notification/model/notifikasi_model.dart';
import 'package:yofa/theme/app_theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'semua';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotifikasiBloc(
        NotifikasiDataSource(),
      )..add(const NotifikasiEvent.load()),
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<NotifikasiBloc, NotifikasiState>(
          builder: (context, state) {
            return SafeArea(
              child: RefreshIndicator(
                color: AppTheme.primary,
                onRefresh: () async {
                  context.read<NotifikasiBloc>().add(const NotifikasiEvent.load());
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth >= 900;
                    final maxWidth = isDesktop ? 820.0 : double.infinity;

                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    state.when(
                                      initial: () => const _HeaderSummary(total: 0),
                                      loading: () => const _HeaderSummary(total: 0),
                                      loaded: (data) => _HeaderSummary(total: _filteredCount(data)),
                                      error: (_) => const _HeaderSummary(total: 0),
                                    ),
                                    const SizedBox(height: 16),
                                    _FilterSection(
                                      selectedFilter: selectedFilter,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedFilter = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            state.when(
                              initial: () => const SliverFillRemaining(
                                hasScrollBody: false,
                                child: _EmptyNotification(),
                              ),
                              loading: () => const SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                              loaded: (data) {
                                final filtered = _applyFilter(data);
                                if (filtered.isEmpty) {
                                  return const SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: _EmptyNotification(),
                                  );
                                }
                                return SliverPadding(
                                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                                  sliver: SliverList.separated(
                                    itemCount: filtered.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final item = filtered[index];
                                      return _NotificationCard(item: item);
                                    },
                                  ),
                                );
                              },
                              error: (message) => SliverFillRemaining(
                                hasScrollBody: false,
                                child: _ErrorNotification(message: message),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<NotifikasiModel> _applyFilter(List<NotifikasiModel> data) {
    if (selectedFilter == 'semua') return data;
    return data.where((item) => item.category == selectedFilter).toList();
  }

  int _filteredCount(List<NotifikasiModel> data) {
    return _applyFilter(data).length;
  }
}

class _HeaderSummary extends StatelessWidget {
  final int total;

  const _HeaderSummary({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifikasi Terbaru',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total notifikasi tersedia',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
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

class _FilterSection extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  const _FilterSection({
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChipItem(
          label: 'Semua',
          value: 'semua',
          icon: Icons.apps_rounded,
          selectedFilter: selectedFilter,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        _FilterChipItem(
          label: 'Order',
          value: 'order',
          icon: Icons.shopping_bag_outlined,
          selectedFilter: selectedFilter,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        _FilterChipItem(
          label: 'Pengumuman',
          value: 'pengumuman',
          icon: Icons.campaign_outlined,
          selectedFilter: selectedFilter,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  const _FilterChipItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedFilter == value;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppTheme.primary : AppTheme.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: isSelected ? Colors.white : AppTheme.textMuted,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textDark,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotifikasiModel item;

  const _NotificationCard({required this.item});

  IconData get icon {
    switch (item.category.toLowerCase()) {
      case 'order':
        return Icons.shopping_cart_checkout_rounded;
      case 'pengumuman':
        return Icons.campaign_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color get iconColor {
    switch (item.category.toLowerCase()) {
      case 'order':
        return Colors.green;
      case 'pengumuman':
        return Colors.orange;
      default:
        return AppTheme.primary;
    }
  }

  String get categoryLabel {
    switch (item.category.toLowerCase()) {
      case 'order':
        return 'Order';
      case 'pengumuman':
        return 'Pengumuman';
      default:
        return 'Notification';
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          categoryLabel,
                          style: TextStyle(
                            color: iconColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          _formatTime(item.createdAt),
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        if (item.isRead == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Baru',
                              style: TextStyle(
                                color: iconColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 15.5,
                        fontWeight: item.isRead == 0
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.body,
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.hint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyNotification extends StatelessWidget {
  const _EmptyNotification();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 58,
              color: AppTheme.textMuted.withOpacity(0.55),
            ),
            const SizedBox(height: 12),
            const Text(
              'Belum ada notifikasi',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Notifikasi order dan pengumuman akan tampil di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorNotification extends StatelessWidget {
  final String message;

  const _ErrorNotification({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 58,
              color: Colors.red.withOpacity(0.7),
            ),
            const SizedBox(height: 12),
            const Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<NotifikasiBloc>().add(const NotifikasiEvent.load());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
