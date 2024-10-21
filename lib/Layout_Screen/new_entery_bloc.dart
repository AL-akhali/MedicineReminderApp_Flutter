import 'package:project1/models/error.dart';
import 'package:project1/models/medicine.dart';
import 'package:project1/models/medicine_model.dart';
import 'package:rxdart/rxdart.dart';


class NewEnteryBloc{
  BehaviorSubject<MedicineType>? _selectMedicineType$;
  ValueStream<MedicineType>? get selectedMedicineType =>
      _selectMedicineType$!.stream;

  BehaviorSubject<int>? _selectedIntervals$;
  BehaviorSubject<int>? get selectIntervals =>  _selectedIntervals$;

  BehaviorSubject<String>? _selectedTimeOfDay$;
  BehaviorSubject<String>? get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError>? _errorStates$;
  BehaviorSubject<EntryError>? get errorState$ => _errorStates$;

  NewEnteryBloc()
  {
    _selectMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.none);
    _selectedTimeOfDay$ =
    BehaviorSubject<String>.seeded('none');
    _selectedIntervals$ =
    BehaviorSubject<int>.seeded(0);
    _errorStates$ =
    BehaviorSubject<EntryError>();
  }

  void dispose(){
    _selectMedicineType$!.close();
    _selectedIntervals$!.close();
    _selectedTimeOfDay$!.close();
  }

  void submitError(EntryError error)
  {
    _errorStates$!.add(error);
  }

  void updateInterval(int interval){
    _selectedIntervals$!.add(interval);
  }

  void updateTime(String time)
  {
    _selectedTimeOfDay$!.add(time);
  }

  void updateSelectedMedicine(MedicineType type)
  {
    MedicineType _tempType = _selectMedicineType$!.value;
    if(type == _tempType){
      _selectMedicineType$!.add(MedicineType.none);
    }else{
      _selectMedicineType$!.add(type);
    }
  }

}