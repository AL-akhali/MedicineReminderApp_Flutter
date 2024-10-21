import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpasswordpage extends StatefulWidget {

  const Forgetpasswordpage({super.key});

  @override
  State<Forgetpasswordpage> createState() => _ForgetpasswordpageState();
}

class _ForgetpasswordpageState extends State<Forgetpasswordpage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Password Link Reset Send It To Email'),
            );
          });
    }on FirebaseAuthException catch(e)
    {
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff281537),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Enter Your Email We Will Send Link To Your Email'),
            _textFiledItem(
              controller: emailController,
              hintText: 'Gmail',
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: ()
              {
                passwordReset();
              },
              child: Text('Reset Your Password'),
              padding: EdgeInsets.symmetric(vertical: 12.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              ),
              color:Color(0xffB81736),
              textColor: Colors.white,
              minWidth: double.infinity,
            ),

          ],
        ),
      ),
    );
  }
}
Widget _textFiledItem({
  bool? isSrecure,
  required TextEditingController controller,
  required String hintText

}) {
  return TextFormField(
    controller: controller,
    validator: (input)
    {
      if(controller.text.isEmpty)
      {
        return "$hintText name must not null";
      }
      else
      {
        return null ;
      }
    },
    obscureText: isSrecure ?? false,
    decoration: InputDecoration(
      fillColor:Colors.white,
      hintText: hintText,
    ),
  );
}