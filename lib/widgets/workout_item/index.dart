import 'package:flutter/material.dart';
import 'package:jeomgymjeok_gwabuha/models/m_workout_item.dart';
import 'package:jeomgymjeok_gwabuha/widgets/workout_item/workout_item_content.dart';
import 'package:jeomgymjeok_gwabuha/widgets/workout_item/workout_item_header.dart';

class WorkoutItem extends StatefulWidget {
  const WorkoutItem({
    super.key,
    required this.workout,
  });

  final MWorkoutItem workout;

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem>
    with SingleTickerProviderStateMixin {
  var _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _heightFactor;

  void _onTapHeader() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 150,
      ),
    );
    _heightFactor = _animationController.drive(Tween(begin: 0.0, end: 1.0));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        WorkoutItemHeader(
          isExpanded: _isExpanded,
          name: widget.workout.name,
          totalSetCount: widget.workout.set.length,
          onTapHeader: _onTapHeader,
        ),
        WorkoutItemContent(
          heightFactor: _heightFactor,
          set: widget.workout.set,
        ),
      ],
    );
  }
}