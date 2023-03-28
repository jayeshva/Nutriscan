import "package:flutter/material.dart";
import 'package:fscan/mainpage.dart';
import 'package:fscan/result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MaterialApp(
    home: const FirstPage(),
    routes: <String, WidgetBuilder>{
      '/main': (BuildContext contex) =>MainPage(),
      '/result': (BuildContext context) => const ResultPage(),
    },
  ));
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
        if (_currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(gdata: account),
            ),
          );
          print(account!.email);
          print(account.displayName);
          print(account.photoUrl);
        }
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.pushNamed(context, "/main");
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 211, 0, 0),
                child: Image.asset(
                  "images/boylogo.png",
                  height: 107,
                  width: 110,
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 45, 0, 14.47),
              child: Text(
                "Sign in with",
                style: GoogleFonts.iceberg(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                )),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                onPressed: signIn,
                child: Image.asset(
                  "images/google.png",
                  height: 53.09,
                  width: 55.62,
                ),
              ),
              MaterialButton(
                onPressed: signIn,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child:
                    Image.asset("images/mail.png", height: 53.09, width: 55.62),
              )
            ]),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 185, 0, 10),
              child: Text(
                "powered by",
                style: GoogleFonts.iceberg(
                    textStyle: const TextStyle(fontSize: 18)),
              ),
            ),
            Image.asset("images/bitlogo.png", height: 60, width: 72)
          ]),
        ));
  }
}

// void SignOut() {
//   _googleSignIn.disconnect();
// }

