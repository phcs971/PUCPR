// ignore_for_file: library_private_types_in_public_api

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:robotxp_dashboard/app/models/filter_model.dart';
import 'package:robotxp_dashboard/app/models/trajectory_model.dart';
import 'package:robotxp_dashboard/app/utils.dart';

import '../models/measure_model.dart';
import '../repositories/robotxp_repository.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final repository = RobotXPRepository();

  final jointNames = ["I", "II", "III", "IV", "V", "VI"];

  late TabController controller;

  void config(TickerProvider vsync) {
    controller = TabController(length: 2, vsync: vsync);
  }

  final dateFilters = [
    DateFilterModel.fromDuration(const Duration(minutes: 5), "5 Minutos"),
    DateFilterModel.fromDuration(const Duration(minutes: 10), "10 Minutos"),
    DateFilterModel.fromDuration(const Duration(minutes: 30), "30 Minutos"),
    DateFilterModel.fromDuration(const Duration(hours: 1), "1 Hora"),
    DateFilterModel.fromDuration(const Duration(hours: 2), "2 Horas"),
    DateFilterModel.fromDuration(const Duration(hours: 6), "6 Horas"),
    DateFilterModel.fromDuration(const Duration(hours: 12), "12 Horas"),
    DateFilterModel.fromDuration(const Duration(days: 1), "1 Dia"),
    DateFilterModel.fromDuration(const Duration(days: 5), "5 Dias"),
    DateFilterModel.fromDuration(const Duration(days: 7), "1 Semana"),
    DateFilterModel.fromDuration(const Duration(days: 14), "2 Semanas"),
    DateFilterModel.fromDuration(const Duration(days: 30), "1 Mês"),
    DateFilterModel.fromDuration(const Duration(days: 90), "3 Meses"),
    DateFilterModel.fromDuration(const Duration(days: 180), "6 Meses"),
    DateFilterModel.fromDuration(const Duration(days: 365), "1 Ano"),
    const EmptyFilterModel(),
  ];

  int trajPage = 0, trajTake = 10;
  int get trajSkip => trajPage * trajTake;

  @observable
  FilterModel? filter;

  @observable
  List<TrajectoryModel> trajectories = ObservableList();

  @observable
  int trajectoriesCount = 0;

  List<TrajectoryFilterModel> get trajectoryFilters => trajectories
      .map((trajectory) => TrajectoryFilterModel(trajectory))
      .toList();

  @observable
  bool isOn = false;

  @observable
  int? selected;

  @observable
  List<MeasureModel> measures = ObservableList();

  @computed
  String get selectedText =>
      selected == null ? 'Total' : 'Junta ${jointNames[selected!]}';

  @computed
  double get totalPower => selected == null
      ? measures.fold<double>(
              0, (sum, measure) => sum + measure.totalPower * measure.hours) /
          1000
      : measures.fold<double>(
              0,
              (sum, m) =>
                  sum +
                  m.joints.firstWhere((j) => j.number == selected! + 1).power *
                      m.hours) /
          1000;

  @computed
  DateTime get startTime =>
      measures.isEmpty ? DateTime.now() : measures.first.createdAt;

  @computed
  DateTime get endTime => measures.isEmpty
      ? DateTime.now()
      : measures.last.endAt ?? measures.last.createdAt;

  @computed
  Duration get duration => endTime.difference(startTime);

  @computed
  double get totalMoney => (totalPower) * (0.6519 + 0.12292);

  @computed
  List<charts.Series<ChartData, DateTime>> get series {
    return [
      charts.Series<ChartData, DateTime>(
        id: "Power",
        data: measures.map<ChartData>((m) {
          return ChartData(
            selected == null
                ? m.totalPower
                : m.joints.firstWhere((j) => j.number == selected! + 1).power,
            dateTimeAverage(m.createdAt, m.endAt ?? m.createdAt),
          );
        }).toList(),
        domainFn: (data, _) => data.date,
        measureFn: (data, _) => data.value,
      )..setAttribute(charts.rendererIdKey, 'area'),
    ];
  }

  @action
  Future<void> fetchIsOn() async {
    isOn = await repository.getIsOn();
  }

  @action
  Future<void> fetchTrajectories() async {
    final result =
        await repository.getTrajectories(skip: trajSkip, take: trajTake);
    if (result != null) {
      trajectories.clear();
      trajectoriesCount = result.totalCount;
      trajectories.addAll(result.trajectories);
    }
  }

  @action
  Future<void> fetchMeasures() async {
    List<MeasureModel>? result;
    const steps = 100;
    if (filter is DateFilterModel) {
      final filter = this.filter as DateFilterModel;
      result = await repository.getMeasures(
        start: filter.start,
        end: filter.end,
        steps: steps,
      );
    } else if (filter is TrajectoryFilterModel) {
      final filter = this.filter as TrajectoryFilterModel;
      result = await repository.getMeasuresFromTrajectory(
        filter.trajectoryId,
        steps: steps,
      );
    } else {
      result = await repository.getMeasuresBySteps(steps);
    }
    if (result != null) {
      measures.clear();
      measures.addAll(result);
    }
  }

  @action
  void setFilter(FilterModel? filter) {
    if (filter is EmptyFilterModel) filter = null;
    this.filter = filter;
    fetchMeasures();
  }

  Future<void> fetchAll() async {
    fetchIsOn();
    fetchMeasures();
  }
}

class ChartData {
  final double value;
  final DateTime date;

  ChartData(this.value, this.date);
}
