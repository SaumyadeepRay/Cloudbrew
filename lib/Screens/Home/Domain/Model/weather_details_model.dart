import 'dart:convert';

WeatherDetailsModel weatherDetailsModelFromJson(String str) =>
    WeatherDetailsModel.fromJson(json.decode(str));

String weatherDetailsModelToJson(WeatherDetailsModel data) =>
    json.encode(data.toJson());

class WeatherDetailsModel {
  Request request;
  Location location;
  Current current;

  WeatherDetailsModel({
    required this.request,
    required this.location,
    required this.current,
  });

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) =>
      WeatherDetailsModel(
        request: Request.fromJson(json["request"]),
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "request": request.toJson(),
        "location": location.toJson(),
        "current": current.toJson(),
      };

  // Added this factory for a default initial state
  factory WeatherDetailsModel.empty() {
    return WeatherDetailsModel(
      request: Request(
        type: '',
        query: '',
        language: '',
        unit: '',
      ),
      location: Location(
        name: '',
        country: '',
        region: '',
        lat: '',
        lon: '',
        timezoneId: '',
        localtime: '',
        localtimeEpoch: 0,
        utcOffset: '',
      ),
      current: Current(
        observationTime: '',
        temperature: 0,
        weatherCode: 0,
        weatherIcons: [],
        weatherDescriptions: [],
        astro: Astro(
          sunrise: '',
          sunset: '',
          moonrise: '',
          moonset: '',
          moonPhase: '',
          moonIllumination: 0,
        ),
        airQuality: AirQuality(
          co: '',
          no2: '',
          o3: '',
          so2: '',
          pm25: '',
          pm10: '',
          usEpaIndex: '',
          gbDefraIndex: '',
        ),
        windSpeed: 0,
        windDegree: 0,
        windDir: '',
        pressure: 0,
        precip: 0,
        humidity: 0,
        cloudcover: 0,
        feelslike: 0,
        uvIndex: 0,
        visibility: 0,
        isDay: '',
      ),
    );
  }
}

class Current {
  String observationTime;
  int temperature;
  int weatherCode;
  List<String> weatherIcons;
  List<String> weatherDescriptions;
  Astro astro;
  AirQuality airQuality;
  int windSpeed;
  int windDegree;
  String windDir;
  int pressure;
  int precip;
  int humidity;
  int cloudcover;
  int feelslike;
  int uvIndex;
  int visibility;
  String isDay;

  Current({
    required this.observationTime,
    required this.temperature,
    required this.weatherCode,
    required this.weatherIcons,
    required this.weatherDescriptions,
    required this.astro,
    required this.airQuality,
    required this.windSpeed,
    required this.windDegree,
    required this.windDir,
    required this.pressure,
    required this.precip,
    required this.humidity,
    required this.cloudcover,
    required this.feelslike,
    required this.uvIndex,
    required this.visibility,
    required this.isDay,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        observationTime: json["observation_time"],
        temperature: json["temperature"],
        weatherCode: json["weather_code"],
        weatherIcons: List<String>.from(json["weather_icons"].map((x) => x)),
        weatherDescriptions:
            List<String>.from(json["weather_descriptions"].map((x) => x)),
        astro: Astro.fromJson(json["astro"]),
        airQuality: AirQuality.fromJson(json["air_quality"]),
        windSpeed: json["wind_speed"],
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressure: json["pressure"],
        precip: json["precip"],
        humidity: json["humidity"],
        cloudcover: json["cloudcover"],
        feelslike: json["feelslike"],
        uvIndex: json["uv_index"],
        visibility: json["visibility"],
        isDay: json["is_day"],
      );

  Map<String, dynamic> toJson() => {
        "observation_time": observationTime,
        "temperature": temperature,
        "weather_code": weatherCode,
        "weather_icons": List<dynamic>.from(weatherIcons.map((x) => x)),
        "weather_descriptions":
            List<dynamic>.from(weatherDescriptions.map((x) => x)),
        "astro": astro.toJson(),
        "air_quality": airQuality.toJson(),
        "wind_speed": windSpeed,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure": pressure,
        "precip": precip,
        "humidity": humidity,
        "cloudcover": cloudcover,
        "feelslike": feelslike,
        "uv_index": uvIndex,
        "visibility": visibility,
        "is_day": isDay,
      };
}

class AirQuality {
  String co;
  String no2;
  String o3;
  String so2;
  String pm25;
  String pm10;
  String usEpaIndex;
  String gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
        co: json["co"],
        no2: json["no2"],
        o3: json["o3"],
        so2: json["so2"],
        pm25: json["pm2_5"],
        pm10: json["pm10"],
        usEpaIndex: json["us-epa-index"],
        gbDefraIndex: json["gb-defra-index"],
      );

  Map<String, dynamic> toJson() => {
        "co": co,
        "no2": no2,
        "o3": o3,
        "so2": so2,
        "pm2_5": pm25,
        "pm10": pm10,
        "us-epa-index": usEpaIndex,
        "gb-defra-index": gbDefraIndex,
      };
}

class Astro {
  String sunrise;
  String sunset;
  String moonrise;
  String moonset;
  String moonPhase;
  int moonIllumination;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        moonIllumination: json["moon_illumination"],
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "moon_illumination": moonIllumination,
      };
}

class Location {
  String name;
  String country;
  String region;
  String lat;
  String lon;
  String timezoneId;
  String localtime;
  int localtimeEpoch;
  String utcOffset;

  Location({
    required this.name,
    required this.country,
    required this.region,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localtime,
    required this.localtimeEpoch,
    required this.utcOffset,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        country: json["country"],
        region: json["region"],
        lat: json["lat"],
        lon: json["lon"],
        timezoneId: json["timezone_id"],
        localtime: json["localtime"],
        localtimeEpoch: json["localtime_epoch"],
        utcOffset: json["utc_offset"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "region": region,
        "lat": lat,
        "lon": lon,
        "timezone_id": timezoneId,
        "localtime": localtime,
        "localtime_epoch": localtimeEpoch,
        "utc_offset": utcOffset,
      };
}

class Request {
  String type;
  String query;
  String language;
  String unit;

  Request({
    required this.type,
    required this.query,
    required this.language,
    required this.unit,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        type: json["type"],
        query: json["query"],
        language: json["language"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": query,
        "language": language,
        "unit": unit,
      };
}
