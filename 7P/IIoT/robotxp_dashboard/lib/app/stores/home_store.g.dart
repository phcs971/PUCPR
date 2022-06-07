// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<String>? _$selectedTextComputed;

  @override
  String get selectedText =>
      (_$selectedTextComputed ??= Computed<String>(() => super.selectedText,
              name: '_HomeStoreBase.selectedText'))
          .value;
  Computed<double>? _$totalPowerComputed;

  @override
  double get totalPower =>
      (_$totalPowerComputed ??= Computed<double>(() => super.totalPower,
              name: '_HomeStoreBase.totalPower'))
          .value;
  Computed<DateTime>? _$startTimeComputed;

  @override
  DateTime get startTime =>
      (_$startTimeComputed ??= Computed<DateTime>(() => super.startTime,
              name: '_HomeStoreBase.startTime'))
          .value;
  Computed<DateTime>? _$endTimeComputed;

  @override
  DateTime get endTime =>
      (_$endTimeComputed ??= Computed<DateTime>(() => super.endTime,
              name: '_HomeStoreBase.endTime'))
          .value;
  Computed<Duration>? _$durationComputed;

  @override
  Duration get duration =>
      (_$durationComputed ??= Computed<Duration>(() => super.duration,
              name: '_HomeStoreBase.duration'))
          .value;
  Computed<double>? _$totalMoneyComputed;

  @override
  double get totalMoney =>
      (_$totalMoneyComputed ??= Computed<double>(() => super.totalMoney,
              name: '_HomeStoreBase.totalMoney'))
          .value;
  Computed<List<charts.Series<ChartData, DateTime>>>? _$seriesComputed;

  @override
  List<charts.Series<ChartData, DateTime>> get series => (_$seriesComputed ??=
          Computed<List<charts.Series<ChartData, DateTime>>>(() => super.series,
              name: '_HomeStoreBase.series'))
      .value;

  late final _$filterAtom =
      Atom(name: '_HomeStoreBase.filter', context: context);

  @override
  FilterModel? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(FilterModel? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$trajectoriesAtom =
      Atom(name: '_HomeStoreBase.trajectories', context: context);

  @override
  List<TrajectoryModel> get trajectories {
    _$trajectoriesAtom.reportRead();
    return super.trajectories;
  }

  @override
  set trajectories(List<TrajectoryModel> value) {
    _$trajectoriesAtom.reportWrite(value, super.trajectories, () {
      super.trajectories = value;
    });
  }

  late final _$trajectoriesCountAtom =
      Atom(name: '_HomeStoreBase.trajectoriesCount', context: context);

  @override
  int get trajectoriesCount {
    _$trajectoriesCountAtom.reportRead();
    return super.trajectoriesCount;
  }

  @override
  set trajectoriesCount(int value) {
    _$trajectoriesCountAtom.reportWrite(value, super.trajectoriesCount, () {
      super.trajectoriesCount = value;
    });
  }

  late final _$isOnAtom = Atom(name: '_HomeStoreBase.isOn', context: context);

  @override
  bool get isOn {
    _$isOnAtom.reportRead();
    return super.isOn;
  }

  @override
  set isOn(bool value) {
    _$isOnAtom.reportWrite(value, super.isOn, () {
      super.isOn = value;
    });
  }

  late final _$selectedAtom =
      Atom(name: '_HomeStoreBase.selected', context: context);

  @override
  int? get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(int? value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  late final _$measuresAtom =
      Atom(name: '_HomeStoreBase.measures', context: context);

  @override
  List<MeasureModel> get measures {
    _$measuresAtom.reportRead();
    return super.measures;
  }

  @override
  set measures(List<MeasureModel> value) {
    _$measuresAtom.reportWrite(value, super.measures, () {
      super.measures = value;
    });
  }

  late final _$fetchIsOnAsyncAction =
      AsyncAction('_HomeStoreBase.fetchIsOn', context: context);

  @override
  Future<void> fetchIsOn() {
    return _$fetchIsOnAsyncAction.run(() => super.fetchIsOn());
  }

  late final _$fetchTrajectoriesAsyncAction =
      AsyncAction('_HomeStoreBase.fetchTrajectories', context: context);

  @override
  Future<void> fetchTrajectories() {
    return _$fetchTrajectoriesAsyncAction.run(() => super.fetchTrajectories());
  }

  late final _$fetchMeasuresAsyncAction =
      AsyncAction('_HomeStoreBase.fetchMeasures', context: context);

  @override
  Future<void> fetchMeasures() {
    return _$fetchMeasuresAsyncAction.run(() => super.fetchMeasures());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setFilter(FilterModel? filter) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setFilter');
    try {
      return super.setFilter(filter);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
trajectories: ${trajectories},
trajectoriesCount: ${trajectoriesCount},
isOn: ${isOn},
selected: ${selected},
measures: ${measures},
selectedText: ${selectedText},
totalPower: ${totalPower},
startTime: ${startTime},
endTime: ${endTime},
duration: ${duration},
totalMoney: ${totalMoney},
series: ${series}
    ''';
  }
}
