class Internship {
  final int id;
  final String title;
  final String companyName;
  final List<String> locationNames;
  final bool workFromHome;
  final String startDate;
  final String duration;
  final String stipend;
  final String postedOn;
  final String applicationDeadline;
  final bool isPpo;

  Internship({
    required this.id,
    required this.title,
    required this.companyName,
    required this.locationNames,
    required this.workFromHome,
    required this.startDate,
    required this.duration,
    required this.stipend,
    required this.postedOn,
    required this.applicationDeadline,
    required this.isPpo,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      locationNames: List<String>.from(json['location_names'] ?? []),
      workFromHome: json['work_from_home'] ?? false,
      startDate: json['start_date'] ?? '',
      duration: json['duration'] ?? '',
      stipend: json['stipend']?['salary'] ?? '',
      postedOn: json['posted_on'] ?? '',
      applicationDeadline: json['application_deadline'] ?? '',
      isPpo: json['is_ppo'] ?? false,
    );
  }
}