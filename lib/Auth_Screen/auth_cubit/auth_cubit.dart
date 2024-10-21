import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Auth_Screen/auth_cubit/auth_states.dart';
import 'package:project1/Shared/components/constans.dart';
import 'package:project1/models/user_model.dart';


class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  async{
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    )
    .then((value){
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    })
    .catchError((error){
      emit(FailedToRegisterState(message: error.toString()));
    });
  }

  //login

  void login({
    required String email,
    required String password,
  })
  async{
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    )
        .then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((error){
      emit(FailedToLoginState(message: error.toString()));
    });
  }

  //UserCreate
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  async{
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,

    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value){
      emit(CreateUserSuccessState());
    })
        .catchError((error){
      emit(FailedToCreateUserState(message: error.toString()));
    });
  }


  
  //get user details
  // Future<UserModel> getUserDetails(String email)async {
  //   final snapshot =  await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email).get();
  //   final userData = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).single;
  //   return userData;
  // }
  //
  // Future<List<UserModel>> AllUser()async {
  //   final snapshot =  await FirebaseFirestore.instance.collection('users').get();
  //   final userData = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }
}
