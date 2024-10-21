import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Layout_Screen/layout_cubit/layout_state.dart';
import 'package:project1/Shared/components/constans.dart';
import 'package:project1/models/user_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData(){
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      model =UserModel.fromJson(value.data()!);
      print(model!.name);
      emit(GetUserDataSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(FailedToGetUserDataState(message: error.toString()));
    });
  }

  void updateUser({
    String? name,
    String? phone,
})
  {
    UserModel model = UserModel(
      name: name,
      phone: phone,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value){
      getUserData();
    }).catchError((error){
      emit(FailedToGetUserUpdataDataState(message: error.toString()));
    });
  }
}