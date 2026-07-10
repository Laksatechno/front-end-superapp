import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yofa/bloc/auth/login_bloc.dart';
import 'package:yofa/bloc/logout/logout_bloc.dart';
import 'package:yofa/bloc/presensi/presensi_bloc.dart';
import 'package:yofa/datasources/auth/auth_remote_datasource.dart';
import 'package:yofa/datasources/presensi/presensi_datasource.dart';
import 'package:yofa/page/callplan/bloc/callplan_bloc.dart';
import 'package:yofa/page/callplan/callplan_page.dart';
import 'package:yofa/page/callplan/datasource/callplan_datasource.dart';
import 'package:yofa/page/presensi/presensi_page.dart';
import 'package:yofa/page/register/bloc/register_bloc.dart';
import 'package:yofa/page/splash_page.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/bloc/riwayat_bloc.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/datasource/riwayat_ds.dart';
import 'package:yofa/pageadmin/sales/area/bloc/area_bloc.dart';
import 'package:yofa/pageadmin/sales/products/barang_page.dart';
import 'package:yofa/pageadmin/sales/customer/bloc/customer_bloc.dart';
import 'package:yofa/pageadmin/sales/customer/datasource/customer_ds.dart';
import 'package:yofa/pageadmin/sales/getproducts/bloc/customer_products_bloc.dart';
import 'package:yofa/pageadmin/sales/getproducts/datasource/customer_products_ds.dart';
import 'package:yofa/pageadmin/sales/marketing/bloc/marketing_bloc.dart';
import 'package:yofa/pageadmin/sales/marketing/datasource/marketing_ds.dart';
import 'package:yofa/pageadmin/sales/order/bloc/save_sale_bloc.dart';
import 'package:yofa/pageadmin/sales/order/datasource/save_sale_ds.dart';
import 'package:yofa/pageadmin/sales/order/order_page.dart';
import 'package:yofa/pageadmin/sales/products/bloc/product_bloc.dart';

import 'package:yofa/pageadmin/sales/qtybatchproduct/bloc/product_batch_bloc.dart';
import 'package:yofa/pageadmin/sales/qtybatchproduct/datasource/product_batch_ds.dart';
import 'package:yofa/pageadmin/sales/tagihansales/bloc/sales_bloc.dart';
import 'package:yofa/pageadmin/sales/tagihansales/datasource/sales_ds.dart';
import 'package:yofa/pageadmin/sales/tagihansales/tagihan_sales.dart';
import 'package:yofa/pagecustomer/history/bloc/history_order_bloc.dart';
import 'package:yofa/pagecustomer/history/datasource/history_order_ds.dart';
import 'package:yofa/pagecustomer/product/bloc/productuser_bloc.dart';
import 'package:yofa/pagecustomer/product/datasource/productuser_ds.dart';

import 'pageadmin/sales/products/datasource/product_ds.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // warna theme ungu
  static const primary = Color(0xFF8B3C7A);
  static const bg = Color(0xFFF7F3F6);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
        BlocProvider(
          create: (_) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => PresensiBloc(PresensiDatasource()),
          child: PresensiPage(active: true),
        ),
        BlocProvider(create: (context) => CustomerBloc(CustomerDataSource())),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CustomerBloc(CustomerDataSource())
                ..add(const CustomerEvent.getCustomers(page: 1, perPage: 200)),
            ),
            BlocProvider(
              create: (_) => CustomerProductsBloc(CustomerProductsDataSource()),
            ),
            BlocProvider(
              create: (_) => ProductUserBloc(ProductUserDatasource()),
            ),
            BlocProvider(
              create: (_) => ProductBatchBloc(ProductBatchDataSourc()),
            ),
            BlocProvider(
                create: (_) => SaveSaleBloc(SaveSaleDataSource()),
                child: const OrderPage(),
              ),
          ],
          child: const OrderPage(),
        ),
        BlocProvider(
          create: (_) => SalesBloc(SalesDataSource())..add(const SalesEvent.getSales(page: 1)),
          child: const TagihanSales(),
        ),
        BlocProvider(
            create: (_) => MarketingBloc(MarketingDataSource())..add(const MarketingEvent.get()),
            child: const OrderPage(),
          ),
        BlocProvider(
          create: (_) => ProductBloc(ProductRemoteDatasource()),
          child: const BarangPage(),
        ),
        BlocProvider(create: (_) => AreaBloc()),
        BlocProvider(
          create: (_) => CallplanBloc(CallplanRemoteDatasource()),
          child: CallplanPage(),
        ),
        BlocProvider(
          create: (_) => RiwayatBloc(RiwayatDataSource())
            ..add(const RiwayatEvent.getRiwayats()),
        ),
        BlocProvider(create: (_) => HistoryOrderBloc(HistoryOrderDataSource())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YOFA CORPORA',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          scaffoldBackgroundColor: bg,
        ),
        navigatorObservers: [routeObserver],
        home: const SplashPage(),
      ),
    );
  }
}
