import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/Pages/splashScreen.dart/LoginPage.dart';
import 'package:hackathon/Provider/UserProvider.dart';
import 'package:hackathon/Routes/routes.dart';
import 'package:hackathon/Utils/Indicator.dart';
import 'package:hackathon/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    void navigatonChange() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Layout(),
        ),
      );
    }

    Future.delayed(const Duration(seconds: 3), navigatonChange);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        children: [
          Image.asset('assets/logo2.png'),
        ],
      ),
    );
  }
}

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 600) {
        return AuthState();
      }
      return Scaffold(
        body: Center(
          child: Text("This is a Web app"),
        ),
      );
    });
  }
}

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<UserProvider>(context, listen: false).initialize();
              Navigator.pushReplacementNamed(context, Routes.homePage);
            });
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Indicator(),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, Routes.loginPage);
          });
          return Container();
        });
  }
}
