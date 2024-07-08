import 'package:dictionary_app/resultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});
TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.0.w,vertical: 25.h),
            child: Column(


              children: [
                Text(
                  'Search for a word',

                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(height: 50.h,),
                Image.asset(
                  'assets/673-6738989_wiktionary-dynamic-dictionary-logo-dictionary-logo-hd-png-removebg-preview.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 25.h,),

                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter a word',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25.h,),

                GestureDetector(
                  onTap: (){
                    Navigator.push
                      (context,
                        MaterialPageRoute(builder: (context)=>ResultScreen(
                          word: _controller.text,
                        )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height:60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
