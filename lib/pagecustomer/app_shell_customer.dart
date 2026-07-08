import 'package:flutter/material.dart';
import 'package:yofa/page/profile/profile_page.dart';
import 'package:yofa/pagecustomer/app_bottom_nav_customer.dart';
import 'package:yofa/pagecustomer/chat/chat_page.dart';
import 'package:yofa/pagecustomer/history/history_order_page.dart';
import 'package:yofa/pagecustomer/home_customer.dart';
import '../widgets/app_bottom_nav.dart';



class AppShellCustomer extends StatefulWidget {
  const AppShellCustomer({super.key});

  @override
  State<AppShellCustomer> createState() => _AppShellCustomerState();
}

class _AppShellCustomerState extends State<AppShellCustomer> {
  int _index = 0;

  final _home = const HomeCustomerPage();
  final _pesanan = const HistoryCustomerOrderPage();
  final _chat = const ChatPage();
  final _profil = const ProfilPage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          _home,
          _pesanan,
          _chat,
          _profil,
        ],
      ),
      bottomNavigationBar: AppBottomNavCustomer(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
