import 'fragments/fragment_1.dart';
import 'fragments/fragment_2.dart';
import 'fragments/fragment_3.dart';
import 'fragments/fragment_4.dart';
import 'fragments/fragment_5.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../../resource/themes/theme.dart';
import '../../resource/sources/string.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

final _kPages = <String, IconData>{
  StringValue.bottomNavBarItem1.elementAt(StringValue.currentLanguage): Icons.block_outlined,
  StringValue.bottomNavBarItem2.elementAt(StringValue.currentLanguage): Icons.block_outlined,
  StringValue.bottomNavBarItem3.elementAt(StringValue.currentLanguage): Icons.description_outlined,
  StringValue.bottomNavBarItem4.elementAt(StringValue.currentLanguage): Icons.backup_table_outlined,
  StringValue.bottomNavBarItem5.elementAt(StringValue.currentLanguage): Icons.block_outlined,
};

onCreate(BuildContext context) async {}

class MenuApp extends StatefulWidget {
  const MenuApp({Key? key}) : super(key: key);
  @override
  MenuPage createState() => MenuPage();
}

class MenuPage extends State<MenuApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onCreate(context));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.lightTheme,
      debugShowCheckedModeBanner: false,
      title: StringValue.nameApp.elementAt(StringValue.currentLanguage),
      home: DefaultTabController(
        length: 5,
        initialIndex: 2,
        child: Scaffold(
          appBar: MyAppBar(
            title: StringValue.nameApp.elementAt(StringValue.currentLanguage),
            leading: Icons.menu_outlined,
            context: context,
          ),
          body: Column(
            children: [
              //Page ici
              //_buildStyleSelector(),
              Expanded(
                child: TabBarView(
                  children: [unFrag(context), deuxFrag(context), TroisFrag(), QuatreFrag(), cinqFrag(context)],
                ),
              ),
            ],
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{/*3: '9'*/},
            color: Colors.white,
            activeColor: Colors.white,
            backgroundColor: const Color(0XFF505050),
            style: TabStyle.reactCircle,
            items: <TabItem>[
              for (final entry in _kPages.entries) TabItem(icon: entry.value, title: entry.key),
            ],
            onTap: (int i) => print('click index=$i'),
          ),
        ),
      ),
    );
  }

  ConvexAppBar bottomBar = ConvexAppBar.badge(const <int, dynamic>{/*3: '9'*/},
      color: Colors.white,
      activeColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 79, 79, 79),
      style: TabStyle.reactCircle,
      items: <TabItem>[
        for (final entry in _kPages.entries) TabItem(icon: entry.value, title: entry.key),
      ],
      onTap: (int i) => print('click index=$i'));
}

/*
class MenuApp extends StatelessWidget {
  /// Page principale
  const MenuApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeApp.lightTheme, debugShowCheckedModeBanner: false, title: StringValue.nameApp, home: const ConvexAppExample());
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //loadApp(context);
    return Scaffold(body: Container(padding: const EdgeInsets.all(50), height: (MediaQuery.of(context).size.height), width: (MediaQuery.of(context).size.width)));
  }
}

class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({Key? key}) : super(key: key);

  @override
  ConvexAppExampleState createState() => ConvexAppExampleState();
}

class ConvexAppExampleState extends State<ConvexAppExample> {
  TabStyle tabStyle = TabStyle.reactCircle;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
          appBar: MyAppBar(
            title: "SoluRisk",
            leading: IconButton(
              icon: Icon(Icons.shopping_cart_rounded, size: 20, color: Theme.of(context).themeExtension().statusFalse),
              onPressed: null,
            ),
          ),
          body: Column(
            children: [
              //Page ici
              //_buildStyleSelector(),
              Expanded(
                child: TabBarView(
                  children: [unFrag(context), deuxFrag(context), troisFrag(context), quatreFrag(context), cinqFrag(context)],
                ),
              ),
            ],
          ),
          bottomNavigationBar: bottomBar),
    );
  }

  ConvexAppBar bottomBar = ConvexAppBar.badge(const <int, dynamic>{/*3: '9'*/},
      color: Colors.white,
      activeColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 79, 79, 79),
      style: TabStyle.reactCircle,
      items: <TabItem>[
        for (final entry in _kPages.entries) TabItem(icon: entry.value, title: entry.key),
      ],
      onTap: (int i) => print('click index=$i'));

  // Select style enum from dropdown menu:

}
*/
// Style AppBar

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.context, required this.leading, this.title = ""}) : super(key: key);
  final String title;
  final IconData leading;
  final BuildContext context;
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(leading, size: 20, color: Theme.of(context).themeExtension().topAppBar?.foregroundEnable),
        onPressed: null,
      ),
      title: Text(title, style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: const Color.fromARGB(255, 255, 255, 255))),
      actions: [
        const IconButton(
          icon: Icon(Icons.notifications_active_rounded, size: 20, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: null,
        ),
        PopupMenuButton(
          icon: const Icon(Icons.account_circle_rounded, size: 20, color: Color.fromARGB(255, 255, 255, 255)),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("Mon profil"),
                onTap: null,
              ),
              const PopupMenuItem(
                child: Text("Changer de compte"),
                onTap: null,
              ),
              const PopupMenuItem(
                child: Text("Deconnexion"),
                onTap: null,
              )
            ];
          },
        )
      ],
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 47, 47, 47),
    );
  }
}
