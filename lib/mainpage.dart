import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:fscan/result.dart';


class MainPage extends StatefulWidget {
  final gdata;

  MainPage({super.key, @required this.gdata});

  @override
  State<MainPage> createState() => _MainPageState(gdata: gdata);
}

class _MainPageState extends State<MainPage> {
 final gdata;
  _MainPageState({@required this.gdata});
  var top = 16.0;
  bool _isButtonVisible = false;
  bool _isLoading = false;
  bool iscanVisible = true;
  String _scanResult = '';
  String _foodName = '';
  List<String> _ingredients = [];
  Map<String, dynamic> _nutriments = {};
  
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    String apiUrl =
        'https://world.openfoodfacts.org/api/v0/product/$_scanResult.json';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
        });

        if (data != null && data['status'] == 1 && data['product'] != null) {
          var product = data['product'];
          var foodName = product['product_name'];
          // var ingredients = product['ingredients_text'].toString().split(',');
          var nutriments = product['nutriments'];

          setState(() {
            _foodName = "Food Name : " + foodName;
            // _ingredients = ingredients;
            _nutriments = nutriments;
            _isButtonVisible = true;
            iscanVisible = false;
          });

          print('Food Name: $_foodName');
          // print('Ingredients: $_ingredients');
          print('Nutritional Info: $_nutriments');
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(food: product),
            ),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
          print('Invalid data structure');
          print(data);
          setState(() {
            _foodName = "Product Not Found";
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(
            'Failed to retrieve food information (status code: ${response.statusCode})');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to retrieve food information');
      print(e);
    }
  }

  Future<void> _scanCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);

    if (barcodeScanRes != "-1") {
      setState(() {
        _scanResult = "Barcode is : " + barcodeScanRes;
        _isButtonVisible = true;
        iscanVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "NutriScan",
            style: GoogleFonts.kiteOne(
                textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            )),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 0, 60),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(237, 255, 0, 60),
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(237, 255, 0, 60)),
                  accountName: Text(
                 gdata!.displayName.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(gdata!.email.toString()),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture:CircleAvatar(radius: 45.0,
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Image.network(gdata!.photoUrl.toString()), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.barcode_reader),
                title: const Text(' Scan now'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.health_and_safety),
                title: const Text(' Set diet plan'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(' Scan history'),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 44, 0, 0),
                        child: Text(
                          "Good Food...Long Life",
                          style: GoogleFonts.dancingScript(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 72, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(239, 255, 255, 255)),
                          onPressed: _scanCode,
                          child: Image.asset(
                            "images/barcode-scan.gif",
                            height: 93,
                            width: 93,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, top, 0, 0),
                        child: Text(_scanResult),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Visibility(
                          visible: iscanVisible,
                          child: Text(
                            "Scan Food",
                            style: GoogleFonts.iceberg(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, top, 0, 0),
                        child: Visibility(
                            visible: _isButtonVisible,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 0, 60),
                                ),
                                onPressed: fetchData,
                                // onPressed: () {
                                //   Navigator.pushNamed(context, "/result");
                                // },
                                child: const Text(
                                  "Check Nutri",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ))),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AddOn(
                              path: "images/dietplanlogo.png",
                              text: "Health info",
                            ),
                            SizedBox(
                              width: 54,
                            ),
                            AddOn(
                              path: "images/reviewlogo.png",
                              text: "Reviews",
                            ),
                            SizedBox(
                              width: 54,
                            ),
                            AddOn(
                              path: "images/chatbotlogo.png",
                              text: "Nutri bot",
                            )
                          ],
                        ),
                      ),
                    ]),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Image.asset(
                        "images/women logo.png",
                        height: 174,
                        width: 269,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class AddOn extends StatelessWidget {
  final path;
  final text;
  final height = 50.0;
  final width = 46.0;
  const AddOn({
    super.key,
    @required this.path,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          path,
          height: height,
          width: width,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: GoogleFonts.iceberg(textStyle: const TextStyle(fontSize: 15)),
        )
      ],
    );
  }
}
