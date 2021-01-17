import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState());

  void showAdvancedFeatures(value) {
    emit(state.copyWith(showAdvancedFeatures: value ?? false));
  }
}
