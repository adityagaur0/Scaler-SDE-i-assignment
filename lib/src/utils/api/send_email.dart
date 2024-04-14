// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class SendEmail {
  Future<void> sendEmail({
    required String student_name,
    required String enrollment_no,
    required String student_email,
    required String total_marks,
    required String viva,
    required String idea,
    required String execution,
    required String mentor_name,
    required String mentor_email,
  }) async {
    try {
      const serviceId = 'service_zorvqlp';
      const templateId = 'template_f4ecujy';
      const userId = 'QSr9ruSju5-OGxwIT';
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

      // Serialize template_params to JSON
      final templateParamsJson = jsonEncode({
        'student_name': student_name,
        'enrollmentNumber': enrollment_no,
        'total_Marks': total_marks,
        'ideation': idea,
        'viva_Marks': viva,
        'execution_marks': execution, // Ensure consistency with EmailJS code
        'mentor_name': mentor_name,
        'student_email': student_email,
        'mentor_email': mentor_email,
      });

      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': templateParamsJson,
        }),
      );
      print(response.body);
    } catch (e) {
      print('Error sending email: $e');
      // Handle the error accordingly, e.g., logging, showing an error message, etc.
    }
  }
}
