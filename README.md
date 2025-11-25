# php-runner

Lightweight Docker-based PHP runner for executing PHP commands and scripts inside a consistent container image.

## Overview

This repository provides:
- A Docker image definition for PHP 8.3 with Composer and Node.js: [`Dockerfile`](Dockerfile)
- A small launcher script to run `php` inside the container: [`scripts/php-run`](scripts/php-run)
- An installer script to install the launcher into `$HOME/.local/bin`: [`install.sh`](install.sh)
- License: [`LICENSE`](LICENSE)

## Requirements

- Docker (https://www.docker.com/)
- git (for the installer)
- A POSIX-compatible shell to run the installer and launcher

## Quick install

1. Clone and run the installer (or inspect and run manually):
   - The installer included is [`install.sh`](install.sh).
   - Note: you can also build the image manually with:
     ```
     docker build -t php-runner .
     ```

2. One-line install (curl)

  You can install quickly with a single command (runs the installer via bash):

  ```bash
  curl -fsSL https://raw.githubusercontent.com/you/php-docker-runner/main/install.sh | bash
  ```

  Security note: review the script before running curl|bash in case you need to adjust the repository URL or inspect the steps it performs.

2. After running the installer, ensure `$HOME/.local/bin` is in your `PATH`. The installer copies the launcher to that directory as `php-run`.

3. Test:
   ```
   php-run -v
   ```
   The launcher [`scripts/php-run`](scripts/php-run) runs `php` inside the `php-runner` image and forwards arguments to the container.

## Usage

- Run a PHP file in the current directory:
  ```
  php-run script.php
  ```
- Run Composer (Composer is preinstalled in the image):
  ```
  php-run composer install
  ```
- Pass any `php` CLI flags:
  ```
  php-run -r 'echo phpversion();'
  ```

Implementation detail: the launcher uses `docker run --rm -it -v "$PWD":/app -w /app php-runner php "$@"` to mount the current directory into `/app` and run the `php` binary inside the `php-runner` image. See [`scripts/php-run`](scripts/php-run).

## Development

- Dockerfile is at [`Dockerfile`](Dockerfile). It starts from `php:8.3-cli`, installs git, curl, unzip, Composer and Node.js, and sets `WORKDIR /app`.
- Modify the image and rebuild locally with:
  ```
  docker build -t php-runner .
  ```

## Files

- [`Dockerfile`](Dockerfile) — image definition
- [`scripts/php-run`](scripts/php-run) — launcher script (installed as `php-run`)
- [`install.sh`](install.sh) — installer that clones the repo, builds the image and installs the launcher
- [`LICENSE`](LICENSE) — MIT license

## Notes

- The installer clones the repository and builds the image. Review `install.sh` before running for security and to confirm paths.
- If you prefer not to use the installer, copy [`scripts/php-run`](scripts/php-run) to a directory on your `PATH` and make it executable.

## License

This project is licensed under the MIT