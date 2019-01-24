import 'package:flutter/material.dart';

class SIForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: SIFormStateFul(),
    );
  }
}

class SIFormStateFul extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIFormStateFul> {
  final _minimumPadding = 5.0;

  var _formKey = GlobalKey<FormState>();
  List<String> _currencies = ["Rupees", "Dollars", "Pounds"];

  var _currentItemSelected = "";


  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String display = "";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "images/money.png",
              width: 175.0,
              height: 175.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: _textFormField(textStyle, principalController,
                  "Please enter principal amount", "Principal",
                  "Enter Principal e.g 1000"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: _textFormField(textStyle, rateController,
                  "Please enter rate of interest", "Rate of Interest",
                  "Enter rate of interest"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _textFormField(textStyle, termController,
                        "Enter term", "Term", "Term in years"),
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Expanded(
                    child: _spinner(_currentItemSelected),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      "Calculate",
                      style: textStyle,
                    ),
                    onPressed: () {
                      setState(() {
                        if(_formKey.currentState.validate()) {
                          display = _calculateTotalResult();
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Reset",
                      style: textStyle,
                    ),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                display,
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  String _calculateTotalResult(){

    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double result = principal + (principal * rate * term) / 100;

    return "After $term years, your investment will be worth $result $_currentItemSelected";

  }

  void _reset() {
    principalController.text = "";
    rateController.text = "";
    termController.text = "";
    display = '';
    _currentItemSelected = _currencies[0];

  }


  TextFormField _textFormField (TextStyle textStyle,
      TextEditingController textEditController,String errorMsgString,
      String labelText, String hintText){

     return TextFormField(
       style: textStyle,
       keyboardType: TextInputType.number,
       controller: textEditController,
       validator: (String value){
         if(value.isEmpty){
           return errorMsgString;
         }
       },
       decoration: InputDecoration(
           errorStyle: TextStyle(
               color: Colors.yellowAccent,
               fontSize: 15.0
           ),
           labelText: labelText,
           labelStyle: textStyle,
           hintText: hintText,
           border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(8.0))),

     );
  }


  _spinner(String item) {
    return DropdownButton<String>(
      items: _currencies.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: item,
      onChanged: (String newValue) {
        setState(() {
          item = newValue;
        });
      },
    );
  }

}
