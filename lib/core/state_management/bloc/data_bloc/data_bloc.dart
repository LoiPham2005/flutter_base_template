// lib/core/bloc/data_bloc/data_bloc.dart

import 'package:flutter_base_template/core/state_management/bloc/base_bloc.dart' hide FetchDataListEvent, DataEvent, FetchDataDetailEvent, CreateDataEvent, UpdateDataEvent, DeleteDataEvent, LoadMoreDataEvent, SearchDataEvent, ClearDataEvent;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../errors/result.dart';
import '../../../utils/logger.dart';
import 'data_event.dart';
import 'data_state.dart';

abstract class DataBloc<T> extends Bloc<DataEvent<T>, DataState<T>> {
  DataBloc() : super(const DataInitial()) {
    on<FetchDataListEvent<T>>(_onFetchList);
    on<FetchDataDetailEvent<T>>(_onFetchDetail);
    on<CreateDataEvent<T>>(_onCreate);
    on<UpdateDataEvent<T>>(_onUpdate);
    on<DeleteDataEvent<T>>(_onDelete);
    on<LoadMoreDataEvent<T>>(_onLoadMore);
    on<SearchDataEvent<T>>(_onSearch);
    on<ClearDataEvent<T>>(_onClear);
  }

  // Abstract methods that must be implemented
  Future<Result<List<T>>> fetchList(Map<String, dynamic>? params);
  Future<Result<T>> fetchDetail(String id, Map<String, dynamic>? params);
  Future<Result<T>> create(Map<String, dynamic> data);
  Future<Result<T>> update(String id, Map<String, dynamic> data);
  Future<Result<bool>> delete(String id);

  // Optional: Override nếu cần
  Future<Result<List<T>>> loadMore(int page, Map<String, dynamic>? params) {
    return fetchList({...?params, 'page': page});
  }

  Future<Result<List<T>>> search(String query, Map<String, dynamic>? filters) {
    return fetchList({...?filters, 'search': query});
  }

  // Event Handlers
  Future<void> _onFetchList(
    FetchDataListEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading());

    Logger.debug('Fetching list with params: ${event.params}');

    final result = await fetchList(event.params);

    result.fold(
      onSuccess: (data) {
        if (data.isEmpty) {
          emit(const DataEmpty());
        } else {
          emit(
            DataListLoaded<T>(
              data: data,
              hasMore: false, // Override trong subclass nếu có pagination
              currentPage: 1,
            ),
          );
        }
      },
      onFailure: (failure) {
        Logger.error('Fetch list error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onFetchDetail(
    FetchDataDetailEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading(message: 'Đang tải chi tiết...'));

    Logger.debug('Fetching detail: ${event.id}');

    final result = await fetchDetail(event.id, event.params);

    result.fold(
      onSuccess: (data) {
        emit(DataDetailLoaded<T>(data));
      },
      onFailure: (failure) {
        Logger.error('Fetch detail error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onCreate(
    CreateDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading(message: 'Đang tạo...'));

    Logger.debug('Creating data: ${event.data}');

    final result = await create(event.data);

    result.fold(
      onSuccess: (data) {
        emit(DataOperationSuccess<T>(message: 'Tạo thành công', data: data));
      },
      onFailure: (failure) {
        Logger.error('Create error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onUpdate(
    UpdateDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading(message: 'Đang cập nhật...'));

    Logger.debug('Updating data: ${event.id}');

    final result = await update(event.id, event.data);

    result.fold(
      onSuccess: (data) {
        emit(
          DataOperationSuccess<T>(message: 'Cập nhật thành công', data: data),
        );
      },
      onFailure: (failure) {
        Logger.error('Update error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onDelete(
    DeleteDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading(message: 'Đang xóa...'));

    Logger.debug('Deleting data: ${event.id}');

    final result = await delete(event.id);

    result.fold(
      onSuccess: (_) {
        emit(DataOperationSuccess<T>(message: 'Xóa thành công'));
      },
      onFailure: (failure) {
        Logger.error('Delete error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onLoadMore(
    LoadMoreDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    if (state is DataListLoaded<T>) {
      final currentState = state as DataListLoaded<T>;
      emit(DataLoadingMore<T>(currentState.data));

      Logger.debug('Loading more page: ${event.page}');

      final result = await loadMore(event.page, event.params);

      result.fold(
        onSuccess: (newData) {
          final allData = [...currentState.data, ...newData];
          emit(
            currentState.copyWith(
              data: allData,
              currentPage: event.page,
              hasMore: newData.isNotEmpty,
            ),
          );
        },
        onFailure: (failure) {
          Logger.error('Load more error: ${failure.message}');
          emit(DataError<T>(message: failure.message, failure: failure));
        },
      );
    }
  }

  Future<void> _onSearch(
    SearchDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataLoading(message: 'Đang tìm kiếm...'));

    Logger.debug('Searching: ${event.query}');

    final result = await search(event.query, event.filters);

    result.fold(
      onSuccess: (data) {
        if (data.isEmpty) {
          emit(const DataEmpty(message: 'Không tìm thấy kết quả'));
        } else {
          emit(DataListLoaded<T>(data: data));
        }
      },
      onFailure: (failure) {
        Logger.error('Search error: ${failure.message}');
        emit(DataError<T>(message: failure.message, failure: failure));
      },
    );
  }

  Future<void> _onClear(
    ClearDataEvent<T> event,
    Emitter<DataState<T>> emit,
  ) async {
    emit(const DataInitial());
  }
}
