// lib/core/bloc/data_bloc/data_event.dart

import '../base_event.dart';

abstract class DataEvent<T> extends BaseEvent {
  const DataEvent();
}

// Fetch List
class FetchDataListEvent<T> extends DataEvent<T> {
  final Map<String, dynamic>? params;
  final bool refresh;
  
  const FetchDataListEvent({
    this.params,
    this.refresh = false,
  });
  
  @override
  List<Object?> get props => [params, refresh];
}

// Fetch Detail by ID
class FetchDataDetailEvent<T> extends DataEvent<T> {
  final String id;
  final Map<String, dynamic>? params;
  
  const FetchDataDetailEvent({
    required this.id,
    this.params,
  });
  
  @override
  List<Object?> get props => [id, params];
}

// Create
class CreateDataEvent<T> extends DataEvent<T> {
  final Map<String, dynamic> data;
  
  const CreateDataEvent(this.data);
  
  @override
  List<Object?> get props => [data];
}

// Update
class UpdateDataEvent<T> extends DataEvent<T> {
  final String id;
  final Map<String, dynamic> data;
  
  const UpdateDataEvent({
    required this.id,
    required this.data,
  });
  
  @override
  List<Object?> get props => [id, data];
}

// Delete
class DeleteDataEvent<T> extends DataEvent<T> {
  final String id;
  
  const DeleteDataEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}

// Load More (Pagination)
class LoadMoreDataEvent<T> extends DataEvent<T> {
  final int page;
  final Map<String, dynamic>? params;
  
  const LoadMoreDataEvent({
    required this.page,
    this.params,
  });
  
  @override
  List<Object?> get props => [page, params];
}

// Search
class SearchDataEvent<T> extends DataEvent<T> {
  final String query;
  final Map<String, dynamic>? filters;
  
  const SearchDataEvent({
    required this.query,
    this.filters,
  });
  
  @override
  List<Object?> get props => [query, filters];
}

// Clear Data
class ClearDataEvent<T> extends DataEvent<T> {
  const ClearDataEvent();
}