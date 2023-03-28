import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ResultPage extends StatefulWidget {
  final food;

  const ResultPage({super.key, @required this.food});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> _getIngredients(var data) {
    List<String> datares =
        widget.food['ingredients_text'].toString().split(',');
    return datares;
  }

  String _getNutriDetails(String grade) {
    switch (grade) {
      case 'a':
        return "Very Good Nutritional Quality";
      case 'b':
        return "Good Nutritional Quality";
      case 'c':
        return "Very Good Nutritional Quality";
      case 'd':
        return "Poor Nutritional Quality";

      case 'e':
        return "Very Bad Nutritional Quality";

      default:
        return "No Data for Nutritional Quality";
    }
  }

  String _getNutriScoreGrade(String grade) {
    if (grade != "null")
      return "Nutri-Score " + grade.toUpperCase();
    else
      return "No Data for NutriScore";
  }

  String _getNutriScoreImagePath(String grade) {
    switch (grade) {
      case 'A':
        return 'images/nutriscore-a.png';
      case 'B':
        return 'images/nutriscore-b.png';
      case 'C':
        return 'images/nutriscore-c.png';
      case 'D':
        return 'images/nutriscore-d.png';
      case 'E':
        return 'images/nutriscore-e.png';
      default:
        return "images/boylogo.png";
    }
  }

  String _getfat(var data) {
    return data["fat"].toString();
  }

  String _getsalt(var data) {
    return data["salt"].toString();
  }

  String _getsaturatedfat(var data) {
    return data["saturated-fat"].toString();
  }

  String _getsugar(var data) {
    return data["sugars"].toString();
  }

  String _getsugardetailsdata(var data) {
    if (data["sugars"].toString() == "high")
      return "Sugars in High Quantity";
    else if (data["sugars"].toString() == "low")
      return "Sugars in Low Quantity";
    else if (data["sugars"].toString() == "moderate")
      return "Sugars in Moderate Quantity";
    else
      return "No data for Sugars";
  }

  String _getsaltdetailsdata(var data) {
    if (data["salt"].toString() == "high")
      return "Salt in High Quantity";
    else if (data["salt"].toString() == "low")
      return "Salt in Low Quantity";
    else if (data["salt"].toString() == "moderate")
      return "Salt in Moderate Quantity";
    else
      return "No data for Salt";
  }

  String _getsaturatedfatdetailsdata(var data) {
    if (data["saturated-fat"].toString() == "high")
      return "Saturated Fat in High Quantity";
    else if (data["saturated-fat"].toString() == "low")
      return "Saturated Fat in Low Quantity";
    else if (data["saturated-fat"].toString() == "moderate")
      return "Saturated Fat in Moderate Quantity";
    else
      return "No data for Saturated-Fat";
  }

  String _getfatdetailsdata(var data) {
    if (data["fat"].toString().toString() == "high")
      return "Fat in High Quantity";
    else if (data["fat"].toString().toString() == "low")
      return "Fat in Low Quantity";
    else if (data["fat"].toString().toString() == "moderate")
      return "Fat in Moderate Quantity";
    else
      return "No data for Fat";
  }

  String _getEnergyData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["energy-kcal_100g"].toString();
    if (nutriments["energy-kcal_100g"] != null) {
      var unit = nutriments["energy_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getFatData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["fat_100g"].toString();
    if (nutriments["fat_100g"] != null) {
      var unit = nutriments["fat_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getSaturatedFatData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["saturated-fat_100g"].toString();
    if (nutriments["saturated-fat_100g"] != null) {
      var unit = nutriments["saturated-fat_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getCarbohydratesData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["carbohydrates_100g"].toString();
    if (nutriments["carbohydrates_100g"] != null) {
      var unit = nutriments["carbohydrates_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getSugarsData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["sugars_100g"].toString();
    if (nutriments["sugars_100g"] != null) {
      var unit = nutriments["sugars_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getFiberData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["fiber_100g"].toString();
    if (nutriments["fiber_100g"] != null) {
      var unit = nutriments["fiber_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getProteinsData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["proteins_100g"].toString();
    if (nutriments["proteins_100g"] != null) {
      var unit = nutriments["proteins_unit"].toString();
      return main + " " + unit;
    } else
      return "?";
  }

  String _getSaltData(var data) {
    var nutriments = data["nutriments"];
    var main = nutriments["salt_100g"].toString();
    if (nutriments["salt_100g"] != null) {
      var unit = nutriments["salt_unit"].toString();
      return main + " " + unit;
    } else {
      return "?";
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
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/main");
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Text(
                        "Scan Results",
                        style: GoogleFonts.kiteOne(fontSize: 18),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(19, 6, 19, 0),
                    height: 117,
                    width: 341,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        color: Color.fromARGB(244, 255, 255, 255)),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(71, 0, 0, 2),
                            child: Row(
                              children: [
                                Text(
                                  "Product Name : ",
                                  style: GoogleFonts.kiteOne(fontSize: 13),
                                ),
                                Container(
                                  width: 159,
                                  child: Text(
                                    widget.food["product_name"].toString(),
                                    style: GoogleFonts.kiteOne(fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(71, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Quantity          : ",
                                  style: GoogleFonts.kiteOne(fontSize: 13),
                                ),
                                Text(
                                  widget.food["quantity"].toString(),
                                  style: GoogleFonts.kiteOne(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(71, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Serving Size    : ",
                                  style: GoogleFonts.kiteOne(fontSize: 13),
                                ),
                                Text(
                                  widget.food["serving_size"].toString(),
                                  style: GoogleFonts.kiteOne(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(19, 6, 19, 0),
                    height: 100,
                    width: 341,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        color: Color.fromARGB(244, 255, 255, 255)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(26, 0, 0, 0),
                          child: Image.asset(
                            _getNutriScoreImagePath(widget
                                .food["nutriscore_grade"]
                                .toString()
                                .toUpperCase()),
                            height: 53,
                            width: 90,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(12, 29, 25, 0),
                                child: Row(
                                  children: [
                                    Text(
                                        _getNutriScoreGrade(widget
                                            .food["nutriscore_grade"]
                                            .toString()),
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: widget.food["nutriscore_grade"]
                                                      .toString() ==
                                                  "a"
                                              ? Colors.green
                                              : widget.food["nutriscore_grade"]
                                                          .toString() ==
                                                      "b"
                                                  ? Colors.lightGreen
                                                  : widget.food["nutriscore_grade"]
                                                              .toString() ==
                                                          "c"
                                                      ? Colors.orange
                                                      : widget.food["nutriscore_grade"]
                                                                  .toString() ==
                                                              "d"
                                                          ? Color.fromARGB(
                                                              166, 255, 25, 9)
                                                          : widget.food["nutriscore_grade"]
                                                                      .toString() ==
                                                                  "e"
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0)
                                                              : Colors.black,
                                        )),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 7, 0, 0),
                                child: Row(
                                  children: [
                                    Text(
                                        _getNutriDetails(widget
                                            .food["nutriscore_grade"]
                                            .toString()),
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(19, 6, 19, 0),
                    height: 156,
                    width: 341,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        color: Color.fromARGB(244, 255, 255, 255)),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              _getfat(widget.food["nutrient_levels"]) == "low"
                                  ? "images/greencircle.png"
                                  : _getfat(widget.food["nutrient_levels"]) ==
                                          "high"
                                      ? "images/redcircle.png"
                                      : _getfat(widget
                                                  .food["nutrient_levels"]) ==
                                              "moderate"
                                          ? "images/yellowcircle.png"
                                          : "images/google.png",
                              height: 23,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                                _getfatdetailsdata(
                                    widget.food["nutrient_levels"]),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              _getsalt(widget.food["nutrient_levels"]) == "low"
                                  ? "images/greencircle.png"
                                  : _getsalt(widget.food["nutrient_levels"]) ==
                                          "high"
                                      ? "images/redcircle.png"
                                      : _getsalt(widget
                                                  .food["nutrient_levels"]) ==
                                              "moderate"
                                          ? "images/yellowcircle.png"
                                          : "images/google.png",
                              height: 23,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                                _getsaltdetailsdata(
                                    widget.food["nutrient_levels"]),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              _getsaturatedfat(
                                          widget.food["nutrient_levels"]) ==
                                      "low"
                                  ? "images/greencircle.png"
                                  : _getsaturatedfat(
                                              widget.food["nutrient_levels"]) ==
                                          "high"
                                      ? "images/redcircle.png"
                                      : _getsaturatedfat(widget
                                                  .food["nutrient_levels"]) ==
                                              "moderate"
                                          ? "images/yellowcircle.png"
                                          : "images/google.png",
                              height: 23,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                                _getsaturatedfatdetailsdata(
                                    widget.food["nutrient_levels"]),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              _getsugar(widget.food["nutrient_levels"]) == "low"
                                  ? "images/greencircle.png"
                                  : _getsugar(widget.food["nutrient_levels"]) ==
                                          "high"
                                      ? "images/redcircle.png"
                                      : _getsugar(widget
                                                  .food["nutrient_levels"]) ==
                                              "moderate"
                                          ? "images/yellowcircle.png"
                                          : "images/google.png",
                              height: 23,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              _getsugardetailsdata(
                                  widget.food["nutrient_levels"]),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(19, 6, 19, 0),
                    height: 244,
                    width: 340,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        color: Color.fromARGB(244, 255, 255, 255)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(28, 4, 0, 0),
                          child: Row(
                            children: [
                              Text("Nutrition facts",
                                  style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                  )),
                              const SizedBox(
                                width: 65,
                              ),
                              Text("As sold for 100 g / 100 ml",
                                  style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                  )),
                            ],
                          ),
                        ),
                        facttable(
                          name: "Energy",
                          quantity: _getEnergyData(widget.food),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Fat", quantity: _getFatData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Saturated Fat",
                            quantity: _getSaturatedFatData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Carbohydrates",
                            quantity: _getCarbohydratesData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Sugars",
                            quantity: _getSugarsData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Fiber",
                            quantity: _getFiberData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Proteins",
                            quantity: _getProteinsData(widget.food)),
                        const SizedBox(
                          height: 4,
                        ),
                        facttable(
                            name: "Salt", quantity: _getSaltData(widget.food)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(19, 6, 19, 0),
                    height: 244,
                    width: 340,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        color: Color.fromARGB(244, 255, 255, 255)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Ingredients",
                                  style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),
                              Text(_getIngredients(widget.food)[1].trim()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class facttable extends StatelessWidget {
  final name;
  final quantity;
  const facttable({
    @required this.name,
    @required this.quantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(38, 7, 0, 0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 97,
                child: Text(name,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                    )),
              ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(65, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.fromLTRB(65, 0, 0, 0),
                  child: Text(quantity,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
