# GraphQL API for Things 3

An unofficial read-only GraphQL API endpoint for the personal task manager application [Things 3](https://culturedcode.com/things/) by [Cultured Code](https://culturedcode.com/).

Although Cultured Code [does not expose an official API for Things 3](https://twitter.com/culturedcode/status/648518883960197121?lang=en), they do [support accessing the application data](https://culturedcode.com/things/support/articles/2982272/).

This application connects to a read-only backup of the Things 3 database file and exposes a GraphQL API endpoint on top of it.

## How it works

The GraphQL API for Things 3 application is lightweight, easy to install, and stable. To achieve this the application uses common tools like:

- Ruby 3 programming language
- Puma web server
- Sinatra web application
- ActiveRecord database ORM
- GraphQL Ruby API

All code is freely available on Github and released under `GPLv3` license.

## Installation

### System packages

Ensure the following system packages are installed:

- `ruby` >= 3.0
- `sqlite3`

To install `sqlite3` on MacOS:

```
$ brew install sqlite3
```

### Application configuration

Download the latest application code:

```
$ git clone https://github.com/evelion-apps/things-api things-api
```

Install required Ruby gems:

```
$ cd things-api
$ bin/install
```

### Application validation

Start the server using the included example database and validate the application is installed and configured correctly:

```
$ bin/start 9292 db/hello.sqlite3
```

The server will start on `http://localhost:9292`. Open in a web browser or use cURL to validate it's running:

```
$ curl http://localhost:9292/
Welcome to GraphQL API for Things 3...
```

To validate the GraphQL API is returning data send a POST request to `http://localhost:9292/`. This can be done using an application like GraphiQL or Postman:

```
{
  "query": "{ todos { uuid } }"
}
```

Or from the command line using cURL:

```
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{todos { uuid }}"}'
{"data":{"todos":[{"uuid":"hello-world"}]}}
```

**NOTE:** See the API Documentation section for more examples.

## Running

To start the application, specify the port for the server to run on and the path to the Things 3 database backup file:

```
$ bin/start 3001 "/path/to/backup/Things Database.sqlite3"
```

Or to the live Things 3 database file (**Disclaimer** this functionality is experimental and could result in dataloss):

```
$ bin/start 3000 "~/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/Things Database.thingsdatabase"
```

### Backing up the database file automatically

This application gets its data from a read-only copy of the Things 3 database file. This file can be managed manually or automatically by the application.

To enable automatic backups:

1. Copy the `.env` file `.env.local`
1. Update `.env.local` values:
    ```bash
    export SYNC_DB_ENABLED=true
    export SYNC_DB_FREQUENCY_IN_SECONDS=60
    export SYNC_DB_USERNAME=<your-username>
    ```

#### Remote backup over the network

> Experimental

It's also possible to run this application from a remote server, backing up the Things 3 database file from a Mac OS computer over the network. To do so:

1. Enable Passwordless SSH access on the Mac OS computer
1. Update the `.env.local` with
    ```bash
    export SYNC_DB_REMOTE_HOST=192.168.1.10
    export SYNC_DB_REMOTE_WAIT_FOR_SYNC_IN_SECONDS=10
    ```

The backup script will attempt to wake the remote computer, wait long enough to allow Things 3 to sync its data, then backup the database. This feature is experimental.

## API Documentation

### Today

> List Today. Returns a list of ordered projects and todo items

GraphQL Query:

```
{
  "query": "{ today { title typeString statusString } }"
}
```

From the command line using cURL:

```
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{today { title typeString statusString}}"}'
{"data":{"today":[{"title": "Example Project", "typeString": "project", "statusString": "open"},{"title": "Example Todo", "typeString": "todo", "statusString": "open"}]}}
```

For a full list of available fields see [`TaskType`](https://github.com/evelion-apps/things-api/blob/main/graphql/types/task.rb).

### Todos

> List all open todos

GraphQL Query:

```
{
  "query": "{ todo { title typeString statusString } }"
}
```

From the command line using cURL:

```
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{todo { title typeString statusString}}"}'
{"data":{"todo":[{"title": "Example", "typeString": "todo", "statusString": "open"}]}}
```

For a full list of available fields see [`TaskType`](https://github.com/evelion-apps/things-api/blob/main/graphql/types/task.rb).

### Heading

> List all open headings

GraphQL Query:

```
{
  "query": "{ heading { title typeString } }"
}
```

From the command line using cURL:

```
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{heading { title typeString }}"}'
{"data":{"heading":[{"title": "Example", "typeString": "heading"}]}}
```

For a full list of available fields see [`TaskType`](https://github.com/evelion-apps/things-api/blob/main/graphql/types/task.rb).

### Project

> List all open projects

GraphQL Query:

```
{
  "query": "{ project { title typeString } }"
}
```

From the command line using cURL:

```
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{project { title typeString }}"}'
{"data":{"project":[{"title": "Example", "typeString": "project"}]}}
```

For a full list of available fields see [`TaskType`](https://github.com/evelion-apps/things-api/blob/main/graphql/types/task.rb).

## Acknowledgements

[Cultured Code](https://culturedcode.com/) for their phenomenal application [Things 3](https://culturedcode.com/things/).

[Awin Abi](https://github.com/awinabi/sinatra-graphql) for the lightweight Sinatra/GraphQL/SQlite application architecture inspired by his post [Simple GraphQL Server and Sinatra](https://medium.com/@awinabi/graphql-server-with-sinatra-ruby-part-1-fdd664170715).

## License

Database schema is created by and owned by [Cultured Code](https://culturedcode.com/).

This project is intended to enable users to better understand their copy of an [exported database file from Things 3](https://culturedcode.com/things/support/articles/2982272/). It is **not** meant to be used to modify an existing application database or to recreate Things 3 application logic.

The read-only API code is open source and released under the `GPLv3` license. For more license details see the included `LICENSE` file.

## Project support

Code is freely available with no obligation or expectation of monetary contributions. If you appreciate the project and would still like to say thanks, you can make a donation here:

<a href="https://www.buymeacoffee.com/evelion" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="150" height="40"/></a>
