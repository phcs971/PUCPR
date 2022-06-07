import 'package:dio/dio.dart';
import 'package:robotxp_dashboard/app/models/measure_model.dart';

import '../models/trajectory_model.dart';

class RobotXPRepository {
  final dio = Dio();

  RobotXPRepository();
  final baseUrl = "https://localhost:7298/api";

  Future<TrajectoryList?> getTrajectories({int? skip, int? take}) async {
    try {
      final response = await dio.get('$baseUrl/Trajectories', queryParameters: {
        if (skip != null) 'skip': skip,
        if (take != null) 'take': take,
      });
      return TrajectoryList.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> putTrajectory(int trajectoryId, String name) async {
    try {
      final response =
          await dio.put('$baseUrl/Trajectories/$trajectoryId', data: name);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<MeasureModel>?> getMeasuresBySteps(int steps) async {
    try {
      final response = await dio.get('$baseUrl/Measures/steps/$steps');
      return (response.data as List)
          .map((m) => MeasureModel.fromJson(m))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<MeasureModel>?> getMeasures(
      {required DateTime start, required DateTime end, int? steps}) async {
    try {
      final response = await dio.get(
        '$baseUrl/Measures/${start.toIso8601String()}/${end.toIso8601String()}',
        queryParameters: {
          if (steps != null) 'steps': steps,
        },
      );

      return (response.data as List)
          .map((m) => MeasureModel.fromJson(m))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<MeasureModel>?> getMeasuresFromTrajectory(int trajectoryId,
      {int? steps}) async {
    try {
      final response = await dio.get(
        '$baseUrl/Measures/trajectory/$trajectoryId',
        queryParameters: {
          if (steps != null) 'steps': steps,
        },
      );
      return (response.data as List)
          .map((m) => MeasureModel.fromJson(m))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<bool> getIsOn() async {
    try {
      final response = await dio.get('$baseUrl/Robot/isOn');
      return response.data as bool;
    } catch (e) {
      return false;
    }
  }
}
