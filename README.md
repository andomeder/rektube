# Rektube - Music Player

![Rektube Logo](assets/images/logo-color.png)

Rektube is a mobile music streaming application built with Flutter for the ACS314 Mobile Development course at Daystar University. It allows users to search for music, play audio streams, manage playlists, like songs, and view playback history. The application leverages a self-hosted Piped instance (acting as a frontend for YouTube data) and a PostgreSQL database for user data persistence.

## Features

*   **User Authentication:** Secure Signup and Login using email/username and password (passwords hashed with bcrypt).
*   **Music Discovery:** Search for tracks via the self-hosted Piped instance.
*   **Playback:** Stream audio using the `media_kit` package. Includes standard controls (play/pause, seek), shuffle, and repeat modes.
*   **Mini Player:** Persistent player control visible across core app screens.
*   **Library Management:**
    *   **Liked Songs:** Mark favorite tracks.
    *   **Playlists:** Create custom playlists and add tracks to them.
    *   **History:** Automatically tracks recently played songs.
*   **Explore:** View trending music (fetched from Piped).
*   **Dashboard:** Personalized view showing recently played and liked songs.
*   **Settings:** Basic app settings including theme toggling (Light/Dark) and app info.
*   **Dynamic Theming:** Supports both Light and Dark themes.

## Tech Stack

*   **Frontend:** Flutter & Dart
*   **State Management:** GetX (UI state, routing, simple controllers), Riverpod (Data fetching, async state, dependency injection)
*   **Audio Playback:** `media_kit`
*   **Database ORM:** `drift` + `drift_postgres`
*   **Database:** PostgreSQL
*   **API Backend:** Self-Hosted Piped (Dockerized, using Caddy reverse proxy within Docker)
*   **Networking:** `dio` (for direct Piped API calls), `http`
*   **Local Storage:** `get_storage` (preferences), `flutter_secure_storage` (user session)
*   **Utilities:** `flutter_dotenv`, `bcrypt`, `intl`, `package_info_plus`, `equatable`, `flutter_native_splash`, `flutter_launcher_icons`

## Project Structure (`lib` folder)

*   `configs/`: Color definitions, theme data (`ThemeData`), app-wide constants.
*   `controllers/`: GetX controllers managing UI state and user interactions for specific features (auth, player, navigation, settings).
*   `database/`: Drift setup including:
    *   `connection/`: PostgreSQL connection logic.
    *   `tables/`: Database table schemas defined using Drift.
    *   `daos/`: Data Access Objects with methods for querying tables (generated code included).
    *   `type_converters.dart`: Custom converters (e.g., for PostgreSQL timestamps).
    *   `database.dart`: Main Drift database class definition.
*   `models/`: Plain Dart Objects representing data structures (User, Track, Playlist).
*   `providers/`: Riverpod providers for injecting repositories, DAOs, and managing application-level state (auth, player state checks).
*   `repositories/`: Abstraction layer handling data fetching (Piped, DB) and business logic (Auth, Player, Library).
*   `utils/`: Helper functions, route definitions, exception classes, secure storage wrapper, input validators.
*   `views/`: Contains UI code:
    *   `screens/`: Top-level application screens for different features.
    *   `widgets/`: Reusable UI components (common, core-feature specific, player).
*   `main.dart`: Application entry point, initialization logic, root widget (`MyApp`).


## Setup & Installation

Follow these steps to set up the project for development. Instructions are provided primarily for Ubuntu, with notes for Windows where applicable.

### Prerequisites

1.  **Flutter SDK:** Install Flutter for your operating system by following the [official Flutter installation guide](https://docs.flutter.dev/get-started/install). Ensure `flutter` and `dart` commands are available in your PATH.
2.  **Git:** Install Git ([https://git-scm.com/](https://git-scm.com/)).
3.  **Docker & Docker Compose:**
    *   **Ubuntu:** Follow the official Docker documentation to install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) and the [Docker Compose plugin](https://docs.docker.com/compose/install/linux/). Ensure your user is added to the `docker` group to run commands without `sudo`.
    *   **Windows:** Install [Docker Desktop](https://www.docker.com/products/docker-desktop/). WSL2 backend is highly recommended. Docker Compose is typically included.
4.  **PostgreSQL Client:** You need `psql` or a GUI client (like DBeaver, pgAdmin) to interact with the database.
    *   **Ubuntu:** `sudo apt update && sudo apt install postgresql-client`
    *   **Windows:** Can be installed as part of the PostgreSQL server installation or separately.
5.  **PostgreSQL Server:** You need a running PostgreSQL server accessible from your development machine. This can be:
    *   A local installation on your host machine (Ubuntu/Windows).
    *   A separate Docker container.
    *   *Note: The Piped Docker setup includes its own PostgreSQL container, but the Flutter app connects to a *different* one defined in your `.env` file.* Ensure this separate DB server is running.
6.  **Ngrok (Recommended for Mobile Testing):**
    *   Sign up for a free account at [ngrok.com](https://ngrok.com/).
    *   Install the Ngrok CLI ([https://ngrok.com/download](https://ngrok.com/download)).
    *   Authenticate the CLI with your authtoken: `ngrok config add-authtoken YOUR_AUTH_TOKEN` (replace `YOUR_AUTH_TOKEN` with the token from your Ngrok dashboard).
7.  **IDE/Editor:** Android Studio or VS Code with Flutter extensions installed.
8.  **Android Emulator / Physical Device:** For running the Flutter app. Ensure USB debugging is enabled for physical devices.


### Installation Steps

1.  **Clone the Rektube Repository:**
    ```bash
    git clone https://github.com/andomeder/rektube.git
    cd rektube
    ```

2.  **Set up Self-Hosted Piped Backend:**
    *   **Clone Official Piped Docker Repo:** First, clone the official setup repository from TeamPiped *separately* from the Rektube project folder:
        ```bash
        git clone https://github.com/TeamPiped/Piped-Docker.git
        cd Piped-Docker
        ```
    *   **Run Configuration Script:** Execute the configuration script. When prompted:
        *   Enter desired hostnames (e.g., `piped.rektube`, `pipedapi.rektube`, `pipedproxy.rektube` - these are mainly used internally by Docker).
        *   Choose `caddy` as the reverse proxy.
        *   Choose `http` when asked about reachability (as we are not setting up TLS within Docker here).
        ```bash
        ./configure-instance.sh
        ```
    *   **Replace Configuration File:** Copy the customized `Caddyfile` from the Rektube project's `piped/` directory into the `Piped-Docker/config/` directory, **overwriting** the file generated by the script:
        ```bash
        # Assuming you are inside the Piped-Docker directory
        # Adjust the path to your Rektube project's piped folder if necessary
        cp ../rektube/piped/Caddyfile ./config/
        ```
    *   **Replace Docker Compose File:** Copy the customized `docker-compose.yml` from the Rektube project's `piped/` directory into the `Piped-Docker/` directory, **overwriting** the generated one:
        ```bash
        # Assuming you are inside the Piped-Docker directory
        cp ../rektube/piped/docker-compose.yml ./
        ```
    *   **Start Services:** Start the Docker containers using the modified configuration:
        ```bash
        docker compose up -d
        ```
        Wait a minute for services to initialize. Use `docker compose logs -f caddy` or `docker compose logs -f piped-backend` to check status.

3.  **Set up PostgreSQL Database (for Rektube App):**
    *   Connect to your main PostgreSQL server (local install or separate container).
    *   Create the database user (e.g., `yourusername`) and database (e.g., `rektube` or `postgres` - match `.env`!). Grant privileges.
        ```sql
        -- Example using psql
        sudo -u postgres psql # Or connect as your admin user

        CREATE DATABASE rektube; -- Or your chosen DB name from .env
        CREATE USER yourusername WITH ENCRYPTED PASSWORD 'admin'; -- Use a STRONG password!
        GRANT ALL PRIVILEGES ON DATABASE rektube TO yourusername;
        \q
        ```
    *   Connect to the app's database:
        ```bash
        psql -U yourusername -d rektube -h localhost # Or your DB host
        ```
    *   Execute the SQL commands from `database.sql` (or copy-paste from previous response) to create the required tables (`users`, `playlists`, etc.) and the `updated_at` trigger.

4.  **Set up Ngrok (Recommended for Mobile Testing):**
    *   Ensure Ngrok CLI is installed and authenticated.
    *   Copy the `ngrok.yml` file from the Rektube project root to your Ngrok config directory:
        *   **Ubuntu:** `cp ngrok.yml ~/.config/ngrok/ngrok.yml`
        *   **Windows:** Copy `ngrok.yml` to `%HOMEPATH%\.config\ngrok\`
    *   Start Ngrok in a separate terminal:
        ```bash
        ngrok start --all --config=ngrok.yml
        ```
    *   Note the **TCP forwarding address/port** for PostgreSQL and the **HTTPS forwarding URL** for Caddy/Piped.

5.  **Configure Flutter App (`.env`):**
    *   Navigate back to the Rektube project root (`cd ../rektube`).
    *   Copy `.env.example` to `.env`: `cp .env.example .env`
    *   Edit `.env` with your specific details:
        *   `DATABASE_HOST`: Ngrok TCP hostname (e.g., `0.tcp.eu.ngrok.io`).
        *   `DATABASE_PORT`: Ngrok TCP port (e.g., `15405`).
        *   `DATABASE_NAME`: Your app's database name (e.g., `rektube`).
        *   `DATABASE_USER`: Your DB user (e.g., `yourusername`).
        *   `DATABASE_PASSWORD`: Your DB user's password.
        *   `PIPED_INSTANCE_URL`: Ngrok HTTPS URL for Caddy (e.g., `https://d05f....ngrok-free.app`).
        *   `NGROK_HOST`: Hostname part of the `PIPED_INSTANCE_URL` (e.g., `d05f....ngrok-free.app`).

6.  **Build & Run Flutter App:**
    *   Get dependencies: `flutter pub get`
    *   Generate Drift code: `flutter pub run build_runner build --delete-conflicting-outputs`
    *   Generate icons/splash (Optional): `flutter pub run ...`
    *   **No `adb reverse` needed if using Ngrok URLs in `.env`.**
    *   Run the app: `flutter run`

### Alternative Network Setup (Without Ngrok - Local Wi-Fi Only)

If you prefer not to use Ngrok and your development machine and mobile device are on the **same local Wi-Fi network**:

1.  **Find Laptop IP:** Use `ip addr` (Linux/macOS) or `ipconfig` (Windows) to find your laptop's local IP address (e.g., `192.168.1.10`).
2.  **Configure `.env`:**
    *   Set `DATABASE_HOST` to your laptop's local IP address.
    *   Set `DATABASE_PORT` to your PostgreSQL server's port (`5432`).
    *   Set `PIPED_INSTANCE_URL` to `http://YOUR_LAPTOP_IP:3142` (using your IP and the host port mapped to Caddy in `docker-compose.yml`).
    *   Set `NGROK_HOST` to your laptop's IP address (used by the rewrite helper).
3.  **Firewall:** Ensure your host machine's firewall allows incoming connections on the PostgreSQL port (5432) and the Piped Caddy port (3142) from your local network.
4.  **PostgreSQL `listen_addresses`:** Ensure your PostgreSQL server is configured to listen on your network IP (or `*`) in `postgresql.conf`.
5.  **PostgreSQL `pg_hba.conf`:** Ensure connections are allowed from your local network range for your database user.
6.  **Run App:** Run `flutter run`.

### Apache Reverse Proxy (Optional - If not using Ngrok/Docker Caddy)

The `piped/piped.conf` file is an **example Apache configuration** for setting up a reverse proxy on your *host machine* if you were *not* using Docker's Caddy or Ngrok as the primary entry point. If you are using the recommended Docker Caddy setup and Ngrok, you generally **do not need** to configure Apache for this project. This file is provided for reference if you choose a different hosting/proxy strategy.

## Troubleshooting

*   **Connection Refused (Database):** Verify PostgreSQL server status, `.env` details match Ngrok TCP or local IP/port, Ngrok tunnel active (if used), firewall rules, `pg_hba.conf`, `listen_addresses`.
*   **Connection Refused / 404 / 50x Errors (Piped API):** Verify Piped Docker containers running (`docker ps`, `docker compose logs caddy`, `docker compose logs piped-backend`), `.env` details match Ngrok HTTPS URL or local IP/port, Ngrok tunnel active (if used), firewall rules. Test API endpoints directly via the URL in `.env`.
*   **Thumbnail Errors (`No host specified...`):** Ensure `pipedInstanceUrl` constant is loading correctly (check `main.dart` prints). Verify `rewritePipedUrlForLocalDev` uses the correct Ngrok/local host. Ensure `TrackListItem` etc. use the `track.thumbnailUrl` getter. Check DB values (`track_thumbnail_path`).
*   **"Add to Playlist" Fails:** Check Flutter console for errors. Add print statements in the dialog `onTap` and `LibraryRepository.addTrackToPlaylist`. Ensure `TrackListItem` is a `ConsumerWidget`.

## Future Improvements

*   Implement full playlist management (rename, delete, remove tracks, reorder).
*   Implement full Liked Songs screen.
*   Add queue management features to the player screen.
*   Implement actual Appearance/Account settings.
*   Add pull-to-refresh on library/dashboard screens.
*   Implement caching for API requests (search, trending).
*   Add unit and widget tests.
*   Refine error handling and user feedback.
*   Investigate integrating native Android features if needed (e.g., background playback services, notifications).

## Acknowledgements

*   Developed for ACS314 Mobile Development, Daystar University.
*   Uses the Piped API ([https://docs.piped.video/](https://docs.piped.video/)).
*   Relies on various open-source Flutter packages.