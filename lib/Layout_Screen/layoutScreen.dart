import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:project1/Auth_Screen/loginScreen.dart';
import 'package:project1/Layout_Screen/medicine_details_screen.dart';
import 'package:project1/Layout_Screen/new_entery_screen.dart';
import 'package:project1/Profile_Screen/drawer.dart';
import 'package:project1/Profile_Screen/profile_screen.dart';
import 'package:project1/Shared/network/local_network.dart';
import 'package:get/get.dart';
import 'package:project1/global_bloc.dart';
import 'package:project1/main.dart';
import 'package:project1/models/medicine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Layoutscreen extends StatelessWidget {
  const Layoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToProfilePage() {
      Navigator.pop(context);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditProfileScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Color(0xffB81736),
                        title: Text('SignOut'),
                        content: Text('Are You Sure To Exit'),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              CacheNetwork.DeleteCacheItem(key: 'uId')
                                  .then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => loginScreen()));
                              });
                            },
                            child: Text('Yes'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.settings_power_outlined))
        ],
      ),
      drawer: MyDrawer(
        onProFileTap: goToProfilePage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TopContianer(),
            Flexible(child: BottomContainer()),
          ],
        ),
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewEnteryScreen()));
        },
        child: SizedBox(
            height: 100,
            width: 100,
            child: Card(
              color: Color(0xffB81736),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(3.h),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            )),
      ),
    );
  }
}

class TopContianer extends StatelessWidget {
  const TopContianer({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              'Care About Your Health',
              style: Theme.of(context).textTheme.headlineMedium,
            )),
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text('Here is the medicine',
                style: Theme.of(context).textTheme.titleSmall)),
        SizedBox(
          height: 2.h,
        ),
        StreamBuilder<List<Medicine>>(
          stream: globalBloc.medicineList$,
          builder: (context, snapshot) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ));
          },
        )
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return StreamBuilder(
        stream: globalBloc.medicineList$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'no Medicine',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          } else {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MedicineCard(medicine: snapshot.data![index]);
                });
          }
        });
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.medicine,
  });
  final Medicine medicine;

  Hero makeIcon() {
    if (medicine.medicineType == 'cream') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/cream.png'),height:150));
    } else if (medicine.medicineType == 'capsule') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/capsule.png'),height:150));
    } else if (medicine.medicineType == 'drops') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/drops.png'),height:150));
    } else if (medicine.medicineType == 'pills') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/pills.png'),height:150));
    } else if (medicine.medicineType == 'syringe') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/syringe.png'),height:150));
    } else if (medicine.medicineType == 'syrup') {
      return Hero(
          tag: medicine.medicineName = medicine.medicineType!,
          child: Image(image: AssetImage('assets/images/syrup.png'),height:150));
    }
    return Hero(
        tag: medicine.medicineName = medicine.medicineType!,
        child: Icon(Icons.error));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => MedicineDetailsScreen()));
        Navigator.of(context).push<void>(PageRouteBuilder
          (pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (context,Widget? child) {
                  return Opacity(opacity: animation.value,child: MedicineDetailsScreen(medicine: medicine),
                  );
                }
            );
        },
          transitionDuration: Duration(milliseconds: 500),
        ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          children: [
            Spacer(),
            makeIcon(),
            Spacer(),
            Hero(
              tag: medicine.medicineName!,
              child: Text(
                medicine.medicineName!,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Color(0xffB81736), fontSize: 30),
              ),
            ),
            Text(
              medicine.interval == 1
                  ? "Every ${medicine.interval} hours"
                  : "Every ${medicine.interval} hours",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
