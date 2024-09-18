import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:woocommerce_client/woocommerce_client.dart';

final client = OdooClient('https://test-mobile.odoo.com/');

late Woocommerce woocommerce;
void main() async {
  woocommerce = Woocommerce(
    baseURL: 'http://192.168.18.39:8080',
    consumerKey: 'ck_e94e58827d60aad3f610856bc5dfb46b7c90e1e6',
    consumerSecret: 'cs_16940a53cbb6e99d0fcb4d554a402693fec653aa',
  );

  await client.authenticate('test-mobile', 'aboidrees@cpuprogramming.com', 'P@ssw0rdAD2020MAAY');

  runApp(
    const App(),
    // MultiProvider(
    //   providers: const [
    //     ChangeNotifierProvider(create: (context) => HomeProvider(), child: const DashboardPage()),
    //     ChangeNotifierProvider(create: (context) => ProductProvider(), child: const ProductsMenuPage()),
    //     ChangeNotifierProvider(create: (context) => CartProvider(), child: const ProductDetailsPage()),
    //     ChangeNotifierProvider(create: (context) => CartProvider(), child: const CartPage()),
    //     ChangeNotifierProvider(create: (context) => LoaderProvider(), child: const BasePage()),
    //   ],
    //   child: const App(),
    // ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الأصيل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.cairo().fontFamily,
        primaryColor: Colors.white,
        primarySwatch: Colors.amber,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        textTheme: const TextTheme(
          // Short Text, high-emphasis
          headlineLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),

          // Short Text, medium-emphasis
          titleLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400),
          titleMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
          titleSmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.w400),

          // Short important text, numerical
          displayLarge: TextStyle(fontSize: 14.0, color: Colors.amber, fontWeight: FontWeight.w400),
          displayMedium: TextStyle(fontSize: 12.0, color: Colors.amber, fontWeight: FontWeight.w400),
          displaySmall: TextStyle(fontSize: 10.0, color: Colors.amber, fontWeight: FontWeight.w400),

          // long text
          bodyLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      home: const HomePage(),
      // home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<dynamic> fetchContacts() {
    return client.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['id', 'name', 'email', 'image_128'],
        // 'fields': ['id'],
        'limit': 80,
      },
    });
  }

  Future<Map<String, dynamic>> getModelFields(String modelName) async {
    try {
      final result = await client.callKw({
        'model': modelName,
        'method': 'fields_get',
        'args': [],
        'kwargs': {
          'attributes': ['string', 'help', 'type']
        }, // Optional: Specify fields you want
      });
      return result as Map<String, dynamic>;
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching model fields: $e');
      rethrow;
    }
  }

  Future<void> printAllModelFields() async {
    try {
      final fields = await getModelFields('res.partner');
      fields.forEach((fieldName, fieldData) {
        print('Field: $fieldName');
        print('  String: ${fieldData['string']}');
        print('  Help: ${fieldData['help']}');
        print('  Type: ${fieldData['type']}');
        print('--------------------');
      });
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Widget buildListItem(Map<String, dynamic> record) {
    var unique = record['id'].toString();
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    final avatarUrl = '${client.baseURL}/web/image/res.partner/${record["id"]}/avatar_128';
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(record['name']),
      subtitle: Text(record['email'] is String ? record['email'] : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    // printAllModelFields();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchContacts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record = snapshot.data[index] as Map<String, dynamic>;
                      return buildListItem(record);
                    });
              } else {
                if (snapshot.hasError) return const Text('Unable to fetch data');
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
