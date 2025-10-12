// lib/core/bloc/data_bloc/data_state.dart

import 'package:flutter_base_template/core/errors/failures.dart';

import '../base_state.dart';

abstract class DataState<T> extends BaseState {
  const DataState();
}

// Initial State
class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

// Loading State
class DataLoading<T> extends DataState<T> {
  final String? message;
  
  const DataLoading({this.message});
  
  @override
  List<Object?> get props => [message];
}

// Load More Loading
class DataLoadingMore<T> extends DataState<T> {
  final List<T> currentData;
  
  const DataLoadingMore(this.currentData);
  
  @override
  List<Object?> get props => [currentData];
}


// Success with List
class DataListLoaded<T> extends DataState<T> {
  final List<T> data;
  final bool hasMore;
  final int currentPage;
  final int? totalPages;
  final int? totalItems;
  
  const DataListLoaded({
    required this.data,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPages,
    this.totalItems,
  });
  
  @override
  List<Object?> get props => [data, hasMore, currentPage, totalPages, totalItems];
  
  DataListLoaded<T> copyWith({
    List<T>? data,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
    int? totalItems,
  }) {
    return DataListLoaded<T>(
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}

// Success with Single Item
class DataDetailLoaded<T> extends DataState<T> {
  final T data;
  
  const DataDetailLoaded(this.data);
  
  @override
  List<Object?> get props => [data];
}

// Success Operation (Create, Update, Delete)
class DataOperationSuccess<T> extends DataState<T> {
  final String message;
  final T? data;
  
  const DataOperationSuccess({
    required this.message,
    this.data,
  });
  
  @override
  List<Object?> get props => [message, data];
}

// Error State
class DataError<T> extends DataState<T> {
  final String message;
  final Failure? failure;
  
  const DataError({
    required this.message,
    this.failure,
  });
  
  @override
  List<Object?> get props => [message, failure];
}

// Empty State
class DataEmpty<T> extends DataState<T> {
  final String message;
  
  const DataEmpty({this.message = 'Không có dữ liệu'});
  
  @override
  List<Object?> get props => [message];
}