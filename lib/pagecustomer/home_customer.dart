import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/models/response/auth_response_model.dart';
import 'package:yofa/page/brosur/brosur_page.dart';
import 'package:yofa/page/notification/notification_page.dart';
import 'package:yofa/page/profile/profile_page.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/screens/alat_page.dart';
import 'package:yofa/pagecustomer/order/order_page.dart';
import 'package:yofa/pagecustomer/shipping/shipping_customer_page.dart';
import '../../theme/app_theme.dart';

class HomeCustomerPage extends StatefulWidget {
  const HomeCustomerPage({super.key});

  @override
  State<HomeCustomerPage> createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {

  @override
  void initState() {
    super.initState();
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
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
                        fontSize: 16,
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
                        fontSize: 14,
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
                    dateText,

                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppTheme.textDark,
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

    _MenuItemData(
      'Order',
      Icons.shopping_bag_outlined,
      subtitle: 'Memesan Produk',
      badge: 'BARU!',
    ),


    _MenuItemData(
      'Scan Alat',
      Icons.qr_code_scanner_rounded,
      subtitle: 'Scan perangkat HB',
    ),


    _MenuItemData(
      'Pengiriman',
      Icons.local_shipping_outlined,
      subtitle: 'Cek status kirim',
    ),


    _MenuItemData(
      'Brosur',
      Icons.menu_book_rounded,
      subtitle: 'Lihat katalog',
    ),

    _MenuItemData(
      'Tagihan',
      Icons.receipt_long_rounded,
      subtitle: 'Cek tagihan',
    )

  ];


  return GridView.builder(

    itemCount: items.length,

    shrinkWrap: true,

    physics: const NeverScrollableScrollPhysics(),


    gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.5,

    ),


    itemBuilder: (context, i) {


      final it = items[i];


      return InkWell(

        borderRadius: BorderRadius.circular(20),


        onTap: () {

          if (it.label == 'Order') {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OrderCustomerPage(),
              ),
            );

          }


          if (it.label == 'Scan Alat') {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AlatPage(),
              ),
            );

          }


          if (it.label == 'Pengiriman') {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PengirimanPage(),
              ),
            );

          }


          if (it.label == 'Brosur') {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BrosurPage(),
              ),
            );

          }

          if (it.label == 'Tagihan') {

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const TagihanPage(),
            //   ),
            // );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fitur Tagihan akan segera hadir.'),
              ),
            );
          }
          
        },


        child: Container(

          padding: const EdgeInsets.all(16),


          decoration: BoxDecoration(

            color: Colors.white,


            borderRadius: BorderRadius.circular(20),


            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(0.05),

                blurRadius: 12,

                offset: const Offset(0,4),

              ),

            ],

          ),


          child: Stack(

            children: [


              Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                mainAxisAlignment:
                    MainAxisAlignment.start,


                children: [


                  Icon(

                    it.icon,

                    size: 34,

                    color: AppTheme.primary,

                  ),


                  const SizedBox(height: 8),


                  Text(

                    it.label,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,


                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.w800,

                      color: Colors.black,

                    ),

                  ),


                  // const SizedBox(height: 4),


                  Text(

                    it.subtitle ?? '',


                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,


                    style: const TextStyle(

                      fontSize: 13,

                      color:
                          Color(0xFF999999),

                    ),

                  ),

                ],

              ),



              if(it.badge != null)

                Positioned(

                  right: 0,

                  top: 0,

                  child: Text(

                    it.badge!,


                    style: const TextStyle(

                      color:
                          Color(0xFFE91E63),

                      fontSize: 12,

                      fontWeight:
                          FontWeight.w900,

                    ),

                  ),

                ),


            ],

          ),

        ),

      );

    },

  );

}
  Widget _statGrid() {
    final stats = [
      _StatData('Total Order', '0', Icons.receipt_long_rounded, true),
      _StatData('Pengiriman', '0', Icons.local_shipping_rounded, false),
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(0.05),

                blurRadius: 12,

                offset: const Offset(0,4),

              ),

            ],

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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                _profileCard(),

                // const SizedBox(height: 8),

                _menuGrid(),

                // const SizedBox(height: 8),

                _statGrid(),

              ],
            ),
          ),
        ),

      ],
    ),
  );
}
}

class _MenuItemData {
  final String label;
  final IconData icon;
  final String? subtitle;
  final String? badge;

  _MenuItemData(
    this.label,
    this.icon, {
    this.subtitle,
    this.badge,
  });
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final bool highlight;
  _StatData(this.title, this.value, this.icon, this.highlight);
}
