# Env

There are 2 environments: 
- `dev`: `padelistas-dev`.
- `prod`: `padelistas-app`.



Be careful to use the correct profile when running the application.

## Dev

While developing, use the `dev` profile to run the application locally, this should be the one use by default when running 

```shell
flutter run
```

## Prod

When deploying to production, use `prod`.

```shell
flutter build web --dart-define=env=prod
```
