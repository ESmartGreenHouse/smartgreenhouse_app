# SmartGreenHouse App

Flutter based web app for SmartGreenHouse.

## Running the app

```
flutter run -d chrome --web-hostname localhost --web-port 7357
```

## Local deployment testing

```
flutter build web
cd build/web
python -m http.server
```

## Change firestore rules

Edit `firestore.rules` file and deploy.
```
firebase deploy --only firestore:rules
```

## CI / CD

Test app is deployed at pull-request on main and production app at push on main.
