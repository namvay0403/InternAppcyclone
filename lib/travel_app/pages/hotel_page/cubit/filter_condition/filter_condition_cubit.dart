import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/filter.dart';

class FilterConditionCubit extends Cubit<FilterModel> {
  FilterConditionCubit() : super(FilterModel());

  void setFilterCondition(FilterModel filterCondition) {
    emit(filterCondition);
  }
}