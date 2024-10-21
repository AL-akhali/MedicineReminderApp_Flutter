class Medicine {
  late List<dynamic> notificationIDs;
  late String medicineName;
  late int doseage;
  late String medicineType;
  late int interval;
  late String startTime;

  Medicine(
      {required this.notificationIDs,
      required this.medicineName,
      required this.doseage,
      required this.medicineType,
      required this.interval,
      required this.startTime});
  String get getName => medicineName;
  int get getDoseage => doseage;
  String get getType => medicineType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      'ids': notificationIDs,
      'name': medicineName,
      'doseage': doseage,
      'type': medicineType,
      'interval': interval,
      'start': startTime,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      doseage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}
