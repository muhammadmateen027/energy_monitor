# Energy Monitor App

## Overview

The Energy Monitor App is designed to track and manage energy consumption and generation data. It uses Flutter for the frontend and Drift for local database management. The app is structured to follow a clean architecture, separating concerns into different layers and components.

## Project Structure

### Main Components

- `main.dart`: The entry point of the application.
- `energy_monitor_app.dart`: The main application widget.
- `energy_base_cubit.dart`: The base Cubit class for managing state.
- `battery_cubit.dart`: Cubit for managing battery-related state.
- `app_database.dart`: The Drift database configuration.
- `monitoring_data_point_dao.dart`: Data Access Object (DAO) for monitoring data points.
- `energy_client.dart`: Client for fetching data from external APIs.
- `energy_repository.dart`: Repository for managing data operations.
- `connectivity_checker.dart`: Utility for checking internet connectivity.
- `data_parser.dart`: Parser for converting data between different formats.
- `battery_repository.dart`: Repository for managing battery consumption data.
- `house_consumption_repository.dart`: Repository for managing house consumption data.
- `solar_repository.dart`: Repository for managing solar generation data.

## Architecture

The app follows a layered architecture with the following layers:

1. **Presentation Layer**: Contains the UI and state management logic.
2. **Domain Layer**: Contains business logic and entities.
3. **Data Layer**: Manages data sources, including local databases and remote APIs.

### Presentation Layer

- **Cubits**: Manage the state of the application.
  - `energy_base_cubit.dart`: Abstract base class for energy-related Cubits.
  - `battery_cubit.dart`: Manages the state related to battery consumption.

### Domain Layer

- **Repositories**: Define the contract for data operations.
  - `battery_repository.dart`: Manages battery consumption data.
  - `house_consumption_repository.dart`: Manages house consumption data.
  - `solar_repository.dart`: Manages solar generation data.

### Data Layer

- **Database**: Manages local data storage using Drift.
  - `app_database.dart`: Configures the Drift database.
  - `monitoring_data_point_dao.dart`: DAO for monitoring data points.
- **API Client**: Fetches data from external APIs.
  - `energy_client.dart`: Client for fetching energy data.
- **Data Parser**: Converts data between different formats.
  - `data_parser.dart`: Parses data using isolates for performance.

## Business Logic

### Cubits

- **EnergyBaseCubit**: Abstract class that provides common functionality for energy-related Cubits.
- **BatteryCubit**: Extends `EnergyBaseCubit` to manage battery consumption data.

### Repositories

- **BatteryRepository**: Fetches and clears battery consumption data.
- **HouseConsumptionRepository**: Fetches and clears house consumption data.
- **SolarRepository**: Fetches and clears solar generation data.

### Database

- **AppDatabase**: Configures the Drift database and provides DAOs.
- **MonitoringDataPointDao**: Provides methods to insert, update, delete, and query monitoring data points.

### API Client

- **EnergyClient**: Fetches energy data from external APIs.

### Data Parser

- **DataParser**: Abstract class for parsing data.
- **IsolateDataParser**: Implements `DataParser` using isolates for performance.

## Interconnections

1. **Cubits** interact with **Repositories** to fetch and manage data.
2. **Repositories** use the **API Client** to fetch data from external sources and the **Database** to store and retrieve data locally.
3. **Data Parser** is used by **Repositories** to convert data between different formats.
4. **Connectivity Checker** ensures that the app can handle offline scenarios gracefully.

## Detailed Explanation

### main.dart

The entry point of the application. It initializes the app and sets up necessary configurations.

### energy_monitor_app.dart

The main application widget that sets up the app's theme and routes.

### energy_base_cubit.dart

An abstract base class for energy-related Cubits. It defines common functionality such as fetching data and handling errors.

### battery_cubit.dart

Extends `EnergyBaseCubit` to manage the state related to battery consumption. It interacts with `BatteryRepository` to fetch and clear battery data.

### app_database.dart

Configures the Drift database and provides DAOs for accessing data. It includes the database schema and migration logic.

### monitoring_data_point_dao.dart

A Data Access Object (DAO) for monitoring data points. It provides methods to insert, update, delete, and query data points.

### energy_client.dart

A client for fetching energy data from external APIs. It handles network requests and parses the response.

### energy_repository.dart

An abstract class that defines the contract for data operations. It is implemented by specific repositories such as `BatteryRepository`, `HouseConsumptionRepository`, and `SolarRepository`.

### connectivity_checker.dart

A utility for checking internet connectivity. It ensures that the app can handle offline scenarios gracefully.

### data_parser.dart

An abstract class for parsing data. The `IsolateDataParser` implementation uses isolates to perform data parsing in the background, improving performance.

### battery_repository.dart

Manages battery consumption data. It fetches data from the API and stores it in the local database. It also provides methods to clear battery data.

### house_consumption_repository.dart

Manages house consumption data. It fetches data from the API and stores it in the local database. It also provides methods to clear house data.

### solar_repository.dart

Manages solar generation data. It fetches data from the API and stores it in the local database. It also provides methods to clear solar data.

## Conclusion

The Energy Monitor App is designed with a clean architecture, separating concerns into different layers and components. This structure ensures that the app is maintainable, scalable, and testable.