part of 'drawer_wrapper_cubit.dart';

abstract class DrawerWrapperState extends Equatable {
  final int uniqueId; // in order to be able emit the same state several times (during Drag for ex.)
  
  const DrawerWrapperState({required this.uniqueId});

  @override
  List<Object> get props => [uniqueId];
}

class OpenTriggeredDrawerState extends DrawerWrapperState {
  OpenTriggeredDrawerState() : super(uniqueId: DateTime.now().millisecondsSinceEpoch);
}

class CloseTriggeredDrawerState extends DrawerWrapperState {
  CloseTriggeredDrawerState() : super(uniqueId: DateTime.now().millisecondsSinceEpoch);
}
