import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/models/response/auth_response_model.dart';
import 'package:yofa/pageadmin/sales/products/barang_page.dart';
import 'package:yofa/page/callplan/callplan_page.dart';
import 'package:yofa/page/customer/customer_page.dart';
import 'package:yofa/page/cuti/cuti_page.dart';
import 'package:yofa/page/knowledge/knowledge_page.dart';
import 'package:yofa/page/kunjungan/kunjungan_page.dart';
import 'package:yofa/page/laporanharian/laporanharian_page.dart';
import 'package:yofa/page/notification/notification_page.dart';
import 'package:yofa/pageadmin/sales/order/order_page.dart';
import 'package:yofa/page/presensi/presensi_page.dart';
import 'package:yofa/page/profile/profile_page.dart';
import 'package:yofa/page/scanalat/scanalat_page.dart';
import 'package:yofa/widgets/more_menu_modal.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<PresensiPageState> _presensiKey = GlobalKey();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }


  final List<String> _months = const [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  String monthText = 'Presensi Bulan Januari';
  String yearText = '2026';
  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Pilih Bulan',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFEFE6EC)),

              // List bulan
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _months.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFEFE6EC)),
                  itemBuilder: (context, i) {
                    final m = _months[i];
                    final selected = monthText == 'Presensi Bulan $m';
                    return ListTile(
                      onTap: () {
                        setState(() => monthText = 'Presensi Bulan $m');
                        Navigator.pop(context);

                        // TODO: trigger reload data presensi sesuai bulan
                        // fetchPresensi(month: i+1, year: int.parse(yearText));
                      },
                      title: Text(
                        m,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textDark,
                        ),
                      ),
                      trailing: selected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppTheme.primary,
                            )
                          : const Icon(Icons.chevron_right_rounded),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _topAppBar() {
    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'YOFA CORPORA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilPage()),
                );
              },
              borderRadius: BorderRadius.circular(999),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFEAD6E4),
                child: Icon(Icons.person, color: AppTheme.primary, size: 18),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  Widget _profileCard() {
    return FutureBuilder<AuthResponseModel?>(
      future: AuthLocalDatasource()
          .getAuthData(), 
      builder: (context, snap) {
        final auth = snap.data;

        final greeting = _greeting();
        final userName =
            auth?.employee?.employeesName ?? auth?.user?.name ?? '-';

        final role = auth?.employee?.position?.name ?? auth?.user?.role ?? '-';

        final building = auth?.employee?.building?.name ?? '-';

        final dateText = DateFormat('EEEE, dd MMM yyyy', 'id_ID').format(DateTime.now());


        final shiftStart = auth?.employee?.shift?.start;
        final shiftEnd = auth?.employee?.shift?.end;
        final shiftText = (shiftStart != null && shiftEnd != null)
            ? '${_hhmm(shiftStart)} - ${_hhmm(shiftEnd)}'
            : '-';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEFE6EC)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F646B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F646B),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    building,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    dateText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    snap.connectionState == ConnectionState.waiting
                        ? '...'
                        : shiftText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 11) return 'Selamat Pagi';
    if (h < 15) return 'Selamat Siang';
    if (h < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  String _hhmm(String time) {
    // dari "08:00:00" => "08:00"
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }

  Widget _menuGrid() {
    final items = <_MenuItemData>[
      // _MenuItemData('Kehadiran', Icons.camera_alt_outlined),
      _MenuItemData('Kunjungan', Icons.how_to_reg_outlined),
      _MenuItemData('Cuti', Icons.event_available_outlined),
      _MenuItemData('Laporan\nHarian', Icons.receipt_long_outlined),
      _MenuItemData('Callplan', Icons.map_outlined),
      _MenuItemData('Scan Alat', Icons.qr_code_scanner_outlined),
      _MenuItemData('Knowledge', Icons.edit_note_outlined),
      _MenuItemData('Order', Icons.add_circle_outline),
      _MenuItemData('Barang', Icons.inventory_2_outlined),
      _MenuItemData('Customer', Icons.person_add_alt_1_outlined),
      _MenuItemData('Lainya..', Icons.more_horiz_rounded),
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
              if (it.label == 'Lainya..') {
                MoreMenuFullScreen.show(context);
                return;
              }

              // Arahkan ke halaman Kunjungan
              if (it.label == 'Kunjungan') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KunjunganPage()),
                );
                return;
              }
              if (it.label == 'Order') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderPage()),
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

              if (it.label == 'Customer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerPage()),
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

  Widget _presensiButtons() {
    Widget card({
      required String title,
      required String subtitle,
      required bool primary,
      required VoidCallback onTap,
    }) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: primary ? AppTheme.primary : const Color(0xFFEFE6EC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEADDE6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: primary ? Colors.white : AppTheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: primary ? Colors.white : AppTheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        card(
          title: 'Presensi Masuk',
          subtitle: 'Belum Presensi',
          primary: true,
          onTap: () {
            // PresensiPage(
            //   key: _presensiKey,
            //   active: _index == 1,
            // ),
          },
        ),
        const SizedBox(width: 12),
        card(
          title: 'Presensi Pulang',
          subtitle: 'Belum Presensi',
          primary: false,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _sectionTitle() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        // BAGIAN BULAN (KLIK)
        InkWell(
          onTap: _showMonthPicker,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              children: [
                Text(
                  monthText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.textDark,
                ),
              ],
            ),
          ),
        ),

        const Spacer(),
        const SizedBox(width: 10),
        Text(
          yearText,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _statGrid() {
    final stats = [
      _StatData('Hadir', '0 Hari', Icons.login_rounded, true),
      _StatData('Izin', '0 Hari', Icons.person_rounded, false),
      _StatData('Sakit', '0 Hari', Icons.sick_rounded, false),
      _StatData('Terlambat', '0 Hari', Icons.access_time_rounded, true),
    ];

    return GridView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.3,
      ),
      itemBuilder: (context, i) {
        final s = stats[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEFE6EC)),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: s.highlight
                      ? AppTheme.primary
                      : const Color(0xFFF4ECF2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  s.icon,
                  color: s.highlight ? Colors.white : AppTheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7C6F77),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Column(
        children: [
          _topAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                children: [
                  _profileCard(),
                  const SizedBox(height: 12),
                  _menuGrid(),
                  const SizedBox(height: 12),
                  _presensiButtons(),
                  const SizedBox(height: 14),
                  _sectionTitle(),
                  const SizedBox(height: 12),
                  _statGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: AppBottomNav(
      //   currentIndex: _currentIndex,
      //   onTap: (i) {
      //     setState(() => _currentIndex = i);
      //     // TODO: routing sesuai index
      //     // contoh:
      //     // if (i == 0) ...
      //   },
      // ),
    );
  }
}

class _MenuItemData {
  final String label;
  final IconData icon;
  _MenuItemData(this.label, this.icon);
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final bool highlight;
  _StatData(this.title, this.value, this.icon, this.highlight);
}
