import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService  {
  EmailService._initialize() {
    print('EmailService Initialized');
  }
  static final EmailService _instance = EmailService._initialize();

  factory EmailService() => _instance;

  Future<void> sendEmail({
    required String email,
    required String movieTitle,
    required DateTime reservedTime,
    required int reservedCount,
    required DateTime movieRunningTime,
    required String theaterName,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    const serviceId = 'service_3g2lnlb';
    const templateId = 'template_qrtrqcd';
    const userId = 'cXMRyrRZKWuLPRoa0';

    await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'email': email,
            'movie_title': movieTitle,
            'reserved_time': reservedTime.toString().substring(0, 16),
            'reserved_count': reservedCount,
            'movie_running_time': movieRunningTime.toString().substring(0, 16),
            'theater_name':theaterName,
          }
        },
      ),
    );
  }
}
