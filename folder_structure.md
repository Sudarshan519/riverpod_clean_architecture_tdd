```
lib
┣ configs
┃ ┗ app_configs.dart
┣ features
┃ ┣ authentication
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┣ auth_local_data_source.dart
┃ ┃ ┃ ┃ ┗ auth_remote_data_source.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ atuhentication_repository_impl.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ login_provider.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ auth_repository.dart
┃ ┃ ┗ presentation
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┣ state
┃ ┃ ┃ ┃ ┃ ┣ auth_notifier.dart
┃ ┃ ┃ ┃ ┃ ┣ auth_state.dart
┃ ┃ ┃ ┃ ┃ ┗ auth_state.freezed.dart
┃ ┃ ┃ ┃ ┗ auth_providers.dart
┃ ┃ ┃ ┣ screens
┃ ┃ ┃ ┃ ┗ login_screen.dart
┃ ┃ ┃ ┗ widgets
┃ ┃ ┃ ┃ ┣ auth_field.dart
┃ ┃ ┃ ┃ ┗ button.dart
┃ ┣ home
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┣ home_local_datasource.dart
┃ ┃ ┃ ┃ ┗ home_remote_datasource.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ home_repository.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ home_providers.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ home_repository.dart
┃ ┃ ┗ presentation
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┣ state
┃ ┃ ┃ ┃ ┃ ┣ home_notifier.dart
┃ ┃ ┃ ┃ ┃ ┗ home_state.dart
┃ ┃ ┃ ┃ ┗ home_state_provider.dart
┃ ┃ ┃ ┣ screens
┃ ┃ ┃ ┃ ┗ home_screen.dart
┃ ┃ ┃ ┗ widgets
┃ ┗ .DS_Store
┣ main
┃ ┣ app.dart
┃ ┣ app_env.dart
┃ ┣ main_dev.dart
┃ ┣ main_staging.dart
┃ ┗ observers.dart
┣ routes
┃ ┣ app_route.dart
┃ ┗ app_route.gr.dart
┣ services
┃ ┣ other_service
┃ ┗ user_cache_service
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┗ user_local_datasource.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ user_repository_impl.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ user_cache_provider.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ user_cache_repository.dart
┃ ┃ ┗ presentation
┃ ┃ ┃ ┗ .gitkeep
┣ shared
┃ ┣ data
┃ ┃ ┣ local
┃ ┃ ┃ ┣ shared_prefs_storage_service.dart
┃ ┃ ┃ ┗ storage_service.dart
┃ ┃ ┗ remote
┃ ┃ ┃ ┣ dio_network_service.dart
┃ ┃ ┃ ┣ network_service.dart
┃ ┃ ┃ ┗ remote.dart
┃ ┣ domain
┃ ┃ ┣ models
┃ ┃ ┃ ┣ home
┃ ┃ ┃ ┃ ┣ bank_model.dart
┃ ┃ ┃ ┃ ┣ bank_model.freezed.dart
┃ ┃ ┃ ┃ ┗ bank_model.g.dart
┃ ┃ ┃ ┣ user
┃ ┃ ┃ ┃ ┗ user_model.dart
┃ ┃ ┃ ┣ models.dart
┃ ┃ ┃ ┣ paginated_response.dart
┃ ┃ ┃ ┣ parse_response.dart
┃ ┃ ┃ ┗ response.dart
┃ ┃ ┗ providers
┃ ┃ ┃ ┣ dio_network_service_provider.dart
┃ ┃ ┃ ┗ sharedpreferences_storage_service_provider.dart
┃ ┣ exceptions
┃ ┃ ┗ http_exception.dart
┃ ┣ mixins
┃ ┃ ┗ exception_handler_mixin.dart
┃ ┣ theme
┃ ┃ ┣ app_colors.dart
┃ ┃ ┣ app_theme.dart
┃ ┃ ┣ test_styles.dart
┃ ┃ ┗ text_theme.dart
┃ ┣ widgets
┃ ┃ ┣ app_error.dart
┃ ┃ ┗ app_loading.dart
┃ ┗ globals.dart
┣ .DS_Store
┣ main.dart
┗ splash_screen.dart
```

Test
```
test
┣ features
┃ ┣ authentication
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┣ auth_local_data_source_test.dart
┃ ┃ ┃ ┃ ┗ auth_remote_data_source_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ atuhentication_repository_impl_test.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ providers_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ .gitkeep
┃ ┃ ┗ presentation
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ auth_providers_test.dart
┃ ┃ ┃ ┗ screens
┃ ┃ ┃ ┃ ┗ .gitkeep
┃ ┗ home
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┣ home_local_datasource_test.dart
┃ ┃ ┃ ┃ ┗ home_remote_datasource_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ home_repository_test.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ home_provider_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ .gitkeep
┃ ┃ ┗ presentation
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┣ state
┃ ┃ ┃ ┃ ┃ ┗ home_state_test.dart
┃ ┃ ┃ ┃ ┗ home_provider_test.dart
┃ ┃ ┃ ┗ screens
┣ fixtures
┃ ┣ home
┃ ┃ ┗ dummy_banklist.dart
┃ ┣ data
┃ ┃ ┣ bank_response.dart
┃ ┃ ┗ user_map.dart
┃ ┣ dummy_data.dart
┃ ┣ test_fixture.dart
┃ ┗ user_response.json
┣ services
┃ ┗ user_cache_service
┃ ┃ ┣ data
┃ ┃ ┃ ┣ datasource
┃ ┃ ┃ ┃ ┗ user_local_datasource_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ user_cache_repository_test.dart
┃ ┃ ┣ domain
┃ ┃ ┃ ┣ providers
┃ ┃ ┃ ┃ ┗ user_cache_provider_test.dart
┃ ┃ ┃ ┗ repositories
┃ ┃ ┃ ┃ ┗ user_cache_repository_test.dart
┃ ┃ ┗ presentation
┃ ┃ ┃ ┗ .gitkeep
┗ shared
┃ ┣ data
┃ ┃ ┣ local
┃ ┃ ┃ ┗ sharedpreferences_storage_service_test.dart
┃ ┃ ┗ remote
┃ ┃ ┃ ┗ dio_network_service_test.dart
┃ ┣ domain
┃ ┃ ┣ models
┃ ┃ ┃ ┣ product
┃ ┃ ┃ ┃ ┗ product_model_test.dart
┃ ┃ ┃ ┣ user
┃ ┃ ┃ ┃ ┗ user_model_test.dart
┃ ┃ ┃ ┗ response_test.dart
┃ ┃ ┗ providers
┃ ┃ ┃ ┗ providers_test.dart
┃ ┣ exceptions
┃ ┃ ┗ http_exception_test.dart
┃ ┗ mixins
┃ ┃ ┗ exception_handler_mixin_test.dart
```