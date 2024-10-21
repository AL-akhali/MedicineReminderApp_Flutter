import 'package:flutter/material.dart';
import 'package:project1/global_bloc.dart';
import 'package:project1/models/medicine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicineDetailsScreen extends StatefulWidget {
  const MedicineDetailsScreen({super.key, required this.medicine});
  final Medicine medicine;
  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Details'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MainSection(medicine: widget.medicine,),
            ExpendedSection(medicine: widget.medicine,),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 15),
              child: SizedBox(
                width: 80.w,
                height: 7.h,
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffB81736),
                    ),
                    onPressed: () {
                      openAlartBox(context,_globalBloc);
                    },
                    child: Center(
                      child: Text(
                        'Delete',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openAlartBox(BuildContext context , GlobalBloc _globalBloc) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xff281537),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )),
            title: Text(
              'Delete This Reminder ?',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Color(0xffB81736)))),
              TextButton(
                  onPressed: ()
                  {
                    _globalBloc.removeMedicine(widget.medicine);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('OK',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white))),
            ],
          );
        });
  }
}

class ExpendedSection extends StatelessWidget {
  const ExpendedSection({super.key, this.medicine});
  final Medicine? medicine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListView(
        shrinkWrap: true,
        children: [
          ExpendedInfo(
            FieldTitle: 'Medicine Type',
            FieldInfo: medicine!.medicineType! == 'none'?'Not Sp':medicine!.medicineType!,
          ),
          ExpendedInfo(
            FieldTitle: 'Dose Intrval',
            FieldInfo: 'Every${medicine!.interval}hours : ${medicine!.interval ==24 ?"One Time A day"
                :"${(24/medicine!.interval!).floor()}times a day"}',
          ),
          ExpendedInfo(
            FieldTitle: 'Start Time ',
            FieldInfo: '${medicine!.startTime![0]}${medicine!.startTime![1]}:${medicine!.startTime![2]}${medicine!.startTime![3]}',
          ),
        ],
      ),
    );
  }
}

class ExpendedInfo extends StatelessWidget {
  const ExpendedInfo(
      {super.key, required this.FieldTitle, required this.FieldInfo});
  final String FieldTitle;
  final String FieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              FieldTitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Text(
            FieldInfo,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Color(0xffB81736),
                ),
          ),
        ],
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({
    super.key, this.medicine,
  });
  final Medicine? medicine;

  Hero makeIcon() {
    if (medicine!.medicineType! == 'cream') {
      return Hero(
          tag: medicine!.medicineName = medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/cream.png'),height:150));
    } else if (medicine!.medicineType! == 'capsule') {
      return Hero(
          tag: medicine!.medicineName = medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/capsule.png'),height:150));
    } else if (medicine!.medicineType! == 'drops') {
      return Hero(
          tag: medicine!.medicineName = medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/drops.png'),height:150));
    } else if (medicine!.medicineType! == 'pills') {
      return Hero(
          tag: medicine!.medicineName = medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/pills.png'),height:150));
    } else if (medicine!.medicineType! == 'syringe') {
      return Hero(
          tag: medicine!.medicineName = medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/syringe.png'),height:150));
    } else if (medicine!.medicineType! == 'syrup') {
      return Hero(
          tag: medicine!.medicineName= medicine!.medicineType!,
          child: Image(image: AssetImage('assets/images/syrup.png'),height:150));
    }
    return Hero(
        tag: medicine!.medicineName = medicine!.medicineType!,
        child: Icon(Icons.error));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeIcon(),
        Column(
          children: [
            Hero(
              tag: medicine!.medicineName,
              child: Material(
                color: Colors.transparent,
                child: MainInfoTap(
                    FieldTitle: 'Medicine Name',
                    FieldInfo: medicine!.medicineName),
              ),
            ),
            MainInfoTap(FieldTitle: 'Dose',
                FieldInfo:medicine!.doseage == 0?'Not Sp':'${medicine!.doseage} mg' ),
          ],
        ),
      ],
    );
  }
}

class MainInfoTap extends StatelessWidget {
  const MainInfoTap(
      {super.key, required this.FieldTitle, required this.FieldInfo});

  final String FieldTitle;
  final String FieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FieldTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              FieldInfo,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Color(0xffB81736), fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
