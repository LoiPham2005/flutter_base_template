# Project Architecture (Feature Layer)

This project follows the principles of **Clean Architecture** combined with a **Feature-First** structure to ensure code is organized, maintainable, and scalable.

## Feature Directory Structure

```
lib/
└── features/
    ├── auth/                 # Authentication feature
    │   ├── data/             # Data layer
    │   │   ├── datasources/  # Remote & Local data sources
    │   │   ├── models/       # DTOs / Models
    │   │   └── repositories/ # Repository implementations
    │   ├── domain/           # Domain layer
    │   │   ├── entities/     # Core business objects
    │   │   ├── repositories/ # Abstract interfaces
    │   │   └── usecases/     # Interactors / UseCases
    │   └── presentation/     # Presentation layer
    │       ├── pages/        # Screens / Pages
    │       ├── widgets/      # Reusable Widgets
    │       └── bloc/         # BLoC / Cubit / Controller
    └── ...                   # Other features structured similarly
```

## Layer Responsibilities

### 1. Presentation Layer (`lib/features/*/presentation`)

* **Responsibility:** Handle UI rendering and user inputs.
* **Components:** Widgets (Pages, UI Components), State Management (BLoC, Cubit, Controller).
* **Behavior:** Calls `UseCases` from Domain Layer; never accesses Data Layer directly.

### 2. Domain Layer (`lib/features/*/domain`)

* **Responsibility:** Encapsulate core business logic. Independent of other layers.
* **Components:**

  * **Entities:** Pure business objects (e.g., `User`, `Product`).
  * **Repositories (Abstract):** Interfaces that define data access contracts without specifying sources.
  * **UseCases / Interactors:** Encapsulate a specific business process (e.g., `LoginUseCase`, `GetProductsUseCase`).

### 3. Data Layer (`lib/features/*/data`)

* **Responsibility:** Provide data to Domain Layer.
* **Components:**

  * **Repositories (Implementation):** Implement abstract interfaces from Domain Layer; decide whether data comes from remote or local.
  * **Data Sources:** Specific sources like API (`RemoteDataSource`) or local storage (`LocalDataSource`).
  * **Models:** DTOs or Models that map data (JSON ↔ Entity).

## Data Flow Example

Typical flow for fetching a list of products:

1. **UI (Widget)** triggers an event in **BLoC/Cubit/Controller**.
2. **BLoC/Cubit** calls `execute()` on **`GetProductsUseCase`**.
3. **UseCase** calls `getProducts()` on **`ProductRepository`** (abstract).
4. **ProductRepositoryImpl** (Data Layer) receives the call and checks network via `NetworkInfo`.
5. If online, calls **`ProductRemoteDataSource`**.
6. **RemoteDataSource** fetches data via API client (e.g., Dio).
7. JSON data is mapped to **`ProductModel`**.
8. Data is returned to BLoC, which emits a new **State**.
9. **UI** listens to state changes and updates automatically.

## Dependency Injection (DI)

* **Tools:** `get_it` + `injectable`.
* **Mechanism:**

  * Classes (Services, Repositories, DataSources, BLoCs) annotated with `@lazySingleton`, `@injectable`, or `@factory`.
  * External dependencies (e.g., SharedPreferences, Connectivity) provided via `@module` in `lib/core/di/injection.dart`.
  * Running `flutter pub run build_runner build` generates `injection.config.dart` for automatic dependency injection.
* **Benefits:** Reduces tight coupling, improves testability and maintainability.

## State Management

Flexible support for multiple solutions. Base classes located in `lib/core/state_management`:

* **BLoC / Cubit:** `BaseBloc`, `BaseState`, etc.
* **GetX:** `BaseController`
* **Riverpod:** Example implementations in `lib/core/state_management/riverpod`

You can choose one or combine multiple state management approaches depending on feature complexity.
