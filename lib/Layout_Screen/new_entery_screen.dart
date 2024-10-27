import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project1/Layout_Screen/Common/convert_time.dart';
import 'package:project1/Layout_Screen/layoutScreen.dart';
import 'package:project1/Layout_Screen/new_entery_bloc.dart';
import 'package:project1/Layout_Screen/success_screen.dart';
import 'package:project1/global_bloc.dart';
import 'package:project1/models/error.dart';
import 'package:project1/models/medicine.dart';
import 'package:project1/models/medicine_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewEnteryScreen extends StatefulWidget {
  NewEnteryScreen({super.key});

  @override
  State<NewEnteryScreen> createState() => _NewEnteryScreenState();
}

class _NewEnteryScreenState extends State<NewEnteryScreen> {
  var nameController = TextEditingController();
  var doseController = TextEditingController();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NewEnteryBloc _newEnteryBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    doseController.dispose();
    _newEnteryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    doseController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _newEnteryBloc = NewEnteryBloc();
    scaffoldKey = GlobalKey<ScaffoldState>();
    initialNotif();
    initialErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Center(child: Text('Add New')),
        ),
        body: Provider<NewEnteryBloc>.value(
          value: _newEnteryBloc,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PanalTitle(title: 'Medicine Name', isRequired: true),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  maxLength: 12,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                PanalTitle(title: 'Dose', isRequired: true),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: doseController,
                  maxLength: 12,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                PanalTitle(title: 'Medicine Type', isRequired: false),
                StreamBuilder<MedicineType>(
                    stream: _newEnteryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MedicineTypeColumn(
                                medicineType: MedicineType.drops,
                                name: 'Drops',
                                iconValue: 'assets/images/drops.png',
                                isSelected: snapshot.data == MedicineType.drops
                                    ? true
                                    : false),
                            MedicineTypeColumn(
                                medicineType: MedicineType.cream,
                                name: 'Cream',
                                iconValue: 'assets/images/cream.png',
                                isSelected: snapshot.data == MedicineType.cream
                                    ? true
                                    : false),
                            MedicineTypeColumn(
                                medicineType: MedicineType.capsule,
                                name: 'Capsule',
                                iconValue: 'assets/images/capsule.png',
                                isSelected: snapshot.data == MedicineType.capsule
                                    ? true
                                    : false),
                            MedicineTypeColumn(
                                medicineType: MedicineType.pills,
                                name: 'Pills',
                                iconValue: 'assets/images/pills.png',
                                isSelected: snapshot.data == MedicineType.pills
                                    ? true
                                    : false),
                            MedicineTypeColumn(
                                medicineType: MedicineType.syringe,
                                name: 'Syringe',
                                iconValue: 'assets/images/syringe.png',
                                isSelected: snapshot.data == MedicineType.syringe
                                    ? true
                                    : false),
                            MedicineTypeColumn(
                                medicineType: MedicineType.syrup,
                                name: 'Syrup',
                                iconValue: 'assets/images/syrup.png',
                                isSelected: snapshot.data == MedicineType.syrup
                                    ? true
                                    : false),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 12,
                ),
                PanalTitle(title: 'Internal Selection', isRequired: true),
                IntervalSelection(),
                PanalTitle(title: 'Starting Time', isRequired: true),
                SelectTime(),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 15),
                  child: SizedBox(
                    width: 70.w,
                    height: 5.h,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff281537),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          String? medicineName;
                          int? doseage;
                          //name
                          if (nameController.text == "") {
                            _newEnteryBloc.submitError(EntryError.nameNull);
                            return;
                          }
                          if (nameController.text != "") {
                            medicineName = nameController.text;
                          }
                          //doseage
                          if (nameController.text == "") {
                            doseage = 0;
                          }
                          if (nameController.text != "") {
                            doseage = int.parse(doseController.text);
                          }
                          for (var medicine in globalBloc.medicineList$!.value) {
                            if (medicineName == medicine.medicineName) {
                              _newEnteryBloc
                                  .submitError(EntryError.nameDuplicate);
                              return;
                            }
                          }
                          if (_newEnteryBloc.selectIntervals!.value == 0) {
                            _newEnteryBloc.submitError(EntryError.intrval);
                            return;
                          }
                          if (_newEnteryBloc.selectedTimeOfDay$!.value ==
                              'none') {
                            _newEnteryBloc.submitError(EntryError.startTime);
                            return;
                          }
                          String medicineType = _newEnteryBloc
                              .selectedMedicineType!.value
                              .toString()
                              .substring(13);
            
                          int intrtval = _newEnteryBloc.selectIntervals!.value;
                          String startTime =
                              _newEnteryBloc.selectedTimeOfDay$!.value;
            
                          List<int> intIDs =
                              makeIDs(24 / _newEnteryBloc.selectIntervals!.value);
                          List<String> notifIDs =
                              intIDs.map((i) => i.toString()).toList();
            
                          Medicine newEntryMedicine = Medicine(
                            notificationIDs: notifIDs,
                            medicineName: medicineName!,
                            doseage: doseage!,
                            medicineType: medicineType,
                            interval: intrtval,
                            startTime: startTime,
                          );
            
                          //update
                          globalBloc.updateMedicineList(newEntryMedicine);
                          //Notifications
                          schaduleNotif(newEntryMedicine);
            
                          //Success Page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessScreen()));
                        },
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void initialErrorListen() {
    _newEnteryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError('Please Enter Medicine Name');
          break;
        case EntryError.nameDuplicate:
          displayError('This Medicine Name already exists');
          break;
        case EntryError.dosege:
          displayError('Please Enter dosage');
          break;
        case EntryError.type:
          displayError('Please Enter Medicine Name');
          break;
        case EntryError.intrval:
          displayError('Please Enter remender nterval');
          break;
        case EntryError.startTime:
          displayError('Please Enter remender starting name');
          break;
        case EntryError.name:
          displayError('Please Enter Medicine Name');
          break;
        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xff281537),
      content: Text(error),
      duration: Duration(milliseconds: 2000),
    ));
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000));
    }
    return ids;
  }

  initialNotif() async {
    var initialSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initialSettingsIOS = DarwinInitializationSettings();
    var initialSettings = InitializationSettings(
        android: initialSettingsAndroid, iOS: initialSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initialSettings);
  }

  Future onSelectNotif(String? payload) async {
    if (payload != null) {
      debugPrint('Notif payload $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Layoutscreen()));
  }

  Future<void> schaduleNotif(Medicine medicine) async {
    var hour = int.parse(medicine.startTime![0] + medicine.startTime![1]);
    var ogValue = hour;
    var minute = int.parse(medicine.startTime![2] + medicine.startTime![3]);

    var androidPlatform = AndroidNotificationDetails(
        'repeatDailyAtTime channelId', 'repeatDailyAtTime channelName',
        importance: Importance.max,
        ledColor: Color(0xffB81736),
        ledOffMs: 1000,
        ledOnMs: 1000,
        enableLights: true);
    var iOSPlatform = DarwinNotificationDetails();

    var platformChannel = NotificationDetails(
      android: androidPlatform,
      iOS: iOSPlatform,
    );
    for(int i=0; i<(24/medicine.interval!).floor();i++)
      {
        if(hour + (medicine.interval)>23) {
          hour = hour + (medicine.interval!*i)-24;
        }else{
          hour = hour + (medicine.interval!*i);
        }
        await flutterLocalNotificationsPlugin.show(
          int.parse(medicine.notificationIDs![i]),
          'Reminder: ${medicine.medicineName}',
          medicine.medicineType.toString() != MedicineType.none.toString() ?
              'ITS Time To Take Your ${medicine.medicineType!.toLowerCase()},':
              Time(hour,minute,0),
          platformChannel,
        );
        hour = ogValue;
      }
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final NewEnteryBloc newEnteryBloc =
        Provider.of<NewEnteryBloc>(context, listen: false);
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        newEnteryBloc.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.hour.toString()));
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xffB81736),
            ),
            onPressed: () {
              _selectTime();
            },
            child: Center(
              child: Text(
                _clicked == false
                    ? 'Select Time'
                    : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())} ",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              ),
            )),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _interval = {6, 8, 12, 24};
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final NewEnteryBloc newEnteryBloc = Provider.of<NewEnteryBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remind me every',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            DropdownButton(
              iconEnabledColor: Color(0xff281537),
              dropdownColor: Colors.grey,
              itemHeight: 8.h,
              hint: _selected == 0
                  ? Text(
                      'Selected as interval',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Color(0xffB81736)),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _interval.map(
                (int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(),
                        style: Theme.of(context).textTheme.labelLarge),
                  );
                },
              ).toList(),
              onChanged: (newVal) {
                setState(
                  () {
                    _selected = newVal!;
                    newEnteryBloc.updateInterval(newVal);
                  },
                );
              },
            ),
            Text(
              _selected == 1 ? "Hour" : "Hours",
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {super.key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected});
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final NewEnteryBloc newEnteryBloc = Provider.of<NewEnteryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEnteryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 20.w,
              width: 10.h,
              child: Image(image: AssetImage(iconValue))),
          Container(
              height: 5.w,
              width: 8.h,
              decoration: BoxDecoration(
                  color: isSelected ? Color(0xffB81736) : Color(0xff281537),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(name,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,fontSize: 12
                          ))))
        ],
      ),
    );
  }
}

class PanalTitle extends StatelessWidget {
  const PanalTitle({super.key, required this.title, required this.isRequired});

  final String title;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(
                text: title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              TextSpan(
                text: isRequired ? "*" : "",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.red,
                    ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
