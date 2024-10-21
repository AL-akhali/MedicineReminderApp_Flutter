import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_cubit.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_states.dart';
import 'package:project1/Auth_Screen/loginScreen.dart';

class RegScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state)
      {
        if(state is CreateUserSuccessState)
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => loginScreen()));
        }
        else if (state is FailedToRegisterState)
        {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text(state.message,style: const TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context,state)
      {
        return Form(
          key: formKey,
          child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffB81736),
                        Color(0xff281537),
                      ]),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 60.0, left: 22),
                      child: Text(
                        'Create Your\nAccount',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                        color: Colors.white,
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _textFiledItem(controller: nameController, hintText: "User Name"),
                            SizedBox(
                              height: 20.0,
                            ),
                            _textFiledItem(controller: emailController, hintText: "Gmail"),
                            SizedBox(
                              height: 20.0,
                            ),
                            _textFiledItem(isSrecure: true, controller: passwordController, hintText: "Password"),
                            SizedBox(
                              height: 20.0,
                            ),
                            _textFiledItem(controller: phoneController, hintText: "Phone"),
                            SizedBox(
                              height: 20.0,
                            ),

                            const SizedBox(height: 10,),
                            const SizedBox(height: 70,),
                            MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  BlocProvider.of<AuthCubit>(context).register(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              child: Text(state is RegisterLoadingState ?"انتــــظر....." :"تسجيل" , style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                              padding: EdgeInsets.symmetric(vertical: 12.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              color:Color(0xffB81736),
                              textColor: Colors.white,
                              minWidth: double.infinity,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: ()
                                    {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                    },
                                    child: Text('تسجيل الدخول',style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ),
                                Text('لــدي بالفعل حساب'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
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
      border: OutlineInputBorder(),
      hintText: hintText,
    ),
  );
}
