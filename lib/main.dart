import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const LoginFormApp());
}

class LoginFormApp extends StatelessWidget {
  const LoginFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Form App',
      home: HomePage(),

    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'FPTSite3';

  void _handleLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void _handleDropdownChange(String? newValue) {
    setState(() {
      _selectedRole = newValue ?? 'FPTSite3';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight, // Đặt dropdown menu ở góc phải
              child: DropdownButton<String>(
                value: _selectedRole,
                onChanged: _handleDropdownChange,
                items: <String>['FPTSite3', 'FPTSite4','site5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("abc"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.qr_code),
              tooltip: 'QR Icon',
              onPressed: () {},
            ), //IconButton
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Icon',
              onPressed: () {
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: SearchPage()
                );
              },
            ), //IconButton
          ], //<Widget>[]
          backgroundColor: Colors.greenAccent[400],
          elevation: 50.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ), //AppBar
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                 child: UserAccountsDrawerHeader(
                   decoration: BoxDecoration(
                     color: Colors.white38,),
                   accountName: Text('Nguyễn Thị Hải Yến',style: TextStyle(color: Colors.black,fontSize: 20), ),
                    accountEmail: Text('Admin-Ban giám đốc',style: TextStyle(color: Colors.black,fontSize: 20)),),),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Thông báo')),
              const ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Danh mục người dùng')),
              const ListTile(
                  leading: Icon(Icons.format_list_bulleted_outlined),
                  title: Text('Danh mục ICD thường dùng')),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Đăng xuất'),
                  onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },),
              const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Thông tin ứng dụng')),
            ],
          ),
        ),

        body:  tab,
        )
      );
  }
}
class SearchPage extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = const Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
Widget tab=const DefaultTabController(
    length: 5,
  child: Scaffold(
    appBar: TabBar(
      indicatorColor: Colors.amber,
      labelColor: Colors.greenAccent,
        tabs: [
          Tab(icon: Icon(Icons.people_alt,color:Colors.greenAccent), ),
          Tab(icon: Icon(Icons.people_alt_outlined,color:Colors.green)),
          Tab(icon: Icon(Icons.notifications,color: Colors.redAccent,)),
          Tab(icon: Icon(Icons.warning,color: Colors.amber,)),
          Tab(icon: Icon(Icons.numbers,color: Colors.lightBlueAccent,)),
        ],
    ),
    body: TabBarView(
      children: [
        Icon(Icons.people_alt,
            color: Colors.greenAccent,
            size: 100,),
        Icon(Icons.people_alt_outlined,
            color: Colors.blue,
            size: 100),
        Icon(Icons.notifications,
            size: 100),
        Icon(Icons.warning,
          size: 300,),
        Icon(Icons.numbers),
      ],
    ),
  ),);




