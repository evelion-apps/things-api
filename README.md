# GraphQL API for Things 3

An unofficial GraphQL API endpoint for the personal task manager application [Things 3](https://culturedcode.com/things/) by [Cultured Code](https://culturedcode.com/).

Although Cultured Code [does not expose an official API for Things 3](https://twitter.com/culturedcode/status/648518883960197121?lang=en), they do [support accessing the application data](https://culturedcode.com/things/support/articles/2982272/).

This application connects to a Things 3 database file and exposes a GraphQL API endpoint on top of it. This application can either read:

- A backup database file exported from an iPhone/iPad/Mac.
- Connect directly to the live Things 3 database. **Disclaimer** this functionality is experimental and could result in dataloss.

## How it works

The GraphQL API for Things 3 application is lightweight, easy to install, and stable. To achieve this the application uses common tools like:

- Ruby 3 programming language
- Puma web server
- Sinatra web application
- ActiveRecord database ORM
- GraphQL Ruby API

All code is freely available on Github and released under GPLv3 license.

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

Start the server using an example database and validate the application is installed and configured correctly:

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
$ curl -X POST http://localhost:9292 -H "Content-Type: application/json" -d '{"query": "{todos {uuid}}"}'
{"data":{"todos":[{"uuid":"hello-world"}]}}
```

## Running

To start the application, specify the port for the server to run on and the path to the Things 3 database backup file:

```
$ bin/start 4000 "/path/to/backup/Things Database.sqlite3"
```

Or to the live Things 3 database file (**Disclaimer** this functionality is experimental and could result in dataloss):

```
$ bin/start 3000 "~/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/Things Database.thingsdatabase"
```

## Acknowledgements

[Cultured Code](https://culturedcode.com/) for their phenomenal application [Things 3](https://culturedcode.com/things/).

[Awin Abi](https://github.com/awinabi/sinatra-graphql) for the lightweight Sinatra/GraphQL/SQlite application architecture inspired by his post [Simple GraphQL Server and Sinatra](https://medium.com/@awinabi/graphql-server-with-sinatra-ruby-part-1-fdd664170715).

## License

All code is provided free of charge and released under the MIT license. For more details see the included `LICENSE` file.

## Support

<a href="https://www.buymeacoffee.com/evelion" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="150" height="40"/></a>
