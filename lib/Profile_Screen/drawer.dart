import 'package:flutter/material.dart';
import 'package:project1/Auth_Screen/loginScreen.dart';
import 'package:project1/Profile_Screen/list_tile.dart';
import 'package:project1/Shared/network/local_network.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProFileTap;
  const MyDrawer({super.key, required this.onProFileTap,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Icon(Icons.person,color: Colors.white,size: 64,)
              ),
              //home List Tile
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),),

              //Profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProFileTap,),
            ],
          ),

          //logout list tile
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: ()
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color(0xffB81736),
                      title: Text('SignOut'),
                      content: Text('Are You Sure To Exit'),
                      actions: [
                        MaterialButton(onPressed: ()
                        {
                          CacheNetwork.DeleteCacheItem(key: 'uId')
                              .then((value){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => loginScreen()));
                          });
                        },
                          child: Text('Yes'),
                        ),
                        MaterialButton(onPressed: ()
                        {
                          Navigator.pop(context);
                        },
                          child: Text('No'),
                        ),

                      ],

                    );
                  });
            },),
        ],
      ),
    );
  }
}
