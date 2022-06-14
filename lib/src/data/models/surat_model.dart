class SuratModel{

  SuratModel._();
  // final String suratName;
  // final String suratId;
  // final String numberOfAyats;
  //
  // SuratModel({required this.suratName,required this.suratId,required this.numberOfAyats});


  static const List<Map<String,String>> surahList = [
    {
      "id": "1",
      "name": "الفاتحة",
      "transliteration": "Al-Fatihah",
      "translation": "The Opener",
      "type": "meccan",
      "total_verses": "7",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/1.json"
    },
    {
      "id": "2",
      "name": "البقرة",
      "transliteration": "Al-Baqarah",
      "translation": "The Cow",
      "type": "medinan",
      "total_verses": "286",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/2.json"
    },
    {
      "id": "3",
      "name": "آل عمران",
      "transliteration": "Ali 'Imran",
      "translation": "Family of Imran",
      "type": "medinan",
      "total_verses": "200",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/3.json"
    },
    {
      "id": "4",
      "name": "النساء",
      "transliteration": "An-Nisa",
      "translation": "The Women",
      "type": "medinan",
      "total_verses": "176",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/4.json"
    },
    {
      "id": "5",
      "name": "المائدة",
      "transliteration": "Al-Ma'idah",
      "translation": "The Table Spread",
      "type": "medinan",
      "total_verses": "120",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/5.json"
    },
    {
      "id": "6",
      "name": "الأنعام",
      "transliteration": "Al-An'am",
      "translation": "The Cattle",
      "type": "meccan",
      "total_verses": "165",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/6.json"
    },
    {
      "id": "7",
      "name": "الأعراف",
      "transliteration": "Al-A'raf",
      "translation": "The Heights",
      "type": "meccan",
      "total_verses": "206",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/7.json"
    },
    {
      "id": "8",
      "name": "الأنفال",
      "transliteration": "Al-Anfal",
      "translation": "The Spoils of War",
      "type": "medinan",
      "total_verses": "75",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/8.json"
    },
    {
      "id": "9",
      "name": "التوبة",
      "transliteration": "At-Tawbah",
      "translation": "The Repentance",
      "type": "medinan",
      "total_verses": "129",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/9.json"
    },
    {
      "id": "10",
      "name": "يونس",
      "transliteration": "Yunus",
      "translation": "Jonah",
      "type": "meccan",
      "total_verses": "109",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/10.json"
    },
    {
      "id": "11",
      "name": "هود",
      "transliteration": "Hud",
      "translation": "Hud",
      "type": "meccan",
      "total_verses": "123",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/11.json"
    },
    {
      "id": "12",
      "name": "يوسف",
      "transliteration": "Yusuf",
      "translation": "Joseph",
      "type": "meccan",
      "total_verses": "111",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/12.json"
    },
    {
      "id": "13",
      "name": "الرعد",
      "transliteration": "Ar-Ra'd",
      "translation": "The Thunder",
      "type": "medinan",
      "total_verses": "43",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/13.json"
    },
    {
      "id": "14",
      "name": "ابراهيم",
      "transliteration": "Ibrahim",
      "translation": "Abraham",
      "type": "meccan",
      "total_verses": "52",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/14.json"
    },
    {
      "id": "15",
      "name": "الحجر",
      "transliteration": "Al-Hijr",
      "translation": "The Rocky Tract",
      "type": "meccan",
      "total_verses": "99",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/15.json"
    },
    {
      "id": "16",
      "name": "النحل",
      "transliteration": "An-Nahl",
      "translation": "The Bee",
      "type": "meccan",
      "total_verses": "128",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/16.json"
    },
    {
      "id": "17",
      "name": "الإسراء",
      "transliteration": "Al-Isra",
      "translation": "The Night Journey",
      "type": "meccan",
      "total_verses": "111",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/17.json"
    },
    {
      "id": "18",
      "name": "الكهف",
      "transliteration": "Al-Kahf",
      "translation": "The Cave",
      "type": "meccan",
      "total_verses": "110",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/18.json"
    },
    {
      "id": "19",
      "name": "مريم",
      "transliteration": "Maryam",
      "translation": "Mary",
      "type": "meccan",
      "total_verses": "98",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/19.json"
    },
    {
      "id": "20",
      "name": "طه",
      "transliteration": "Taha",
      "translation": "Ta-Ha",
      "type": "meccan",
      "total_verses": "135",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/20.json"
    },
    {
      "id": "21",
      "name": "الأنبياء",
      "transliteration": "Al-Anbya",
      "translation": "The Prophets",
      "type": "meccan",
      "total_verses": "112",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/21.json"
    },
    {
      "id": "22",
      "name": "الحج",
      "transliteration": "Al-Hajj",
      "translation": "The Pilgrimage",
      "type": "medinan",
      "total_verses": "78",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/22.json"
    },
    {
      "id": "23",
      "name": "المؤمنون",
      "transliteration": "Al-Mu'minun",
      "translation": "The Believers",
      "type": "meccan",
      "total_verses": "118",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/23.json"
    },
    {
      "id": "24",
      "name": "النور",
      "transliteration": "An-Nur",
      "translation": "The Light",
      "type": "medinan",
      "total_verses": "64",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/24.json"
    },
    {
      "id": "25",
      "name": "الفرقان",
      "transliteration": "Al-Furqan",
      "translation": "The Criterion",
      "type": "meccan",
      "total_verses": "77",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/25.json"
    },
    {
      "id": "26",
      "name": "الشعراء",
      "transliteration": "Ash-Shu'ara",
      "translation": "The Poets",
      "type": "meccan",
      "total_verses": "227",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/26.json"
    },
    {
      "id": "27",
      "name": "النمل",
      "transliteration": "An-Naml",
      "translation": "The Ant",
      "type": "meccan",
      "total_verses": "93",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/27.json"
    },
    {
      "id": "28",
      "name": "القصص",
      "transliteration": "Al-Qasas",
      "translation": "The Stories",
      "type": "meccan",
      "total_verses": "88",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/28.json"
    },
    {
      "id": "29",
      "name": "العنكبوت",
      "transliteration": "Al-'Ankabut",
      "translation": "The Spider",
      "type": "meccan",
      "total_verses": "69",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/29.json"
    },
    {
      "id": "30",
      "name": "الروم",
      "transliteration": "Ar-Rum",
      "translation": "The Romans",
      "type": "meccan",
      "total_verses": "60",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/30.json"
    },
    {
      "id": "31",
      "name": "لقمان",
      "transliteration": "Luqman",
      "translation": "Luqman",
      "type": "meccan",
      "total_verses": "34",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/31.json"
    },
    {
      "id": "32",
      "name": "السجدة",
      "transliteration": "As-Sajdah",
      "translation": "The Prostration",
      "type": "meccan",
      "total_verses": "30",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/32.json"
    },
    {
      "id": "33",
      "name": "الأحزاب",
      "transliteration": "Al-Ahzab",
      "translation": "The Combined Forces",
      "type": "medinan",
      "total_verses": "73",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/33.json"
    },
    {
      "id": "34",
      "name": "سبإ",
      "transliteration": "Saba",
      "translation": "Sheba",
      "type": "meccan",
      "total_verses": "54",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/34.json"
    },
    {
      "id": "35",
      "name": "فاطر",
      "transliteration": "Fatir",
      "translation": "Originator",
      "type": "meccan",
      "total_verses": "45",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/35.json"
    },
    {
      "id": "36",
      "name": "يس",
      "transliteration": "Ya-Sin",
      "translation": "Ya Sin",
      "type": "meccan",
      "total_verses": "83",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/36.json"
    },
    {
      "id": "37",
      "name": "الصافات",
      "transliteration": "As-Saffat",
      "translation": "Those who set the Ranks",
      "type": "meccan",
      "total_verses": "182",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/37.json"
    },
    {
      "id": "38",
      "name": "ص",
      "transliteration": "Sad",
      "translation": "The Letter \"Saad\"",
      "type": "meccan",
      "total_verses": "88",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/38.json"
    },
    {
      "id": "39",
      "name": "الزمر",
      "transliteration": "Az-Zumar",
      "translation": "The Troops",
      "type": "meccan",
      "total_verses": "75",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/39.json"
    },
    {
      "id": "40",
      "name": "غافر",
      "transliteration": "Ghafir",
      "translation": "The Forgiver",
      "type": "meccan",
      "total_verses": "85",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/40.json"
    },
    {
      "id": "41",
      "name": "فصلت",
      "transliteration": "Fussilat",
      "translation": "Explained in Detail",
      "type": "meccan",
      "total_verses": "54",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/41.json"
    },
    {
      "id": "42",
      "name": "الشورى",
      "transliteration": "Ash-Shuraa",
      "translation": "The Consultation",
      "type": "meccan",
      "total_verses": "53",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/42.json"
    },
    {
      "id": "43",
      "name": "الزخرف",
      "transliteration": "Az-Zukhruf",
      "translation": "The Ornaments of Gold",
      "type": "meccan",
      "total_verses": "89",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/43.json"
    },
    {
      "id": "44",
      "name": "الدخان",
      "transliteration": "Ad-Dukhan",
      "translation": "The Smoke",
      "type": "meccan",
      "total_verses": "59",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/44.json"
    },
    {
      "id": "45",
      "name": "الجاثية",
      "transliteration": "Al-Jathiyah",
      "translation": "The Crouching",
      "type": "meccan",
      "total_verses": "37",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/45.json"
    },
    {
      "id": "46",
      "name": "الأحقاف",
      "transliteration": "Al-Ahqaf",
      "translation": "The Wind-Curved Sandhills",
      "type": "meccan",
      "total_verses": "35",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/46.json"
    },
    {
      "id": "47",
      "name": "محمد",
      "transliteration": "Muhammad",
      "translation": "Muhammad",
      "type": "medinan",
      "total_verses": "38",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/47.json"
    },
    {
      "id": "48",
      "name": "الفتح",
      "transliteration": "Al-Fath",
      "translation": "The Victory",
      "type": "medinan",
      "total_verses": "29",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/48.json"
    },
    {
      "id": "49",
      "name": "الحجرات",
      "transliteration": "Al-Hujurat",
      "translation": "The Rooms",
      "type": "medinan",
      "total_verses": "18",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/49.json"
    },
    {
      "id": "50",
      "name": "ق",
      "transliteration": "Qaf",
      "translation": "The Letter \"Qaf\"",
      "type": "meccan",
      "total_verses": "45",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/50.json"
    },
    {
      "id": "51",
      "name": "الذاريات",
      "transliteration": "Adh-Dhariyat",
      "translation": "The Winnowing Winds",
      "type": "meccan",
      "total_verses": "60",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/51.json"
    },
    {
      "id": "52",
      "name": "الطور",
      "transliteration": "At-Tur",
      "translation": "The Mount",
      "type": "meccan",
      "total_verses": "49",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/52.json"
    },
    {
      "id": "53",
      "name": "النجم",
      "transliteration": "An-Najm",
      "translation": "The Star",
      "type": "meccan",
      "total_verses": "62",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/53.json"
    },
    {
      "id": "54",
      "name": "القمر",
      "transliteration": "Al-Qamar",
      "translation": "The Moon",
      "type": "meccan",
      "total_verses": "55",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/54.json"
    },
    {
      "id": "55",
      "name": "الرحمن",
      "transliteration": "Ar-Rahman",
      "translation": "The Beneficent",
      "type": "medinan",
      "total_verses": "78",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/55.json"
    },
    {
      "id": "56",
      "name": "الواقعة",
      "transliteration": "Al-Waqi'ah",
      "translation": "The Inevitable",
      "type": "meccan",
      "total_verses": "96",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/56.json"
    },
    {
      "id": "57",
      "name": "الحديد",
      "transliteration": "Al-Hadid",
      "translation": "The Iron",
      "type": "medinan",
      "total_verses": "29",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/57.json"
    },
    {
      "id": "58",
      "name": "المجادلة",
      "transliteration": "Al-Mujadila",
      "translation": "The Pleading Woman",
      "type": "medinan",
      "total_verses": "22",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/58.json"
    },
    {
      "id": "59",
      "name": "الحشر",
      "transliteration": "Al-Hashr",
      "translation": "The Exile",
      "type": "medinan",
      "total_verses": "24",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/59.json"
    },
    {
      "id": "60",
      "name": "الممتحنة",
      "transliteration": "Al-Mumtahanah",
      "translation": "She that is to be examined",
      "type": "medinan",
      "total_verses": "13",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/60.json"
    },
    {
      "id": "61",
      "name": "الصف",
      "transliteration": "As-Saf",
      "translation": "The Ranks",
      "type": "medinan",
      "total_verses": "14",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/61.json"
    },
    {
      "id": "62",
      "name": "الجمعة",
      "transliteration": "Al-Jumu'ah",
      "translation": "The Congregation, Friday",
      "type": "medinan",
      "total_verses": "11",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/62.json"
    },
    {
      "id": "63",
      "name": "المنافقون",
      "transliteration": "Al-Munafiqun",
      "translation": "The Hypocrites",
      "type": "medinan",
      "total_verses": "11",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/63.json"
    },
    {
      "id": "64",
      "name": "التغابن",
      "transliteration": "At-Taghabun",
      "translation": "The Mutual Disillusion",
      "type": "medinan",
      "total_verses": "18",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/64.json"
    },
    {
      "id": "65",
      "name": "الطلاق",
      "transliteration": "At-Talaq",
      "translation": "The Divorce",
      "type": "medinan",
      "total_verses": "12",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/65.json"
    },
    {
      "id": "66",
      "name": "التحريم",
      "transliteration": "At-Tahrim",
      "translation": "The Prohibition",
      "type": "medinan",
      "total_verses": "12",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/66.json"
    },
    {
      "id": "67",
      "name": "الملك",
      "transliteration": "Al-Mulk",
      "translation": "The Sovereignty",
      "type": "meccan",
      "total_verses": "30",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/67.json"
    },
    {
      "id": "68",
      "name": "القلم",
      "transliteration": "Al-Qalam",
      "translation": "The Pen",
      "type": "meccan",
      "total_verses": "52",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/68.json"
    },
    {
      "id": "69",
      "name": "الحاقة",
      "transliteration": "Al-Haqqah",
      "translation": "The Reality",
      "type": "meccan",
      "total_verses": "52",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/69.json"
    },
    {
      "id": "70",
      "name": "المعارج",
      "transliteration": "Al-Ma'arij",
      "translation": "The Ascending Stairways",
      "type": "meccan",
      "total_verses": "44",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/70.json"
    },
    {
      "id": "71",
      "name": "نوح",
      "transliteration": "Nuh",
      "translation": "Noah",
      "type": "meccan",
      "total_verses": "28",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/71.json"
    },
    {
      "id": "72",
      "name": "الجن",
      "transliteration": "Al-Jinn",
      "translation": "The Jinn",
      "type": "meccan",
      "total_verses": "28",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/72.json"
    },
    {
      "id": "73",
      "name": "المزمل",
      "transliteration": "Al-Muzzammil",
      "translation": "The Enshrouded One",
      "type": "meccan",
      "total_verses": "20",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/73.json"
    },
    {
      "id": "74",
      "name": "المدثر",
      "transliteration": "Al-Muddaththir",
      "translation": "The Cloaked One",
      "type": "meccan",
      "total_verses": "56",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/74.json"
    },
    {
      "id": "75",
      "name": "القيامة",
      "transliteration": "Al-Qiyamah",
      "translation": "The Resurrection",
      "type": "meccan",
      "total_verses": "40",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/75.json"
    },
    {
      "id": "76",
      "name": "الانسان",
      "transliteration": "Al-Insan",
      "translation": "The Man",
      "type": "medinan",
      "total_verses": "31",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/76.json"
    },
    {
      "id": "77",
      "name": "المرسلات",
      "transliteration": "Al-Mursalat",
      "translation": "The Emissaries",
      "type": "meccan",
      "total_verses": "50",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/77.json"
    },
    {
      "id": "78",
      "name": "النبإ",
      "transliteration": "An-Naba",
      "translation": "The Tidings",
      "type": "meccan",
      "total_verses": "40",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/78.json"
    },
    {
      "id": "79",
      "name": "النازعات",
      "transliteration": "An-Nazi'at",
      "translation": "Those who drag forth",
      "type": "meccan",
      "total_verses": "46",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/79.json"
    },
    {
      "id": "80",
      "name": "عبس",
      "transliteration": "'Abasa",
      "translation": "He Frowned",
      "type": "meccan",
      "total_verses": "42",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/80.json"
    },
    {
      "id": "81",
      "name": "التكوير",
      "transliteration": "At-Takwir",
      "translation": "The Overthrowing",
      "type": "meccan",
      "total_verses": "29",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/81.json"
    },
    {
      "id": "82",
      "name": "الإنفطار",
      "transliteration": "Al-Infitar",
      "translation": "The Cleaving",
      "type": "meccan",
      "total_verses": "19",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/82.json"
    },
    {
      "id": "83",
      "name": "المطففين",
      "transliteration": "Al-Mutaffifin",
      "translation": "The Defrauding",
      "type": "meccan",
      "total_verses": "36",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/83.json"
    },
    {
      "id": "84",
      "name": "الإنشقاق",
      "transliteration": "Al-Inshiqaq",
      "translation": "The Sundering",
      "type": "meccan",
      "total_verses": "25",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/84.json"
    },
    {
      "id": "85",
      "name": "البروج",
      "transliteration": "Al-Buruj",
      "translation": "The Mansions of the Stars",
      "type": "meccan",
      "total_verses": "22",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/85.json"
    },
    {
      "id": "86",
      "name": "الطارق",
      "transliteration": "At-Tariq",
      "translation": "The Nightcommer",
      "type": "meccan",
      "total_verses": "17",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/86.json"
    },
    {
      "id": "87",
      "name": "الأعلى",
      "transliteration": "Al-A'la",
      "translation": "The Most High",
      "type": "meccan",
      "total_verses": "19",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/87.json"
    },
    {
      "id": "88",
      "name": "الغاشية",
      "transliteration": "Al-Ghashiyah",
      "translation": "The Overwhelming",
      "type": "meccan",
      "total_verses": "26",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/88.json"
    },
    {
      "id": "89",
      "name": "الفجر",
      "transliteration": "Al-Fajr",
      "translation": "The Dawn",
      "type": "meccan",
      "total_verses": "30",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/89.json"
    },
    {
      "id": "90",
      "name": "البلد",
      "transliteration": "Al-Balad",
      "translation": "The City",
      "type": "meccan",
      "total_verses": "20",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/90.json"
    },
    {
      "id": "91",
      "name": "الشمس",
      "transliteration": "Ash-Shams",
      "translation": "The Sun",
      "type": "meccan",
      "total_verses": "15",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/91.json"
    },
    {
      "id": "92",
      "name": "الليل",
      "transliteration": "Al-Layl",
      "translation": "The Night",
      "type": "meccan",
      "total_verses": "21",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/92.json"
    },
    {
      "id": "93",
      "name": "الضحى",
      "transliteration": "Ad-Duhaa",
      "translation": "The Morning Hours",
      "type": "meccan",
      "total_verses": "11",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/93.json"
    },
    {
      "id": "94",
      "name": "الشرح",
      "transliteration": "Ash-Sharh",
      "translation": "The Relief",
      "type": "meccan",
      "total_verses": "8",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/94.json"
    },
    {
      "id": "95",
      "name": "التين",
      "transliteration": "At-Tin",
      "translation": "The Fig",
      "type": "meccan",
      "total_verses": "8",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/95.json"
    },
    {
      "id": "96",
      "name": "العلق",
      "transliteration": "Al-'Alaq",
      "translation": "The Clot",
      "type": "meccan",
      "total_verses": "19",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/96.json"
    },
    {
      "id": "97",
      "name": "القدر",
      "transliteration": "Al-Qadr",
      "translation": "The Power",
      "type": "meccan",
      "total_verses": "5",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/97.json"
    },
    {
      "id": "98",
      "name": "البينة",
      "transliteration": "Al-Bayyinah",
      "translation": "The Clear Proof",
      "type": "medinan",
      "total_verses": "8",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/98.json"
    },
    {
      "id": "99",
      "name": "الزلزلة",
      "transliteration": "Az-Zalzalah",
      "translation": "The Earthquake",
      "type": "medinan",
      "total_verses": "8",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/99.json"
    },
    {
      "id": "100",
      "name": "العاديات",
      "transliteration": "Al-'Adiyat",
      "translation": "The Courser",
      "type": "meccan",
      "total_verses": "11",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/100.json"
    },
    {
      "id": "101",
      "name": "القارعة",
      "transliteration": "Al-Qari'ah",
      "translation": "The Calamity",
      "type": "meccan",
      "total_verses": "11",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/101.json"
    },
    {
      "id": "102",
      "name": "التكاثر",
      "transliteration": "At-Takathur",
      "translation": "The Rivalry in world increase",
      "type": "meccan",
      "total_verses": "8",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/102.json"
    },
    {
      "id": "103",
      "name": "العصر",
      "transliteration": "Al-'Asr",
      "translation": "The Declining Day",
      "type": "meccan",
      "total_verses": "3",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/103.json"
    },
    {
      "id": "104",
      "name": "الهمزة",
      "transliteration": "Al-Humazah",
      "translation": "The Traducer",
      "type": "meccan",
      "total_verses": "9",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/104.json"
    },
    {
      "id": "105",
      "name": "الفيل",
      "transliteration": "Al-Fil",
      "translation": "The Elephant",
      "type": "meccan",
      "total_verses": "5",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/105.json"
    },
    {
      "id": "106",
      "name": "قريش",
      "transliteration": "Quraysh",
      "translation": "Quraysh",
      "type": "meccan",
      "total_verses": "4",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/106.json"
    },
    {
      "id": "107",
      "name": "الماعون",
      "transliteration": "Al-Ma'un",
      "translation": "The Small kindnesses",
      "type": "meccan",
      "total_verses": "7",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/107.json"
    },
    {
      "id": "108",
      "name": "الكوثر",
      "transliteration": "Al-Kawthar",
      "translation": "The Abundance",
      "type": "meccan",
      "total_verses": "3",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/108.json"
    },
    {
      "id": "109",
      "name": "الكافرون",
      "transliteration": "Al-Kafirun",
      "translation": "The Disbelievers",
      "type": "meccan",
      "total_verses": "6",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/109.json"
    },
    {
      "id": "110",
      "name": "النصر",
      "transliteration": "An-Nasr",
      "translation": "The Divine Support",
      "type": "medinan",
      "total_verses": "3",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/110.json"
    },
    {
      "id": "111",
      "name": "المسد",
      "transliteration": "Al-Masad",
      "translation": "The Palm Fiber",
      "type": "meccan",
      "total_verses": "5",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/111.json"
    },
    {
      "id": "112",
      "name": "الإخلاص",
      "transliteration": "Al-Ikhlas",
      "translation": "The Sincerity",
      "type": "meccan",
      "total_verses": "4",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/112.json"
    },
    {
      "id": "113",
      "name": "الفلق",
      "transliteration": "Al-Falaq",
      "translation": "The Daybreak",
      "type": "meccan",
      "total_verses": "5",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/113.json"
    },
    {
      "id": "114",
      "name": "الناس",
      "transliteration": "An-Nas",
      "translation": "Mankind",
      "type": "meccan",
      "total_verses": "6",
      "link": "https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/chapters/en/114.json"
    }

  ];

}