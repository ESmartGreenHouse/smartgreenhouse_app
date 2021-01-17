part of 'menu_cubit.dart';

class MenuState extends Equatable {
  final bool showAdvancedFeatures;

  MenuState({
    this.showAdvancedFeatures = false,
  });

  @override
  List<Object> get props => [showAdvancedFeatures];

  MenuState copyWith({bool showAdvancedFeatures}) => MenuState(
    showAdvancedFeatures: showAdvancedFeatures ?? this.showAdvancedFeatures,
  );

}
