

# Flutter Clean Architecture with Riverpod

A Flutter app that uses the bank api.

### Features

- Login
- Fetch bankss
- Search banks

### What is used in this project?

- **Riverpod**
  Used for state management
- **Freezed**
  Code generation

- **Dartz**
  Functional Programming `Either<Left,Right>`
- **Auto Route**
  Navigation package that uses code generation to simplify route setup
- **Dio**
  Http client for dart. Supports interceptors and global configurations
- **Shared Preferences**
  Persistent storage for simple data
- **Flutter and Dart**
  And obviously flutter and dart 😅

### Project Description

#### Data

The data layer is the outermost layer of the application and is responsible for communicating with the server-side or a local database and data management logic. It also contains repository implementations.

##### a. Data Source

Describes the process of acquiring and updating the data.
Consist of remote and local Data Sources. Remote Data Source will perform HTTP requests on the API. At the same time, local Data sources will cache or persist data.

##### b. Repository

The bridge between the Data layer and the Domain layer.
Actual implementations of the repositories in the Domain layer. Repositories are responsible for coordinating data from the different Data Sources.

#### Domain

The domain layer is responsible for all the business logic. It is written purely in Dart without flutter elements because the domain should only be concerned with the business logic of the application, not with the implementation details.

##### a. Providers

Describes the logic processing required for the application.
Communicates directly with the repositories.

##### b. Repositories

Abstract classes that define the expected functionality of outer layers.

#### Presentation

The presentation layer is the most framework-dependent layer. It is responsible for all the UI and handling the events in the UI. It does not contain any business logic.

##### a. Widget (Screens/Views)

Widgets notify the events and listen to the states emitted from the `StateNotifierProvider`.

##### b. Providers

Describes the logic processing required for the presentation.
Communicates directly with the `Providers` from the domain layer.

### Project Description

- `main.dart` file has services initialization code and wraps the root `MyApp` with a `ProviderScope`
- `main/app.dart` has the root `MaterialApp` and initializes `AppRouter` to handle the route throughout the application.
- `services` abstract app-level services with their implementations.
- The `shared` folder contains code shared across features
  - `theme` contains general styles (colors, themes & text styles)
  - `model` contains all the Data models needed in the application.
  - `http` is implemented with Dio.
  - `storage` is implemented with SharedPreferences.
  - Service locator pattern and Riverpod are used to abstract services when used in other layers.

For example:

```dart
final storageServiceProvider = Provider((ref) {
  return SharedPrefsService();
});

// Usage:
// ref.watch(storageServiceProvider);
```

- The `features` folder: the repository pattern is used to decouple logic required to access data sources from the domain layer. For example, the `homeRepository` abstracts and centralizes the various functionality required to fetch the `Product` from the remote.

```dart
abstract class homeRepository {
  Future<Either<AppException, PaginatedResponse>> fetchProducts({required int skip});

  Future<Either<AppException, PaginatedResponse>> searchProducts({required int skip, required String query});
}
```

The repository implementation with the `homeDatasource`:

```dart
class homeRepositoryImpl extends homeRepository {
  final homeDatasource homeDatasource;
  homeRepositoryImpl(this.homeDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchProducts(
      {required int skip}) {
    return homeDatasource.fetchPaginatedProducts(skip: skip);
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchProducts(
      {required int skip, required String query}) {
    return homeDatasource.searchPaginatedProducts(
        skip: skip, query: query);
  }
}
```

Using Riverpod `Provider` to access this implementation:

```dart
final homeRepositoryProvider = Provider<homeRepository>((ref) {
  final datasource = ref.watch(homeDatasourceProvider(networkService));

  return homeRepositoryImpl(datasource);
});
```

And finally accessing the repository implementation from the Presentation layer using a Riverpod `StateNotifierProvider`:

```dart
final homeNotifierProvider =
    StateNotifierProvider<homeNotifier, homeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return homeNotifier(repository)..fetchProducts();
});
```

Notice how the abstract `NetworkService` is accessed from the repository implementation and then the abstract `homeRepository` is accessed from the `homeNotifier` and how each of these layers acheive separation and scalability by providing the ability to switch implementation and make changes and/or test each layer seaparately.

### Testing

The `test` folder mirrors the `lib` folder in addition to some test utilities.

[`state_notifier_test`](https://pub.dev/packages/state_notifier_test) is used to test the `StateNotifier` and mock `Notifier`.

[`mocktail`](https://pub.dev/packages/mocktail) is used to mock dependecies.

#### 1. Testing the simple `Provider` provider:

```dart
test('bankDatasourceProvider is a bankDatasource', () {
    bankDataSource = providerContainer.read
    (homeDatasourceProvider(networkService));

    expect(
      bankDataSource,
      isA<BankDatasource>(),
    );
  });
```

And here is how we can test it separately from Flutter:

```dart
void main() {
  late bankDatasource bankDatasource;
  late bankRepository bankRepository;
  setUpAll(() {
    bankDatasource = MockRemoteDatasource();
    bankRepository = bankRepositoryImpl(bankDatasource);
  });
  test(
    'Should return AppException on failure',
    () async {
      // arrange
      when(() => bankDatasource.searchBanks(skip: any(named: 'skip'), query: any(named: 'query')))
          .thenAnswer(
        (_) async => Left(ktestAppException),
      );

      // assert
      final response = await bankRepository.searchBanks(skip: 1, query: '');

      // act
      expect(response.isLeft(), true);
    },
  );
}

class MockRemoteDatasource extends Mock implements bankRemoteDatasource {}
```
### To explore test coverage
run  `bash gencov.sh`

### Folder Structure

```
lib
├── configs
│ └── app_configs.dart
│
├── main
│ ├── app.dart
│ ├── app_env.dart
│ ├── main_dev.dart
│ ├── main_staging.dart
│ └── observers.dart
│
├──  configs
│ └── app_configs.dart
├── routes
│ ├── app_route.dart
│ └── app_route.gr.dart
│
├── services
│ └── bank_cache_service
│   ├── data
│   │ ├── datasource
│   │ │ └── bank_local_datasource.dart
│   │ └── repositories
│   │  └── bank_repository_impl.dart
│   ├── domain
│   │ ├── providers
│   │ │ └── bank_cache_provider.dart
│   │ └── repositories
│   │   └── bank_cache_repository.dart
│   └── presentation
│
├── shared
│ ├── data
│ │ ├── local
│ │ │ ├── shared_prefs_storage_service.dart
│ │ │ └── storage_service.dart
│ │ └── remote
│ │   ├── dio_network_service.dart
│ │   ├── network_service.dart
│ │   └── remote.dart
│ ├── domain
│ │ ├── models
│ │ │ ├── bank
│ │ │ │ ├── bank_model.dart
│ │ │ │ ├── bank_model.freezed.dart
│ │ │ │ └── bank_model.g.dart
│ │ │ ├── user
│ │ │ │ └── user_model.dart
│ │ │ ├── models.dart
│ │ │ ├── paginated_response.dart
│ │ │ ├── parse_response.dart
│ │ │ └── response.dart
│ │ └── providers
│ │   ├── dio_network_service_provider.dart
│ │   └── sharedpreferences_storage_service_provider.dart
│ ├── exceptions
│ │ └── http_exception.dart
│ ├── mixins
│ │ └── exception_handler_mixin.dart
│ ├── theme
│ │ ├── app_colors.dart
│ │ ├── app_theme.dart
│ │ ├── test_styles.dart
│ │ └── text_theme.dart
│ ├── widgets
│ │ ├── app_error.dart
│ │ └── app_loading.dart
│ └── globals.dart
│
├──  features
│ ├──  bank
│ │ ├──  data
│ │ │ ├──  datasource
│ │ │ │ ├──  bank_local_data_source.dart
│ │ │ │ └── bank_remote_data_source.dart
│ │ │ └── repositories
│ │ │   └── bank_repository_impl.dart
│ │ ├──  domain
│ │ │ ├──  providers
│ │ │ │ └── bank_provider.dart
│ │ │ └── repositories
│ │ │   └── bank_repository.dart
│ │ └── presentation
│ │   ├──  providers
│ │   │ ├──  state
│ │   │ │ ├──  bank_notifier.dart
│ │   │ │ ├──  bank_state.dart
│ │   │ │ └──  bank_state.freezed.dart
│ │   │ └── bank_providers.dart
│ │   ├──  screens
│ │   │ └── home_screen.dart
│ │   └── widgets
│ │     └── home_dashboard.dart
│ ├──  home
....
```

### Run this project

##### Clone this repository

` git clone repourl`

##### Go to the project directory

` cd repo`

##### Get all the packages

`flutter pub get`

##### Run the build runner command

`flutter pub run build_runner build `

##### Run the project

`flutter run` or simply press ` F5 key` if you are using VSCode

### About Me

Do visit my [portfolio site](https://jobsserach.vercel.app/)
# riverpod_clear_architecture_tdd
