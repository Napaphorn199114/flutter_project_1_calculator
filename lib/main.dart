import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String result ="0";
  String expression ="";

  buttonRressed(String value){
    

    setState(() {
      if(value =="CLEAR"){
        result = "0";
      }else if(value =="."){
        if(result.contains(".")){
          return ;  // ถ้ากด . จะให้ return ไม่ต้องทำอะไรต่อ
        }else{
          result = result + value;
        }
      }else if(value =="="){
        expression = result.replaceAll("x", "*");  //ตัวเลขที่พิมพ์ลงไป result จะถูกเก็บไว้ที่ expression

        // เรียกใช้ Parse เพื่อสร้าง object
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);
        result = "$calculate";

      }else{
        if(result =="0"){
          result = value;
        }else{
          result = result+value;  //นำค่า result มาต่อกับ value ที่กดเพิ่มไปในปัจจุบัน
        }


      }
    
      print(value);
    });
  
  }


  Widget myButton(String buttonLabel) {
    return Expanded(
      // Expanded ให้กินพื้นที่มากที่สุด และมีขนาดเท่าๆกัน
      child: OutlinedButton(
          //ใช้ widget ต้อง return widget
          onPressed: () =>buttonRressed(buttonLabel),
          child: Text(
            buttonLabel, //รับค่าเป็น String ตัวเลข
            style: TextStyle(fontSize: 20),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.black,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //ทำให้แถบ banner หายไป
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: SafeArea( //ไม่ให้เนื้อที่ ไปถึงปุ่ม home
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                alignment: Alignment.centerRight,  // Text Result ชิดขวา
                child: Text(
                  result,  // String result
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Divider()),    //สร้างเส้นคั่น
              Column(
                children: [
                  Row(
                    children: [
                      myButton("7"),
                      myButton("8"),
                      myButton("9"),
                      myButton("/"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("4"),
                      myButton("5"),
                      myButton("6"),
                      myButton("x"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("1"),
                      myButton("2"),
                      myButton("3"),
                      myButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("."),
                      myButton("0"),
                      myButton("00"),
                      myButton("+"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("CLEAR"),
                      myButton("="),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
