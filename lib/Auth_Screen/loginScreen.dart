import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Auth_Screen/WelcomeScreen.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_cubit.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_states.dart';
import 'package:project1/Auth_Screen/forgetPasswordPage.dart';
import 'package:project1/Auth_Screen/regScreen.dart';
import 'package:project1/Layout_Screen/layoutScreen.dart';
import 'package:project1/Shared/network/local_network.dart';

class loginScreen extends StatefulWidget {

  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state){
        if(state is LoginSuccessState)
        {
          CacheNetwork.InsertToCache(
              key: 'uId',
              value:state.uId,
          ).then((value){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Layoutscreen()));
          });
        }
        else if (state is FailedToRegisterState)
        {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text(state.message,style: const TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context,state){
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.0, left: 22),
                      child: Text(
                        'Hello\nSign in!',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                        color: Colors.white,
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child:  Padding(
                        padding:  EdgeInsets.only(left: 18.0,right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _textFiledItem(
                              controller: emailController,
                              hintText: 'Gmail',

                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _textFiledItem(
                              controller: passwordController,
                              hintText: 'Password',
                              isSrecure: true,
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: TextButton(
                                  onPressed: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Forgetpasswordpage()));
                                  },
                                  child: const Text('Forget The Password',style: TextStyle(
                                      color:Color(0xff281537),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),)
                              ),
                            ),
                            const SizedBox(height: 70,),
                            MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              child: Text(state is LoginLoadingState ? "Loading...." :"Sign in" , style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),),
                              padding: EdgeInsets.symmetric(vertical: 12.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              color:Color(0xffB81736),
                              textColor: Colors.white,
                              minWidth: double.infinity,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: ()
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegScreen()));
                                    },
                                    child: Text('Create Account',style: TextStyle(
                                        color:Color(0xff281537),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ),
                                Text('I dont have aaccount ..',style: TextStyle(color:Color(0xffB81736),),),
                              ],
                            ),
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
      fillColor:Colors.white,
      hintText: hintText,
    ),
  );
}
