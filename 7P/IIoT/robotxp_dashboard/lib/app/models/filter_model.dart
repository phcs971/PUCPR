import 'package:robotxp_dashboard/app/models/trajectory_model.dart';

abstract class FilterModel {
  final String title;
  final bool byTrajectory;

  const FilterModel(this.title, this.byTrajectory);

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }

  @override
  int get hashCode => title.hashCode;
}

class EmptyFilterModel extends FilterModel {
  const EmptyFilterModel() : super('Total', false);
}

class DateFilterModel extends FilterModel {
  final DateTime start;
  final DateTime end;

  const DateFilterModel(
      {required this.start, required this.end, required String title})
      : super(title, false);

  DateFilterModel.fromDuration(Duration duration, String title)
      : start = DateTime.now().subtract(duration),
        end = DateTime.now(),
        super(title, false);

  @override
  // ignore: hash_and_equals
  int get hashCode =>
      (start.toIso8601String() + end.toIso8601String()).hashCode;
}

class TrajectoryFilterModel extends FilterModel {
  final TrajectoryModel trajectory;
  int get trajectoryId => trajectory.id;

  TrajectoryFilterModel(this.trajectory) : super(trajectory.title, true);

  @override
  // ignore: hash_and_equals
  int get hashCode => trajectoryId.hashCode;
}
