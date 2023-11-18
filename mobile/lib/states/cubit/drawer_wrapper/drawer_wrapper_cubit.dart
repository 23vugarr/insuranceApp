import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_wrapper_state.dart';

class DrawerWrapperCubit extends Cubit<DrawerWrapperState> {
  DrawerWrapperCubit({bool initiallyOpened = false}) : super(initiallyOpened ? OpenTriggeredDrawerState() : CloseTriggeredDrawerState());

  void openDrawer() => emit(OpenTriggeredDrawerState());

  void closeDrawer() => emit(CloseTriggeredDrawerState());
}
