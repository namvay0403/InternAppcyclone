part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;

  ThemeChanged(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}
