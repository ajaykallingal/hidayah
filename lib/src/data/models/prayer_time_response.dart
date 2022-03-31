// To parse this JSON data, do
//
//     final prayerTimeResponse = prayerTimeResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PrayerTimeResponse prayerTimeResponseFromJson(String str) => PrayerTimeResponse.fromJson(json.decode(str));

String prayerTimeResponseToJson(PrayerTimeResponse data) => json.encode(data.toJson());

class PrayerTimeResponse {
  PrayerTimeResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final List<Datum>? data;

  factory PrayerTimeResponse.fromJson(Map<String, dynamic> json) => PrayerTimeResponse(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.timings,
    required this.date,
    required this.meta,
  });

  final Timings? timings;
  final Date? date;
  final Meta? meta;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    timings: json["timings"] == null ? null : json["timings"],
    date: json["date"] == null ? null : json["date"],
    meta: json["meta"] == null ? null : json["meta"],
  );

  Map<String, dynamic> toJson() => {
    "timings": timings == null ? null : timings,
    "date": date == null ? null : date,
    "meta": meta == null ? null : meta,
  };
}

class Date {
  Date({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  final String readable;
  final String timestamp;
  final Gregorian gregorian;
  final Hijri hijri;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json["readable"] == null ? null : json["readable"],
    timestamp: json["timestamp"] == null ? null : json["timestamp"],
    gregorian: json["gregorian"] == null ? null : json["gregorian"],
    hijri: json["hijri"] == null ? null : json["hijri"],
  );

  Map<String, dynamic> toJson() => {
    "readable": readable == null ? null : readable,
    "timestamp": timestamp == null ? null : timestamp,
    "gregorian": gregorian == null ? null : gregorian,
    "hijri": hijri == null ? null : hijri,
  };
}

class Gregorian {
  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  final String date;
  final Format format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;
  final Designation designation;

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: json["date"] == null ? null : json["date"],
    format: json["format"] == null ? null : json["format"],
    day: json["day"] == null ? null : json["day"],
    weekday: json["weekday"] == null ? null : json["weekday"],
    month: json["month"] == null ? null : json["month"],
    year: json["year"] == null ? null : json["year"],
    designation: json["designation"] == null ? null : json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "format": format == null ? null : formatValues.reverse[format],
    "day": day == null ? null : day,
    "weekday": weekday == null ? null : weekday,
    "month": month == null ? null : month,
    "year": year == null ? null : year,
    "designation": designation == null ? null : designation,
  };
}

class Designation {
  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  final Abbreviated? abbreviated;
  final Expanded? expanded;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    abbreviated: json["abbreviated"] == null ? null : abbreviatedValues.map![json["abbreviated"]],
    expanded: json["expanded"] == null ? null : expandedValues.map![json["expanded"]],
  );

  Map<String, dynamic> toJson() => {
    "abbreviated": abbreviated == null ? null : abbreviatedValues.reverse[abbreviated],
    "expanded": expanded == null ? null : expandedValues.reverse[expanded],
  };
}

enum Abbreviated { AD, AH }

final abbreviatedValues = EnumValues({
  "AD": Abbreviated.AD,
  "AH": Abbreviated.AH
});

enum Expanded { ANNO_DOMINI, ANNO_HEGIRAE }

final expandedValues = EnumValues({
  "Anno Domini": Expanded.ANNO_DOMINI,
  "Anno Hegirae": Expanded.ANNO_HEGIRAE
});

enum Format { DD_MM_YYYY }

final formatValues = EnumValues({
  "DD-MM-YYYY": Format.DD_MM_YYYY
});

class GregorianMonth {
  GregorianMonth({
    required this.number,
    required this.en,
  });

  final int number;
  final PurpleEn en;

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
    number: json["number"] == null ? null : json["number"],
    en: json["en"] == null ? null : json["en"],
  );

  Map<String, dynamic> toJson() => {
    "number": number == null ? null : number,
    "en": en == null ? null : purpleEnValues.reverse[en],
  };
}

enum PurpleEn { FEBRUARY }

final purpleEnValues = EnumValues({
  "February": PurpleEn.FEBRUARY
});

class GregorianWeekday {
  GregorianWeekday({
    required this.en,
  });

  final String en;

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
    en: json["en"] == null ? null : json["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en == null ? null : en,
  };
}

class Hijri {
  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  final String date;
  final Format format;
  final String day;
  final HijriWeekday weekday;
  final HijriMonth month;
  final String year;
  final Designation designation;
  final List<dynamic> holidays;

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json["date"] == null ? null : json["date"],
    format: json["format"] == null ? null : json["format"],
    day: json["day"] == null ? null : json["day"],
    weekday: json["weekday"] == null ? null : json["weekday"],
    month: json["month"] == null ? null : json["month"],
    year: json["year"] == null ? null : json["year"],
    designation: json["designation"] == null ? null : json["designation"],
    holidays: json["holidays"] == null ? null : json["holidays"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "format": format == null ? null : format,
    "day": day == null ? null : day,
    "weekday": weekday == null ? null : weekday,
    "month": month == null ? null : month,
    "year": year == null ? null : year,
    "designation": designation == null ? null : designation,
    "holidays": holidays == null ? null : List<dynamic>.from(holidays.map((x) => x)),
  };
}

class HijriMonth {
  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
  });

  final int number;
  final FluffyEn en;
  final Ar ar;

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json["number"] == null ? null : json["number"],
    en: json["en"] == null ? null : json["en"],
    ar: json["ar"] == null ? null : json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "number": number == null ? null : number,
    "en": en == null ? null : fluffyEnValues.reverse[en],
    "ar": ar == null ? null : arValues.reverse[ar],
  };
}

enum Ar { EMPTY, AR }

final arValues = EnumValues({
  "رَجَب": Ar.AR,
  "جُمادى الآخرة": Ar.EMPTY
});

enum FluffyEn { JUMD_AL_KHIRAH, RAJAB }

final fluffyEnValues = EnumValues({
  "Jumādá al-ākhirah": FluffyEn.JUMD_AL_KHIRAH,
  "Rajab": FluffyEn.RAJAB
});

class HijriWeekday {
  HijriWeekday({
    required this.en,
    required this.ar,
  });

  final String en;
  final String ar;

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
    en: json["en"] == null ? null : json["en"],
    ar: json["ar"] == null ? null : json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en == null ? null : en,
    "ar": ar == null ? null : ar,
  };
}

class Meta {
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  final double latitude;
  final double longitude;
  final Timezone timezone;
  final Method method;
  final LatitudeAdjustmentMethod latitudeAdjustmentMethod;
  final MidnightMode midnightMode;
  final MidnightMode school;
  final Map<String, int> offset;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    timezone: json["timezone"] == null ? null : json["timezone"],
    method: json["method"] == null ? null : json["method"],
    latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"] == null ? null : json["latitudeAdjustmentMethod"],
    midnightMode: json["midnightMode"] == null ? null : json["midnightMode"],
    school: json["school"] == null ? null : json["school"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "timezone": timezone == null ? null : timezone,
    "method": method == null ? null : method,
    "latitudeAdjustmentMethod": latitudeAdjustmentMethod == null ? null : latitudeAdjustmentMethod,
    "midnightMode": midnightMode == null ? null : midnightMode,
    "school": school == null ? null : school,
    "offset": offset == null ? null : Map.from(offset).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

enum LatitudeAdjustmentMethod { ANGLE_BASED }

final latitudeAdjustmentMethodValues = EnumValues({
  "ANGLE_BASED": LatitudeAdjustmentMethod.ANGLE_BASED
});

class Method {
  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  final int? id;
  final Name? name;
  final Params? params;
  final Location? location;

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    params: json["params"] == null ? null : json["params"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "params": params == null ? null : params,
    "location": location == null ? null : location,
  };
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}

enum Name { UNIVERSITY_OF_ISLAMIC_SCIENCES_KARACHI }

final nameValues = EnumValues({
  "University of Islamic Sciences, Karachi": Name.UNIVERSITY_OF_ISLAMIC_SCIENCES_KARACHI
});

class Params {
  Params({
    required this.fajr,
    required this.isha,
  });

  final int fajr;
  final int isha;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    fajr: json["Fajr"] == null ? null : json["Fajr"],
    isha: json["Isha"] == null ? null : json["Isha"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr == null ? null : fajr,
    "Isha": isha == null ? null : isha,
  };
}

enum MidnightMode { STANDARD }

final midnightModeValues = EnumValues({
  "STANDARD": MidnightMode.STANDARD
});

enum Timezone { ASIA_KOLKATA }

final timezoneValues = EnumValues({
  "Asia/Kolkata": Timezone.ASIA_KOLKATA
});

class Timings {
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  final String fajr;
  final String sunrise;
  final Dhuhr dhuhr;
  final Asr asr;
  final String sunset;
  final String maghrib;
  final Isha isha;
  final String imsak;
  final Midnight midnight;

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json["Fajr"] == null ? null : json["Fajr"],
    sunrise: json["Sunrise"] == null ? null : json["Sunrise"],
    dhuhr: json["Dhuhr"] == null ? null : json["Dhuhr"],
    asr: json["Asr"] == null ? null : json["Asr"],
    sunset: json["Sunset"] == null ? null : json["Sunset"],
    maghrib: json["Maghrib"] == null ? null : json["Maghrib"],
    isha: json["Isha"] == null ? null : json["Isha"],
    imsak: json["Imsak"] == null ? null : json["Imsak"],
    midnight: json["Midnight"] == null ? null : json["Midnight"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr == null ? null : fajr,
    "Sunrise": sunrise == null ? null : sunrise,
    "Dhuhr": dhuhr == null ? null : dhuhrValues.reverse[dhuhr],
    "Asr": asr == null ? null : asrValues.reverse[asr],
    "Sunset": sunset == null ? null : sunset,
    "Maghrib": maghrib == null ? null : maghrib,
    "Isha": isha == null ? null : ishaValues.reverse[isha],
    "Imsak": imsak == null ? null : imsak,
    "Midnight": midnight == null ? null : midnightValues.reverse[midnight],
  };
}

enum Asr { THE_1559_IST, THE_1558_IST, THE_1557_IST }

final asrValues = EnumValues({
  "15:57 (IST)": Asr.THE_1557_IST,
  "15:58 (IST)": Asr.THE_1558_IST,
  "15:59 (IST)": Asr.THE_1559_IST
});

enum Dhuhr { THE_1238_IST, THE_1239_IST, THE_1237_IST }

final dhuhrValues = EnumValues({
  "12:37 (IST)": Dhuhr.THE_1237_IST,
  "12:38 (IST)": Dhuhr.THE_1238_IST,
  "12:39 (IST)": Dhuhr.THE_1239_IST
});

enum Isha { THE_1942_IST, THE_1943_IST, THE_1944_IST, THE_1945_IST }

final ishaValues = EnumValues({
  "19:42 (IST)": Isha.THE_1942_IST,
  "19:43 (IST)": Isha.THE_1943_IST,
  "19:44 (IST)": Isha.THE_1944_IST,
  "19:45 (IST)": Isha.THE_1945_IST
});

enum Midnight { THE_0038_IST, THE_0039_IST, THE_0037_IST }

final midnightValues = EnumValues({
  "00:37 (IST)": Midnight.THE_0037_IST,
  "00:38 (IST)": Midnight.THE_0038_IST,
  "00:39 (IST)": Midnight.THE_0039_IST
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
