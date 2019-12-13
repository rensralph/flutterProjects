// start dependencies

import 'package:flutter/material.dart';

//end dependencies


class CalculatorScreen extends StatefulWidget {
  @override
  State createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String _eq = "", _ans = "0";
  bool _decimalOk = true;
  
  Text equation(String text, double scale) {
    return Text(
      text,
      textAlign: TextAlign.right,
      textScaleFactor: scale,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }

  FlatButton addFlatButton(bool isOperator, String val) {
    var _onPressed = () {};
    
    if(isOperator) {
      if(val.contains("C") || val.contains(".") || val.contains("=")) {
        switch (val) {
          case "C":
            _onPressed = () {
              setState(() {
                _eq = "";
                _ans = "0";
                _decimalOk = true;
              });
            };
            break;
          
          case "CE":
            _onPressed = () {
              setState(() {
                _eq = "";
                _ans = "0";
                _decimalOk = true;
              });
            };
            break;

          case ".":
            _onPressed = (() {
              if(!_decimalOk) {
                setState(() {
                  _eq = _eq;
                });
              } else {
                setState(() { 
                  _eq += _eq.substring(_eq.length - 1).contains(RegExp(r'[\D]')) && !_eq.contains(".") ? "0." : ".";
                  _decimalOk = false;
                });
              }
            });
            break;

          case "=":
            _onPressed = () {
              setState(() {
                _ans = calculate().toString();
                _ans = _ans.length > 14 ? _ans.substring(0, 15) : _ans;
                _ans = _ans.endsWith(".0") ? _ans.substring(0, _ans.length-2) : _ans;
                _ans = _eq.isEmpty ? "0" : _ans;
                _eq = "";
              });
            };
            break;

          default:
            break;
        }
      } else {
        if(val.contains(RegExp(r'[\d]'))) {
          throw(Exception("Entered character is a number but isOperator is set to true"));
        } else {
          _onPressed = () {
            setState(() {
              _eq = _eq.substring(_eq.length - 1).contains(RegExp(r'[\D]')) && !_eq.endsWith('.') ? _eq.substring(0, _eq.length-1) + val : _eq + val;
              _decimalOk = true;
            });
          };
        }
      }
    } else {
      if(val.contains(RegExp(r'[\D]'))) {
        throw(Exception("Entered character is not a number but isOperator is set to false"));
      } else {
        _onPressed = () {
          setState(() {
            _eq = val.contains("0") || val.contains("00") && val.length <= 1 ? "0" : _eq + val;
            _ans = calculate().toString();
            _ans = _eq.isEmpty ? "0" : _ans;
            _ans = _ans.endsWith(".0") ? _ans.substring(0, _ans.length-2) : _ans;
            _ans = _ans.length > 14 ? _ans.substring(0, 15) : _ans;
          });
        };
      }
    }

    return FlatButton(
      padding: EdgeInsets.all(15.0),
      child: Text(val),
      onPressed: _onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: equation(_ans, 3.5)
                      )
                    ],
                  ),
                  SizedBox(height: 170.0),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: equation(_eq, 2.0)
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                ],
              ),
            ),
            Container(
              color: Color.alphaBlend(Color.fromARGB(30, 0, 150, 50), Color.fromARGB(50, 0, 50, 150)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      addFlatButton(true, "C"),
                      addFlatButton(true, "CE"),
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(Icons.backspace),
                        onPressed: () {
                          setState(() {
                            if(_eq.substring(_eq.length - 1).contains(RegExp(r'[\D]')) && !_eq.endsWith(".")){
                                _decimalOk = false;
                              } else if(_eq.endsWith('.')){
                                _decimalOk = true;
                              }
                            _eq = _eq.length == 1 ? "" :_eq.substring(0, _eq.length - 1);
                            _ans = _eq.length <= 0 ? "0" : calculate().toString();
                            _ans = _ans.endsWith(".0") ? _ans.substring(0, _ans.length-2) : _ans;
                            _ans = _ans.length > 14 ? _ans.substring(0, 15) : _ans;
                          });
                        },
                      ),
                      addFlatButton(true, "*")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      addFlatButton(false, "7"),
                      addFlatButton(false, "8"),
                      addFlatButton(false, "9"),
                      addFlatButton(true, "/")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      addFlatButton(false, "4"),
                      addFlatButton(false, "5"),
                      addFlatButton(false, "6"),
                      addFlatButton(true, "-")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      addFlatButton(false, "1"),
                      addFlatButton(false, "2"),
                      addFlatButton(false, "3"),
                      addFlatButton(true, "+")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      addFlatButton(false, "0"),
                      addFlatButton(false, "00"),
                      addFlatButton(true, "."),
                      addFlatButton(true, "=")
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  double calculate() {
    String _op = "*/+-", _temp = _eq, _b = "";
    List<String> _numStack = [], _opStack = [], _evalStack = [];
    int _l = 0;
    _temp += 'c';

    for(int i=0; i < _temp.length; i++) {
      if(_temp[i].contains(RegExp(r'[\D]')) && !_temp[i].startsWith('.')) {
        _numStack.add(_b);
        if(!_temp[i].contains('.')) {
          _opStack.add(_temp[i]);
        }
        _b = "";
      } else {
        _b += _temp[i];
      }
    }

    for(int x=0; x < 2; x++) {
      for(int y=0; y < _opStack.length; y++) {
        if(_opStack[y] == _op[x*2] || _opStack[y] == _op[(x*2) + 1]) {
          print(_opStack[y]);
          _evalStack.add(_opStack[y]);
        }
      }
    }

    for(int a=0; a < _evalStack.length; a++) {
      int _curOp = (_opStack.indexOf(_evalStack[a]) - _l) < 0 ? 0 : _opStack.indexOf(_evalStack[a]) - _l;

      double n1 = double.parse(_numStack[_curOp]);
      double n2 = double.parse(_numStack[_curOp+1]);
      double _num;

      print(_evalStack[a] + "eval");
      switch(_evalStack[a]) {
        case '%':
          _num = n1*(0.01*n2);
          break;

        case '*':
          _num = n1*n2;
          break;

        case '/':
          _num = n1/n2;
          break;

        case '+':
          _num = n1+n2;
          break;

        case '-':
          _num = n1-n2;
          break;
      }

      _numStack[_curOp] = _num.toString();
      _numStack.removeAt(_curOp+1);
      _opStack[_opStack.indexOf(_evalStack[a])] = 'c';
      _l++;
    }
    return double.parse(_numStack[0]);
  }
}

