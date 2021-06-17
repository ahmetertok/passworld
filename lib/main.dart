import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';


void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'passworld',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'passworld'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _copy = "PASSWORD";
  bool letters = true;
  bool uppercaseLetters = true;
  bool numbers = true;
  bool specialChars = true;

  double _currentSliderValue = 10;

  


String generatePassword(bool _isWithLetters, bool _isWithUppercase,
    bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {

  //Define the allowed chars to use in the password
  String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
  String _upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String _numbers = "0123456789";
  String _special = "@#=+!£\$%&?[](){}";

  //Create the empty string that will contain the allowed chars
  String _allowedChars = "";

  //Put chars on the allowed ones based on the input values
  _allowedChars += (_isWithLetters ? _lowerCaseLetters : '');
  _allowedChars += (_isWithUppercase ? _upperCaseLetters : '');
  _allowedChars += (_isWithNumbers ? _numbers : '');
  _allowedChars += (_isWithSpecial ? _special : '');

  int i = 0;
  String _result = "";

  //Create password
  while (i < _numberCharPassword.round()) {
    //Get random int
    int randomInt = Random.secure().nextInt(_allowedChars.length);
    //Get random char and append it to the password
    _result += _allowedChars[randomInt];
    i++;
  }

  return _result;
}


  @override
  Widget build(BuildContext context) {
     final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
     
      body: Container( 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
      colors: [Color.fromARGB(255, 1, 171, 148),
      Color.fromARGB(255, 251, 253, 138),],
      
    ),
  ),
   child: Center(
     child: Padding(
       padding: EdgeInsets.all(20.0),
             child: Column(
            
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              

              GestureDetector(
              child: new Text(_copy+"\n^Tap For Copy^",
              style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
              fontFamily: "Sen",
               
            ),
            textAlign: TextAlign.center,
              ),
              onTap: () {
                Clipboard.setData(new ClipboardData(text: _copy));
                Fluttertoast.showToast(
                    msg: "Copied!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),

              CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Letters'),
              value: letters,
              onChanged: (value) {
                setState(() {
                  letters = !letters;
                  
                });
              },
            ),

              CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Uppercase Letters'),
              value: uppercaseLetters,
              onChanged: (value) {
                setState(() {
                  uppercaseLetters = !uppercaseLetters;
                  
                });
              },
            ),
     
              CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Numbers'),
              value: numbers,
              onChanged: (value) {
                setState(() {
                  numbers = !numbers;
                  
                });
              },
            ),
             
              CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Special Chars'),
              value: specialChars,
              onChanged: (value) {
                setState(() {
                  specialChars = !specialChars;
                  
                });
              },
            ),

              Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),

              Container(
        child: SizedBox(
        child: TextButton(
        style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () { 
          if(letters==false && uppercaseLetters==false && numbers==false && specialChars==false){
            //print("Please Select One Of Them");
            setState(() {
                  
                  _copy = "Please Select One Of Them";
                });
             

          }
          else{
            String _generatedPassword = generatePassword(letters, uppercaseLetters, numbers, specialChars, _currentSliderValue);
            //print(_generatedPassword);
            setState(() {
                  
                  _copy = _generatedPassword;
                });
            
          }
          
        },
        child: Text(
            "Generate",
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w400,
              fontFamily: "Sen",
               height: 1.1
            ),
            
          ),
),

          
         width: 351,
          height: 65,
        ),
       
        width: 500,
        height: 65,
        decoration: BoxDecoration(
          color: Color(
            0xff086972,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(
                0x3f000000,
              ),
              offset: Offset(
                0,
                4,
              ),
              blurRadius: 4,
            ),
          ],
        ),
         
      ),      
  
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}