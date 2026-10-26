import 'package:flutter/material.dart';

class StatItem {
  final String value;
  final String label;
  final IconData icon;

  const StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class PerformanceSet {
  final String title;
  final String description;
  final String imageUrl;
  final String tag;
  final bool isAsset;

  const PerformanceSet({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tag,
    this.isAsset = false,
  });
}

class GalleryItem {
  final String title;
  final String imageUrl;
  final String category;
  final bool isTall;
  final bool isAsset;

  const GalleryItem({
    required this.title,
    required this.imageUrl,
    required this.category,
    this.isTall = false,
    this.isAsset = false,
  });
}

class EventItem {
  final String day;
  final String month;
  final String title;
  final String venue;
  final String location;

  const EventItem({
    required this.day,
    required this.month,
    required this.title,
    required this.venue,
    required this.location,
  });
}

class VideoItem {
  final String title;
  final String assetPath;
  final String description;
  final String duration;
  final String category;

  const VideoItem({
    required this.title,
    required this.assetPath,
    required this.description,
    required this.duration,
    required this.category,
  });
}

class TestimonialItem {
  final String quote;
  final String author;
  final String role;
  final int rating;

  const TestimonialItem({
    required this.quote,
    required this.author,
    required this.role,
    this.rating = 5,
  });
}

class BaluSaxData {
  // Artist Branding
  static const String artistName = "Balu";
  static const String surname = "Saxophonist";
  static const String fullName = "Balu Saxophonist";
  static const String legalName = "Bala Raju Ipparthi";
  static const String heroEyebrow = "— Professional Alto Saxophonist —";
  static const String motto = "SAXOPHONE. SOUL. STORIES.";
  static const String tagline =
      "Experience the magic of live saxophone with Balu — a professional saxophonist bringing timeless melodies, soulful expressions, and electrifying energy to every stage.\n\nFrom romantic classics to high-energy live performances, every note is crafted to create an unforgettable musical experience.\n\nMaking your special moments sound extraordinary.";

  // About Narrative
  static const String aboutEyebrow = "— About the Artist —";
  static const String aboutHeadline = "A Soulful Sound. An Unforgettable Experience.";
  static const String aboutNarrative =
      "Balu Saxophonist (Bala Raju Ipparthi) brings music to life through captivating saxophone performances that blend soulful romantic melodies with vibrant live music. With over 6+ years of stage experience, 150+ live shows, and 100+ clients across Hyd, Vizag & Mumbai, Balu creates memorable musical moments that connect with audiences and elevate every celebration.\n\nFrom elegant wedding ceremonies and receptions to birthdays, private parties, and corporate events, each performance combines expressive melodies, engaging stage presence, and a passion for live music.";

  // Contact & Socials
  static const String phone = "+91 99490 08126";
  static const String phoneDisplay = "9949008126";
  static const String phoneDigits = "919949008126";
  static const String email = "balarajuipparthi1234@gmail.com";
  static const String location = "Hyd, Vizag, Mumbai, India";
  static const String availability = "Available across Hyd, Vizag & Mumbai";

  static const String instagramUrl = "https://www.instagram.com/balu_music_vibes_?mdxt=NjZ6ZjNjOG5nbG04";
  static const String instagramHandle = "@balu_music_vibes_";

  // Performance Highlights / Repertoire Bullets
  static const List<String> repertoireHighlights = [
    "✦ Professional Alto Saxophone Performances",
    "✦ Soulful Romantic Melodies",
    "✦ Energetic & Popular Stage Hits",
    "✦ Weddings, Receptions & Private Celebrations",
    "✦ Corporate Events & Live Stage Shows",
  ];

  // Key Statistics
  static const List<StatItem> stats = [
    StatItem(
      value: "6+",
      label: "Years Experience",
      icon: Icons.workspace_premium_outlined,
    ),
    StatItem(
      value: "150+",
      label: "Shows Completed",
      icon: Icons.music_note_rounded,
    ),
    StatItem(
      value: "100+",
      label: "Clients",
      icon: Icons.favorite_border_rounded,
    ),
    StatItem(
      value: "20+",
      label: "Cities",
      icon: Icons.public_rounded,
    ),
  ];

  // Assets
  static const String suitPortraitAsset = "assets/images/balu_suit_portrait.jpg";
  static const String circleWhiteAsset = "assets/images/balu_circle_white.jpg";
  static const String livePerformancesAsset = "assets/images/balu_live_performances.jpg";
  static const String eventGroupAsset = "assets/images/balu_event_group.jpg";

  // Signature Sets / Music
  static const List<PerformanceSet> signatureSets = [
    PerformanceSet(
      title: "Soulful Romantic Melodies",
      description:
          "Timeless romantic classics and soulful saxophone melodies for ceremonies, grand receptions, cocktail hours, and first dances.",
      imageUrl: eventGroupAsset,
      tag: "Weddings & Receptions",
      isAsset: true,
    ),
    PerformanceSet(
      title: "High Energy & Stage Hits",
      description:
          "Electrifying popular hits, upbeat melodies, and crowd-favorite anthems performed live with dynamic crowd engagement.",
      imageUrl: circleWhiteAsset,
      tag: "High Energy Stage",
      isAsset: true,
    ),
    PerformanceSet(
      title: "Live Concerts & Corporate Galas",
      description:
          "Full stage presence featuring live band orchestration, keyboard coordination, and an expansive instrumental repertoire.",
      imageUrl: livePerformancesAsset,
      tag: "Galas & Festivals",
      isAsset: true,
    ),
  ];

  // Gallery
  static const List<GalleryItem> gallery = [
    GalleryItem(
      title: "Balu Saxophonist - Live Stage",
      category: "Concerts & Fests",
      imageUrl: livePerformancesAsset,
      isTall: true,
      isAsset: true,
    ),
    GalleryItem(
      title: "Saxophone. Soul. Stories.",
      category: "Signature Portrait",
      imageUrl: suitPortraitAsset,
      isAsset: true,
    ),
    GalleryItem(
      title: "Spotlight Alto Performance",
      category: "Acoustic Solo",
      imageUrl: circleWhiteAsset,
      isAsset: true,
    ),
    GalleryItem(
      title: "Romantic Wedding Elegance",
      category: "Weddings",
      imageUrl: "https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=800&q=80",
    ),
    GalleryItem(
      title: "Alto Saxophone Resonance",
      category: "Repertoire",
      imageUrl: "https://images.unsplash.com/photo-1525994886773-080587e161c2?w=800&q=80",
      isTall: true,
    ),
    GalleryItem(
      title: "Grand Evening Celebration",
      category: "Corporate Gala",
      imageUrl: "https://images.unsplash.com/photo-1465847899084-d164df4dedc6?w=800&q=80",
    ),
  ];

  // Upcoming Events
  static const List<EventItem> upcomingEvents = [
    EventItem(
      day: "18",
      month: "NOV",
      title: "Grand Wedding Symphony",
      venue: "Taj Krishna",
      location: "Hyderabad, IN",
    ),
    EventItem(
      day: "04",
      month: "DEC",
      title: "Grand Musical Gala Night",
      venue: "ITC Gardenia",
      location: "Bengaluru, IN",
    ),
    EventItem(
      day: "22",
      month: "DEC",
      title: "Royal Palace Wedding Gala",
      venue: "Umaid Bhawan",
      location: "Rajasthan, IN",
    ),
    EventItem(
      day: "10",
      month: "JAN",
      title: "Corporate Annual Excellence Night",
      venue: "HICC Novotel",
      location: "Hyderabad, IN",
    ),
  ];

  // Video Performances (Assets from assets/videos)
  static const List<VideoItem> videos = [
    VideoItem(
      title: "Soulful Live Saxophone Performance",
      assetPath: "assets/videos/balu_video_1.mp4",
      description: "Mesmerizing live stage recording featuring soulful acoustic saxophone melodies and romantic tunes.",
      duration: "Live Performance",
      category: "Romantic Melodies",
    ),
    VideoItem(
      title: "Vibrant Stage Melodies & Live Energy",
      assetPath: "assets/videos/balu_video_2.mp4",
      description: "Energetic alto saxophone performance captivating the audience with uplifting live rhythms.",
      duration: "Concert Set",
      category: "Stage Hits",
    ),
    VideoItem(
      title: "Acoustic Solo & Melodic Improvisation",
      assetPath: "assets/videos/balu_video_3.mp4",
      description: "Signature live saxophone improvisation and crowd-favorite instrumental brilliance.",
      duration: "Solo Session",
      category: "Live Instrumental",
    ),
  ];

  // Testimonials & Audience Reviews (3 English, 1 Natural Telugu)
  static const List<TestimonialItem> testimonials = [
    TestimonialItem(
      quote:
          "Balu's saxophone performance made our wedding reception so special! The romantic tunes created the perfect vibe, and all our guests kept asking about him.",
      author: "Kalyan & Divya",
      role: "Wedding Clients (Hyderabad)",
    ),
    TestimonialItem(
      quote:
          "మా వెడ్డింగ్ రిసెప్షన్ కి బాలు గారిని బుక్ చేసుకున్నాం, చాలా బాగా ప్లే చేశారు. ముఖ్యంగా పాత, కొత్త తెలుగు మెలోడీస్ సాక్సోఫోన్ లో వింటుంటే చాలా బాగుంది. ఫ్యామిలీ, ఫ్రెండ్స్ అందరికీ బాగా నచ్చింది!",
      author: "రాజేష్ వర్మ (Rajesh Varma)",
      role: "Wedding Client (Vizag)",
    ),
    TestimonialItem(
      quote:
          "The most soulful saxophone artist we have hosted on our grand stage. Exceptional professionalism, pristine sound, and true musical depth.",
      author: "Novotel Hotels & Resorts",
      role: "Hospitality Partner (Hyderabad)",
    ),
    TestimonialItem(
      quote:
          "Balu brings an incredible vibe to live events. From soft romantic notes to energetic crowd-favorite hits, he knows exactly how to keep the audience hooked.",
      author: "Siddharth Rao",
      role: "Event Director, Milestone Events (Mumbai)",
    ),
  ];
}
