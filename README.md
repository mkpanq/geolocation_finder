# Geolocation Finder

Geolocation Finder is a simple Rails API application that uses an external API to get and save domain/IP geolocation data. The application leverages the [ip-api](https://ip-api.com/) API due to its friendly interface and generous non-commercial usage limits.

## Installation

1. Clone the repository:

```
git clone git@github.com:mkpanq/geolocation_finder.git
cd geolocation-finder
```

2. Launch the application using Docker Compose:

```
docker-compose up
```

This command will start the application and set up the database configuration automatically.

**Warning** - `database.yml` configuration is strictly adjusted to docker implementation. If you want to start app locally on your machine, remember to make appropriate changes in this file - in other case there could be a DB connection problem.

## API Routes

### `GET /api/v1`

Fetches the geolocation data for a given domain or IP address from database

**Parameters:**

- `query`: The domain name / IP address to fetch

**Example**

```
curl --location 'localhost:3000/api/v1?query=wp.pl'
```

### `POST /api/v1`

Fetch geolocation data from external API and save to database

**Parameters:**

- `query`: The domain name / IP address to fetch
- `refresh=true (optional)`: Optional refresh parameter to update already existing location data for current query

**Example**

```
curl --location --request POST 'localhost:3000/api/v1?query=wp.pl&refresh=true'
```

### `DELETE /api/v1`

Removes the geolocation data for a given domain or IP address from the database

**Parameters:**

- `query`: The domain name / IP address to delete geolocation data

**Example**

```
curl --location --request DELETE 'localhost:3000/api/v1?query=onet.pl'
```

## Tests

To run test run command via docker-compose:

```
docker compose exec app rspec
```
