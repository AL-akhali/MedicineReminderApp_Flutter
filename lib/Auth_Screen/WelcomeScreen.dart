import 'package:flutter/material.dart';
import 'package:project1/Auth_Screen/loginScreen.dart';
import 'package:project1/Auth_Screen/regScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/src/widgets/media_query.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       height: double.infinity,
       width: double.infinity,
       decoration: const BoxDecoration(
         gradient: LinearGradient(
           colors: [
             Color(0xffB81736),
             Color(0xff281537),
           ]
         )
       ),
       child: Column(
         children: [
           Container(
             height: 50.h,
             width: 50.w,
             child: Padding(
               padding: EdgeInsets.only(top: 200.0),
               child: Image(image: AssetImage('assets/images/time.png',),height:50.h,width: 50.w,),
             ),
           ),
            Center(
              child: Container(
                height: 15.h,
                width: 50.w,
                child: Text('C A R E \n ABOUT YOUR \n H E A L T H',style: TextStyle(
                 fontSize: 20.sp,
                 color: Colors.white
                           ),),
              ),
            ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => loginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(child: Text('Sign in',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),),
            ),
          ),
           const SizedBox(height: 30,),
           GestureDetector(
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) =>  RegScreen()));
             },
             child: Container(
               height: 53,
               width: 320,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(30),
                 border: Border.all(color: Colors.white),
               ),
               child: const Center(child: Text('Create Account',style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.black
               ),),),
             ),
           ),
           const Spacer(),
           const Text('Sign in by ..:',style: TextStyle(
               fontSize: 17,
               color: Colors.white
           ),),//
          const SizedBox(height: 12,),
          ]
       ),
     ),

    );
  }
}
