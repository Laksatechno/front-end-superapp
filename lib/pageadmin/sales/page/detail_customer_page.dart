import 'package:flutter/material.dart';
import 'package:yofa/pageadmin/sales/customer/datasource/customer_ds.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';
import 'package:yofa/theme/app_theme.dart';

class DetailCustomerPage extends StatefulWidget {
  final int customerId;
  const DetailCustomerPage({super.key, required this.customerId});

  @override
  State<DetailCustomerPage> createState() => _DetailCustomerPageState();
}

class _DetailCustomerPageState extends State<DetailCustomerPage> {
  final _ds = CustomerDataSource();
  CustomerDetail? _detail;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final result = await _ds.fetchCustomerDetail(widget.customerId);
    result.fold(
      (err) {
        if (!mounted) return;
        setState(() {
          _error = err;
          _loading = false;
        });
      },
      (data) {
        if (!mounted) return;
        setState(() {
          _detail = data;
          _loading = false;
        });
      },
    );
  }

  // === Link ===
  Future<void> _showLinkSheet() async {
    List<LinkedUser>? users;
    String? searchErr;
    bool loadingUsers = true;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            // load once
            if (loadingUsers && users == null) {
              _ds.fetchUnlinkedUsers().then((r) {
                r.fold(
                  (e) => setSheetState(() {
                    searchErr = e;
                    loadingUsers = false;
                  }),
                  (list) => setSheetState(() {
                    users = list;
                    loadingUsers = false;
                  }),
                );
              });
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  MediaQuery.of(ctx).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Tautkan Akun User',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (loadingUsers)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      )
                    else if (searchErr != null)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(searchErr!, style: const TextStyle(color: Colors.red)),
                      )
                    else if (users == null || users!.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Tidak ada user yang tersedia untuk ditautkan.'),
                      )
                    else
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                          itemCount: users!.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final u = users![i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                                child: Text(
                                  u.name.isNotEmpty ? u.name[0].toUpperCase() : '?',
                                  style: const TextStyle(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              title: Text(u.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                              subtitle: Text(u.email),
                              trailing: const Icon(Icons.link_rounded, color: AppTheme.primary),
                              onTap: () async {
                                Navigator.pop(ctx);
                                await _linkUser(u);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _linkUser(LinkedUser user) async {
    final result = await _ds.linkUser(widget.customerId, user.id);
    result.fold(
      (err) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      },
      (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        _loadDetail();
      },
    );
  }

  Future<void> _unlinkUser() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Putuskan Tautan'),
        content: const Text('Akun user akan diputuskan dari customer ini.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Putuskan'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final result = await _ds.unlinkUser(widget.customerId);
    result.fold(
      (err) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      },
      (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        _loadDetail();
      },
    );
  }

  // === UI ===
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Detail Customer'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _loadDetail,
                          child: const Text('Coba lagi'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadDetail,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _sectionTitle('Informasi Customer'),
                      const SizedBox(height: 8),
                      _infoCard([
                        _infoRow(Icons.person_outline, 'Nama', _detail!.name),
                        _infoRow(Icons.phone_iphone_rounded, 'Telepon', _detail!.phone.isEmpty ? '-' : _detail!.phone),
                        _infoRow(Icons.email_outlined, 'Email', _detail!.email.isEmpty ? '-' : _detail!.email),
                        _infoRow(Icons.location_on_outlined, 'Alamat', _detail!.address),
                        _infoRow(Icons.badge_outlined, 'Tipe', _detail!.tipePelanggan),
                        _infoRow(Icons.map_outlined, 'Area', _detail!.area?.name ?? '-'),
                      ]),

                      const SizedBox(height: 20),
                      _sectionTitle('Akun User'),
                      const SizedBox(height: 8),
                      _buildUserSection(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildUserSection() {
    final user = _detail!.user;
    if (user != null) {
      return _infoCard([
        _infoRow(Icons.account_circle_outlined, 'Nama', user.name),
        _infoRow(Icons.email_outlined, 'Email', user.email),
        _infoRow(Icons.security_rounded, 'Role', user.role),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _unlinkUser,
            icon: const Icon(Icons.link_off_rounded, color: Colors.red),
            label: const Text('Putuskan Tautan', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ]);
    }

    // Belum ditautkan
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Column(
        children: [
          const Icon(Icons.account_circle_outlined, size: 40, color: Color(0xFF6F646B)),
          const SizedBox(height: 8),
          const Text(
            'Belum ditautkan ke akun manapun',
            style: TextStyle(color: Color(0xFF6F646B), fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showLinkSheet,
              icon: const Icon(Icons.link_rounded),
              label: const Text('Tautkan Akun User', style: TextStyle(fontWeight: FontWeight.w900)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 15,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppTheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6F646B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textDark,
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
