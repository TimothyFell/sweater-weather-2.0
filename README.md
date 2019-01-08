# Sweater Weather: Mod 3 Week 6 Project

This app consumes the [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/) and the [Dark Skies Weather API](https://darksky.net/dev) to allow users to get weather data for a location, create an account, login, and manage favorite locations and retrieve their weather.


## Setup

### Clone
As always start by cloning and cd-ing into the new repository in your terminal.

````terminal
$ git clone git@github.com:TimothyFell/sweater-weather-2.0.git sweater_weather
$ cd sweater_weather
````

### Ruby Version
I used Ruby 2.4.1 to create this app. If you don't have that version use [rbenv](https://github.com/rbenv/rbenv#installing-ruby-versions) to install it and set it locally for this app using the following code.

````terminal
$ rbenv install 2.4.1
$ rbenv local 2.4.1
````

### Bundle
Bundle to install all the required gems.

````terminal
$ bundle
````

### Create Database
Create database to store users and favorites. There currently is no seed file.

````terminal
$ bundle exec rake db:{create,migrate}
````


## Configuration
  There are a few more steps before you can get the tests up and running.

### API's

#### Google Geocoding API
  Sign up for an account with Google and follow their start up instructions [here](https://developers.google.com/maps/documentation/geocoding/s) to generate an api_key for your app. Copy and paste it into a file for later use.

#### Dark Sky Weather API
  Sign up for an account with Dark Sky and follow their instructions [here](https://darksky.net/dev/docs) to generate an api_key for your app. Copy and paste it into a file for later use.

#### Giphy API
  Sign up for an account with Giphy and follow their instructions [here](https://developers.giphy.com/docs/) to generate an api_key for your app. Copy and paste it into a file for later use.


### Gem: Figaro
[Figaro](https://github.com/laserlemon/figaro) is a gem that will allow you to use and mask your api-keys so you don't push them up to GitHub. To generate the necessary files run the following command.

````terminal
$ bundle exec figaro install
````

After the files are created locate your `application.yml` file in `./config/`. Remember those api_keys you saved for Google, Dark Sky and Giphy? We are going to store them in this file in the following way and this file will be added to your .gitignore list so it won't ever get committed or pushed.

````yml
GEOCODING_API_KEY: your-google-api-key

DARK_SKY_API_KEY: your-dark-sky-api-key

GIPHY_API_KEY: your-giphy-api-key
````

The environmental variables we set above have been configured to be masked when VCR's are created for testing, so make sure the variables are spelled correctly in your application.yml file.


## Running Tests
Now you are ready to run the tests! Use the following command to run all your tests.

````terminal
$ bundle exec rspec
````

or this command to run a specific file or directory.

````terminal
$ bundle exec rspec ./spec/path/to/file/or/directory
````

## API Endpoints

### 1. Weather for a City
  #### Verb /Path: GET /api/v1/forecast
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  location: New York, NY # city, state initials
  ````
  #### Body:
  ````ruby
  # nothing
  ````
  #### Response:
  ````ruby
   {
    "latitude": 39.7392358,
    "longitude": -104.990251,
    "timezone": "America/Denver",
    "currently": {
        "time": 1546868744,
        "summary": "Clear",
        "icon": "clear-night",
        "nearestStormDistance": 7,
        "nearestStormBearing": 359,
        "precipIntensity": 0,
        "precipProbability": 0,
        "temperature": 34.39,
        "apparentTemperature": 31.97,
        "dewPoint": 9.21,
        "humidity": 0.34,
        "pressure": 1009.55,
        "windSpeed": 3.04,
        "windGust": 12.3,
        "windBearing": 217,
        "cloudCover": 0.04,
        "uvIndex": 0,
        "visibility": 8.22,
        "ozone": 302.54
    },
    "minutely": {
        "summary": "Clear for the hour.",
        "icon": "clear-night",
        "data": [
            {
                "time": 1546868700,
                "precipIntensity": 0,
                "precipProbability": 0
            },
            {...}
            {
                "time": 1546872300,
                "precipIntensity": 0.004,
                "precipIntensityError": 0.003,
                "precipProbability": 0.01,
                "precipAccumulation": 0.03,
                "precipType": "snow"
            }
        ]
    },
    "hourly": {
        "summary": "Windy this afternoon and partly cloudy starting this evening, continuing until tomorrow morning.",
        "icon": "wind",
        "data": [
            {
                "time": 1546866000,
                "summary": "Clear",
                "icon": "clear-night",
                "precipIntensity": 0,
                "precipProbability": 0,
                "temperature": 33.92,
                "apparentTemperature": 33.92,
                "dewPoint": 9.73,
                "humidity": 0.36,
                "pressure": 1009.5,
                "windSpeed": 2.95,
                "windGust": 12.95,
                "windBearing": 239,
                "cloudCover": 0.12,
                "uvIndex": 0,
                "visibility": 3.86,
                "ozone": 299.4
            },
            {...}
            {
                "time": 1547038800,
                "summary": "Mostly Cloudy",
                "icon": "partly-cloudy-night",
                "precipIntensity": 0,
                "precipProbability": 0,
                "temperature": 26.7,
                "apparentTemperature": 26.7,
                "dewPoint": 13.8,
                "humidity": 0.58,
                "pressure": 1030.58,
                "windSpeed": 2.62,
                "windGust": 2.91,
                "windBearing": 217,
                "cloudCover": 0.64,
                "uvIndex": 0,
                "visibility": 10,
                "ozone": 250.66
            }
        ]
    },
    "daily": {
        "summary": "No precipitation throughout the week, with high temperatures bottoming out at 46°F on Friday.",
        "icon": "clear-day",
        "data": [
            {
                "time": 1546844400,
                "summary": "Windy in the afternoon and partly cloudy starting in the evening.",
                "icon": "wind",
                "sunriseTime": 1546870937,
                "sunsetTime": 1546905147,
                "moonPhase": 0.06,
                "precipIntensity": 0,
                "precipIntensityMax": 0,
                "precipProbability": 0,
                "temperatureHigh": 53.38,
                "temperatureHighTime": 1546894800,
                "temperatureLow": 27.75,
                "temperatureLowTime": 1546956000,
                "apparentTemperatureHigh": 53.38,
                "apparentTemperatureHighTime": 1546894800,
                "apparentTemperatureLow": 22.57,
                "apparentTemperatureLowTime": 1546956000,
                "dewPoint": 13.07,
                "humidity": 0.31,
                "pressure": 1010.98,
                "windSpeed": 3.6,
                "windGust": 42.23,
                "windGustTime": 1546891200,
                "windBearing": 276,
                "cloudCover": 0.12,
                "uvIndex": 2,
                "uvIndexTime": 1546884000,
                "visibility": 10,
                "ozone": 289.68,
                "temperatureMin": 33.75,
                "temperatureMinTime": 1546862400,
                "temperatureMax": 53.38,
                "temperatureMaxTime": 1546894800,
                "apparentTemperatureMin": 29.51,
                "apparentTemperatureMinTime": 1546927200,
                "apparentTemperatureMax": 53.38,
                "apparentTemperatureMaxTime": 1546894800
            },
            {...}
            {
                "time": 1547449200,
                "summary": "Mostly cloudy throughout the day.",
                "icon": "partly-cloudy-night",
                "sunriseTime": 1547475641,
                "sunsetTime": 1547510374,
                "moonPhase": 0.27,
                "precipIntensity": 0,
                "precipIntensityMax": 0.0001,
                "precipIntensityMaxTime": 1547492400,
                "precipProbability": 0,
                "temperatureHigh": 55.84,
                "temperatureHighTime": 1547499600,
                "temperatureLow": 32.83,
                "temperatureLowTime": 1547550000,
                "apparentTemperatureHigh": 55.84,
                "apparentTemperatureHighTime": 1547499600,
                "apparentTemperatureLow": 27.17,
                "apparentTemperatureLowTime": 1547553600,
                "dewPoint": 4.08,
                "humidity": 0.23,
                "pressure": 1020.28,
                "windSpeed": 1.61,
                "windGust": 7.57,
                "windGustTime": 1547452800,
                "windBearing": 222,
                "cloudCover": 0.4,
                "uvIndex": 2,
                "uvIndexTime": 1547488800,
                "visibility": 10,
                "ozone": 269.68,
                "temperatureMin": 27.49,
                "temperatureMinTime": 1547474400,
                "temperatureMax": 55.84,
                "temperatureMaxTime": 1547499600,
                "apparentTemperatureMin": 21.86,
                "apparentTemperatureMinTime": 1547474400,
                "apparentTemperatureMax": 55.84,
                "apparentTemperatureMaxTime": 1547499600
            }
        ]
    },
    "flags": {
        "sources": [
            "nearest-precip",
            "nwspa",
            "cmc",
            "gfs",
            "hrrr",
            "icon",
            "isd",
            "madis",
            "nam",
            "sref",
            "darksky"
        ],
        "nearest-station": 0.837,
        "units": "us"
    },
    "offset": -7
}
  ````

### 2. Account Creation
  #### Verb /Path: POST /api/v1/users
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  # nothing required
  ````
  #### Body:
  ````ruby
  {
    "email" => "whatever@example.com",
    "password" => "password"
    "password_confirmation" => "password"
  }
  ````
  #### Response:
  ````ruby
  {
    "api_key" => "a153e9ea-50af-4355-9072-9a9f2ce70149"
  }
  ````

### 3. Login
  #### Verb /Path: POST /api/v1/sessions
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  location: New York, NY # city, state initials
  ````
  #### Body:
  ````ruby
  # nothing
  ````
  #### Response:
  ````ruby
  # tbd
  ````

### 4. Favoriting Locations
  #### Verb /Path: POST /api/v1/favorites
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  location: New York, NY # city, state initials
  ````
  #### Body:
  ````ruby
  # nothing
  ````
  #### Response:
  ````ruby
  # tbd
  ````

### 5. Listing Favorite Locations
  #### Verb /Path: GET /api/v1/favorites
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  location: New York, NY # city, state initials
  ````
  #### Body:
  ````ruby
  # nothing
  ````
  #### Response:
  ````ruby
  # tbd
  ````

### 6. Removing Favorite Locations
  #### Verb /Path: DELETE /api/v1/favorites
  #### Headers:
  ````ruby
  Content-Type: application/json
  Accept: application/json
  ````
  #### Params:
  ````ruby
  location: New York, NY # city, state initials
  ````
  #### Body:
  ````ruby
  # nothing
  ````
  #### Response:
  ````ruby
  # tbd
  ````
