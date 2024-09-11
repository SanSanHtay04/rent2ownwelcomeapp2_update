# Rent2OwnWelcome App


## Install
Before run app, open terminal and run this command first
```bash
dart  run build_runner build  --delete-conflicting-outputs
```


# Environment Variables

| Name | Type | Value | Description |  
|--|--|--|--|  
| SERVER_URL | string | https://app-be.r2omm.xyz \| https://test-be.r2omm.xyz | Server URL mostly used as base URL. |
| LOG_LEVEL | string | info \| warning \| error \| debug \| nothing \| verbose \| wtf | |
| IS_PROD | bool | true\| false| Is production build? |

E.g.
`flutter run  --dart-define=SERVER_URL=http://test-be.r2omm.xyz --dart-define=LOG_LEVEL=info --dart-define=IS_PROD=false`

# Flavors
This project has one dimension: "app" dimension; and two flavors: "dev" and "prod" for "app" dimensions. To run/build the project your need to specify the flavor that you want.

E.g. `flutter run --flavor=dev`


# Releases Android Production
Note: Should do this at first time you clone source from git
- Create a file named `[project]/android/key.properties` that contains a reference to your keystore:
    ```properties
    storePassword=<password from private release document>
    keyPassword=<password from private release document>
    keyAlias=<alias from private release document>
    storeFile=<location where save the key store file, such as /Users/<user name>/welcome-upload-keystore.jks>
    ```

- Build Test script:
    ```shell
    flutter build apk --release --flavor=dev
    ```
    
- Build Production script:
    ```shell
    flutter build apk --release --flavor=prod 
    --dart-define=IS_PROD=true 
    ```
