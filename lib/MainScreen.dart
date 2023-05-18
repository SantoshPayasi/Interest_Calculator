import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currency = ["Rupees", "Dollers", "Pounds"];
  var selectedItem;
  var _fomKey = GlobalKey<FormState>();
  String ans = " ";

  @override
  void initState() {
    super.initState();
    var selectedItem = _currency[0];
  }

  void _onDropDownItemSelected(item) {
    setState(() {
      selectedItem = item;
    });
  }

  TextEditingController principleControlled = TextEditingController();
  TextEditingController rateControlled = TextEditingController();
  TextEditingController TermControlled = TextEditingController();

  String _calculateTotalReturn() {
    double principle = double.parse(principleControlled.text);
    double rate = double.parse(rateControlled.text);
    double time = double.parse(TermControlled.text);
    double total = principle + (principle * rate * time) / 100;
    if (selectedItem == "Pounds") {
      total *= 0.0097;
    } else if (selectedItem == "Dollers") {
      total *= 0.01215;
    }
    return "After $time years, your investment will be worth $total $selectedItem";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Interest Calculator"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            getImageAsset(),
            Form(
              key:_fomKey,
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                   validator: (Value){
                     if(Value!.isEmpty){
                       return "please Enter principle";
                     }
                   },
                    keyboardType: TextInputType.number,
                    controller: principleControlled,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade200)),
                        labelText: "Principle",
                        labelStyle: TextStyle(color: Colors.green.shade100),
                        hintText: "Enter Principle e.g. 1200",
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter rate";
                      }
                    },
                    controller: rateControlled,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.green.shade200)),
                        labelText: "Rate",
                        labelStyle: TextStyle(color: Colors.green.shade100),
                        hintText: "Enter rate of interest",
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please Enter duration ";
                          }
                        },
                        controller: TermControlled,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade200)),
                            labelText: "Term",
                            labelStyle: TextStyle(color: Colors.green.shade100),
                            hintText: "Duration",
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ))),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade100)),
                        width: MediaQuery.of(context).size.width / 3 + 10,
                        child: DropdownButton<String>(
                          hint: const Text("Curreny Type",
                              style: TextStyle(color: Colors.white)),
                          dropdownColor: Colors.black,
                          value: selectedItem,
                          items: _currency
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e,
                                      style: TextStyle(color: Colors.white))))
                              .toList(),
                          onChanged: (value) {
                            _onDropDownItemSelected(value);
                          },
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: ElevatedButton(
                        onPressed: () {

                          setState(() {
                            if(_fomKey.currentState!.validate()){
                              this.ans = _calculateTotalReturn();
                            }

                          });
                        },
                        child: Text("Calculate"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade100)),
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              principleControlled.clear();
                              TermControlled.clear();
                              rateControlled.clear();
                              selectedItem = "Rupees";
                              ans = " ";
                            });
                          },
                          child: Text("Reset"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                        ))
                  ],
                ),
              ],
            )),
            Text(this.ans, style: Theme.of(context).textTheme.titleLarge),
          ],
        ));
  }

  Widget getImageAsset() {
    AssetImage assetIamge = AssetImage("assets/images/money.png");
    return Image(image: assetIamge, height: 140, width: 140);
  }
}
