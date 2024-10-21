import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project1/models/medicine.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicineList$;
  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;

  GlobalBloc()
  {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
  }

  Future makeMedicineList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicine');
    List<Medicine> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      _medicineList$!.add(prefList);
    }
  }

  Future updateMedicineList(Medicine newMedicine) async{
    var blocList = _medicineList$!.value;
    blocList.add(newMedicine);
    _medicineList$!.add(blocList);

    Map<String,dynamic> tempMap = newMedicine.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if(sharedUser.getStringList('medicines')== null){
      medicineJsonList.add(newMedicineJson);
    }else{
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);}

  Future removeMedicine(Medicine tobeRemoved) async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    var blockList = _medicineList$!.value;
    blockList.removeWhere((medicine) => medicine.medicineName == tobeRemoved.medicineName);

    for(int i = 0; i<(24/tobeRemoved.interval!).floor();i++)
      {
        flutterLocalNotificationsPlugin.cancel(int.parse(tobeRemoved.notificationIDs![i]));
      }

    if(blockList.isNotEmpty)
      {
      for(var blockMedicine in blockList)
        {
          String medicineJson = jsonEncode(blockMedicine.toJson());
          medicineJsonList.add(medicineJson);
        }
      }
    sharedPreferences.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }
  void dispose()
  {
    _medicineList$!.close();
  }

}