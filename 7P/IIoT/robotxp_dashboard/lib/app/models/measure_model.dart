import 'package:robotxp_dashboard/app/models/joint_model.dart';

class MeasureModel {
  final int id;
  final bool isMoving;
  final DateTime createdAt;
  final DateTime? endAt;
  final List<JointModel> joints;
  final double totalPower;

  MeasureModel({
    required this.id,
    required this.isMoving,
    required this.createdAt,
    this.endAt,
    required this.joints,
    required this.totalPower,
  });

  MeasureModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isMoving = json['isMoving'],
        createdAt = DateTime.parse(json['createdAt']),
        endAt = DateTime.tryParse(json['endAt'] ?? ""),
        joints = (json['joints'] as List)
            .map((j) => JointModel.fromJson(j))
            .toList(),
        totalPower = json['totalPower'];

  Duration get duration => endAt?.difference(createdAt) ?? Duration.zero;
  double get hours => duration.inMilliseconds / 3600000;
}
