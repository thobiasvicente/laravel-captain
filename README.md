# Laravel Captain Workflow

This is a pretty simplified, but complete, workflow for using Docker and Docker Compose with Laravel development. The included docker-compose.yml file, Dockerfiles, and config files, set up a LEMP stack powering a Laravel application in the `src` directory.

## Installation

First you need to download a fresh laravel application, and put into a `src` folder to the root of this project.

You can use the composer container to create a new laravel application:

```docker-compose run --rm composer create-project laravel/laravel . ```

By default, the nginx config redirect the port 80 to 443, so you need a certificate to use https on local environment. 

To do this, go to `./nginx/certs` and create a new certificate by running this command:

```mkcert captain.test```

If you don't have mkcert installed, check the [mkcert documentation](https://github.com/FiloSottile/mkcert).

Next, spin up the containers for the full web server stack by running `docker-compose up -d --build nginx`.

After that completes, run the following to install and compile the dependencies for the application:

- `docker-compose run --rm composer install`
- `docker-compose run --rm npm install`
- `docker-compose run --rm npm run dev`

When the container network is up, the following services and their ports are available to the host machine:

- **nginx** - `:80`
- **mysql** - `:3306`
- **php** - `:9000`
- **redis** - `:6379`

You would use them just like you would with their native counterparts, including your command after any of those lines above (e.g. `docker-compose run --rm artisan db:seed`).

## Usage

Inspired in Laravel Sail, this project has a builder file that allows you to run commands more easily.

To run a command, you can use the `./builder` file.

For example, to run `php artisan migrate`, you can run `./builder artisan migrate`.

The builder is just a wrapper for `docker-compose run --rm composer install`, so you can run any command you want.

You can create an alias for the builder file in your `.bashrc` or `.zshrc` file adding the following line to your `.zshrc`:

```alias captain='sh ./builder'```

Now, you can run `captain artisan migrate` to run `php artisan migrate`.

Some cases you may need to run `source ~/.zshrc` to reload your shell, or give execution permissions to the builder file, by running `chmod +x ./builder`.

More examples:
- `captain composer install`
- `captain npm install`
- `captain npm run dev`
- `captain artisan migrate`
- `captain artisan db:seed`

Three additional containers are included that are not brought up with the webserver stack, and are instead used as "command services". These allow you to run commands that interact with your application's code, without requiring their software to be installed and maintained on the host machine. These are:

- `captain composer`
- `captain artisan`
- `captain npm`

## Production Usage

To use this workflow in production, you can use the `docker-compose.prod.yml` file. This file is a copy of the `docker-compose.yml` file, but with some changes to make it more suitable for production environments.

To use it, you can run `docker-compose -f docker-compose.prod.yml up -d --build nginx`.
Also, you can use the `captain` alias to run commands in the production environment, you just need to pass the `prod` argument after the alias.
For example, to run `npm run production`, you can run `captain prod npm run production`.

## Permissions Issues

During the PHP service setup, there are portions that reference permission issues and utilizing some commands in the `php.dockerfile` to work around them. That solution might not work for every system, and if your machine throws an error after implementing them, **please see the updated `php.dockerfile` and `php/www.conf` files included in this code archive**.

Using these updates, rebuilding your Docker network with `docker-compose up -d --build` should resolve any permissions issues during site loads, composer installations, or artisan commands.
