class AppConstant {
  ///Command
  //region Command
  static const String create = 'create';
  static const String help = 'help';
  //endregion

  /// Folder
  //region Folder
  static const String lib = 'lib';
  static const String api = 'api';
  static const String app = 'app';
  static const String appIsolate = 'app_isolate';
  static const String common = 'common';
  static const String localization = 'localization';
  static const String models = 'models';
  static const String modules = 'modules';
  static const String routes = 'routes';
  //endregion

  ///Color name
  //region Color name
  static const String black = 'black';
  static const String red = 'red';
  static const String yellow = 'yellow';
  //endregion

  /// Default structure json
  //region Default Structure json
  static const Map<String, dynamic> defaultStructure = {
    "app_isolate": {
      "type": "directory",
      "name": "app_isolate",
      "path": "app_isolate",
      "children": [
        {
          "type": "file",
          "name": "worker.dart",
          "path": "app_isolate/worker.dart",
          "children": []
        }
      ]
    },
    "app": {
      "type": "directory",
      "name": "app",
      "path": "app",
      "children": [
        {
          "type": "directory",
          "name": "cubit",
          "path": "app/cubit",
          "children": [
            {
              "type": "file",
              "name": "app_cubit.dart",
              "path": "app/cubit/app_cubit.dart",
              "children": []
            },
            {
              "type": "file",
              "name": "app_state.dart",
              "path": "app/cubit/app_state.dart",
              "children": []
            }
          ]
        },
        {
          "type": "file",
          "name": "app.dart",
          "path": "app/app.dart",
          "children": []
        }
      ]
    },
    "main_prod.dart": {
      "type": "file",
      "name": "main_prod.dart",
      "path": "main_prod.dart",
      "children": []
    },
    "commons": {
      "type": "directory",
      "name": "commons",
      "path": "commons",
      "children": [
        {
          "type": "file",
          "name": "app_manager.dart",
          "path": "commons/app_manager.dart",
          "children": []
        },
        {
          "type": "directory",
          "name": "mixin",
          "path": "commons/mixin",
          "children": []
        },
        {
          "type": "directory",
          "name": "utils",
          "path": "commons/utils",
          "children": []
        },
        {
          "type": "directory",
          "name": "widgets",
          "path": "commons/widgets",
          "children": []
        }
      ]
    },
    "module": {
      "type": "directory",
      "name": "module",
      "path": "module",
      "children": []
    },
    "localizations": {
      "type": "directory",
      "name": "localizations",
      "path": "localizations",
      "children": [
        {
          "type": "file",
          "name": "app_language.dart",
          "path": "localizations/app_language.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "app_localization.dart",
          "path": "localizations/app_localization.dart",
          "children": []
        }
      ]
    },
    "styles.dart": {
      "type": "file",
      "name": "styles.dart",
      "path": "styles.dart",
      "children": []
    },
    "main.dart": {
      "type": "file",
      "name": "main.dart",
      "path": "main.dart",
      "children": []
    },
    "main_dev.dart": {
      "type": "file",
      "name": "main_dev.dart",
      "path": "main_dev.dart",
      "children": []
    },
    "configs": {
      "type": "directory",
      "name": "configs",
      "path": "configs",
      "children": []
    },
    "model": {
      "type": "directory",
      "name": "model",
      "path": "model",
      "children": []
    },
    "env.dart": {
      "type": "file",
      "name": "env.dart",
      "path": "env.dart",
      "children": []
    },
    "api": {
      "type": "directory",
      "name": "api",
      "path": "api",
      "children": [
        {
          "type": "file",
          "name": "api_response.dart",
          "path": "api/api_response.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "decodable.dart",
          "path": "api/decodable.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "api_route.dart",
          "path": "api/api_route.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "api_data_transformer.dart",
          "path": "api/api_data_transformer.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "api_client.dart",
          "path": "api/api_client.dart",
          "children": []
        }
      ]
    },
    "routes": {
      "type": "directory",
      "name": "routes",
      "path": "routes",
      "children": [
        {
          "type": "file",
          "name": "routes.dart",
          "path": "routes/routes.dart",
          "children": []
        },
        {
          "type": "file",
          "name": "route_name.dart",
          "path": "routes/route_name.dart",
          "children": []
        }
      ]
    }
  };
  //endregion
}
