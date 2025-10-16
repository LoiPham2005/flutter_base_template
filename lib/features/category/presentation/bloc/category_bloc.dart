import 'package:equatable/equatable.dart';
import 'package:flutter_base_template/core/state_management/bloc/BaseState.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_helper.dart';
import 'package:flutter_base_template/features/category/domain/entities/category.dart';
import 'package:flutter_base_template/features/category/domain/usecases/category_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {
  final Map<String, dynamic>? params;
  final bool refresh;

  const LoadCategories({
    this.params,
    this.refresh = false,
  });

  @override
  List<Object?> get props => [params, refresh];
}


// @injectable
// class CategoryBloc extends Bloc<CategoryEvent, BaseState> {
//   final GetCategoriesUseCase _getCategoriesUseCase;

//   CategoryBloc({
//     required GetCategoriesUseCase getCategoriesUseCase,
//   }) : _getCategoriesUseCase = getCategoriesUseCase,
//        super(CategoryState.initial()) {
//     on<LoadCategories>(_onLoadCategories);
//   }

//   Future<void> _onLoadCategories(
//     LoadCategories event,
//     Emitter<CategoryState> emit,
//   ) async {
//     emit(state.copyWith(status: BlocStatus.loading));

//     final result = await _getCategoriesUseCase(params: event.params);

//     result.fold(
//       onSuccess: (categories) {
//         emit(state.copyWith(
//           status: BlocStatus.success,
//           categories: categories,
//         ));
//       },
//       onFailure: (failure) {
//         emit(state.copyWith(
//           status: BlocStatus.failure,
//           error: failure.message,
//         ));
//       },
//     );
//   }
// }



@injectable
class CategoryBloc extends Bloc<CategoryEvent, BaseState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryBloc({required GetCategoriesUseCase getCategoriesUseCase})
      : _getCategoriesUseCase = getCategoriesUseCase,
        super(BaseState.initial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<BaseState> emit,
  ) async {
    await handleBlocRequest<List<Category>, BaseState>(
      emit,
      () => _getCategoriesUseCase(params: event.params),
      ({status, data, error}) => state.copyWith(
        status: status,
        data: data ?? state.data,
        error: error,
      ),
    );
  }
}


