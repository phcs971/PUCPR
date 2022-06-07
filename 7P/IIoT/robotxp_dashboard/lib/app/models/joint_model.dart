class JointModel {
  final int id, number;
  final double current, voltage, power;

  JointModel(
      {required this.id,
      required this.number,
      required this.current,
      required this.voltage,
      required this.power});

  JointModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'],
        current = json['current'],
        voltage = json['voltage'],
        power = json['power'];
}
