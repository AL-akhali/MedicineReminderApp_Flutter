import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Layout_Screen/layout_cubit/layout_cubit.dart';
import 'package:project1/Layout_Screen/layout_cubit/layout_state.dart';
import 'package:project1/Shared/components/componenet.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var editProfileModel=LayoutCubit.get(context).model;

        nameController.text=editProfileModel!.name!;
        phoneController.text=editProfileModel.phone!;

        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: defaultAppBar(context: context,
                  title: 'Edit Profile',
                  actions:[
                    defaultTextButton(
                        onTap: (){
                          LayoutCubit.get(context).updateUser(
                              name: nameController.text,
                              phone: phoneController.text,
                          );}, text: 'Update'),
                    SizedBox(
                      width: 15,
                    )
                  ]
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is GetUserUpdataDataLoadingState)
                      LinearProgressIndicator(),
                    if(state is GetUserUpdataDataLoadingState)
                    defaultFormText(
                        control: nameController,
                        type: TextInputType.name,
                        validator: ( value)
                        {
                          if(value.isEmpty)
                            return 'Name Can\nt be Empty' ;
                          return null;
                        },
                        label: 'Edit Name',
                      prefix: Icons.account_circle,
                        ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    defaultFormText(
                        control: phoneController,
                        type: TextInputType.phone,
                        validator: ( value)
                        {
                          if(value.isEmpty)
                            return 'Phone Number Can\nt be Empty' ;
                          return null;

                        },
                        label: 'Edit Phone',
                        prefix: Icons.add_ic_call,
                        ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}
