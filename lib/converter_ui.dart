import 'package:flutter/material.dart';
import 'package:infix_postfix_prefix/infixtopostfix.dart';
import 'package:infix_postfix_prefix/ui_styles/styles.dart';
import 'package:infix_postfix_prefix/widgets/bracket_button.dart';
import 'package:infix_postfix_prefix/widgets/circular_button.dart';
import 'package:infix_postfix_prefix/widgets/delete_button.dart';
import 'package:infix_postfix_prefix/widgets/transparent_button.dart';

class ConverterUI extends StatefulWidget {
  @override
  _ConverterUIState createState() => _ConverterUIState();
}

class _ConverterUIState extends State<ConverterUI> {
  final sizebox = SizedBox(width: 10);
  final node = FocusNode();

  final _controller = new TextEditingController();
  bool _keyboardFlag = false;

  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print(Infix.toPostfixExpression(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w3 = mq.width / 3;
    final w1_8 = mq.width / 1.8;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 12, bottom: 10, right: 16),
        child: ListView(
          reverse: true,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: w1_8,
                  child: FittedBox(
                      child: Row(
                    children: <Widget>[
                      sizebox,
                      buttonRow(["0", "."]),
                      DeleteButton(
                        controller: _controller,
                      )
                      // TransparentButton(
                      //   letter: "del",
                      //   controller: _controller,
                      // )
                    ],
                  )),
                ),
                sizebox,
                keyBoardButton()
              ],
            ),
            Row(
              children: [
                Container(
                  width: w1_8,
                  child: FittedBox(
                    child: buttonRow(["1", "2", "3"]),
                  ),
                ),
                sizebox,
                Container(
                  width: w3,
                  child: FittedBox(
                    child: Row(
                      children: <Widget>[
                        new CircularButton(
                          letter: "+",
                          controller: _controller,
                        ),
                        new CircularButton(
                          letter: "-",
                          controller: _controller,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: w1_8,
                  child: FittedBox(
                    child: buttonRow(["4", "5", "6"]),
                  ),
                ),
                sizebox,
                Container(
                  width: w3,
                  child: FittedBox(
                    child: Row(
                      children: <Widget>[
                        new CircularButton(
                          letter: "*",
                          controller: _controller,
                        ),
                        new CircularButton(
                          letter: "/",
                          controller: _controller,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: w1_8,
                  child: FittedBox(
                    child: buttonRow(["7", "8", "9"]),
                  ),
                ),
                sizebox,
                Container(
                  width: w3,
                  child: FittedBox(
                    child: Row(
                      children: <Widget>[
                        new CircularButton(
                          letter: "^",
                          controller: _controller,
                        ),
                        new CircularButton(
                          letter: "%",
                          controller: _controller,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: BracketButton(
                      letter: "(",
                      controller: _controller,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: BracketButton(
                      letter: ")",
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    Infix.toPostfixExpression(
                            _controller.text.split('').reversed.join())
                        .split('')
                        .reversed
                        .join(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 22,
                        height: 0.9,
                        color: Colors.white,
                        fontFamily: "titillium"),
                  ),
                  SizedBox(height: 5),
                  Text(
                    Infix.toPostfixExpression(_controller.text),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    // textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 22,
                        height: 0.9,
                        color: Colors.white,
                        fontFamily: "titillium"),
                  ),
                  SizedBox(height: 5),
                  Text(
                    toValue(),
                    style: TextStyle(
                        fontSize: 22,
                        height: 0.9,
                        color: Colors.green,
                        fontFamily: "titillium"),
                    maxLines: 1,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 0, right: 17),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 4,
                  width: mq.width / 4,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                enabled: _keyboardFlag,
                controller: _controller,
                focusNode: node,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero, border: InputBorder.none),
                style: TextStyle(
                  fontSize: fontsize(),
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                "EXPRESSION",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "titillium",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }

  String toValue() {
    try {
      if (_controller.text.length == 0) return "";
      String value = Infix.toValue(_controller.text).toString();
      if (value.substring(value.length - 2, value.length) == ".0")
        return value.substring(0, value.length - 2);
      else {
        return value;
      }
    } catch (e) {
      return "INVALID EXPRESSION";
    }
  }

  FlatButton keyBoardButton() {
    return FlatButton(
      splashColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
      color: Colors.deepOrangeAccent[100],
      onPressed: () {
        print(_keyboardFlag);
        setState(() {
          _keyboardFlag = !_keyboardFlag;
          if (node.hasFocus) {
            node.unfocus();
          } else {
            FocusScope.of(context).requestFocus(node);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Text(
          "System\nKeyboard",
          textAlign: TextAlign.center,
          style: TextStyle(
              // color: Color.fromRGBO(96, 100, 94, 1.0),
              color: Colors.black87,
              fontSize: 15,
              letterSpacing: 4,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Row buttonRow(List<String> list) {
    return Row(
        children: list
            .map((letter) => TransparentButton(
                  letter: letter,
                  controller: _controller,
                ))
            .toList());
  }

  double fontsize() {
    int size = _controller.text.length;
    if (size < 10)
      return 60;
    else if (size < 12)
      return 55;
    else if (size < 14)
      return 50;
    else if (size < 16)
      return 45;
    else if (size < 18)
      return 40;
    else
      return 35;
  }
}
