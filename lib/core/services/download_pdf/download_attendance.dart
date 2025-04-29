import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceRepository {
  final Dio _dio = Dio();

  Future<File?> downloadWeeklyAttendance({
    required String groupId,
    required int week,
  }) async {
    try {
      // 1. تجهيز رابط الـ API
      final url =
          'https://attend-pro.onrender.com/attendance/group/$groupId/download?week=$week';

      // 2. تجهيز مكان تخزين الملف مؤقتاً
      final Directory tempDir = await getTemporaryDirectory();
      final prefs = await SharedPreferences.getInstance();
      final String savePath =
          '${tempDir.path}/attendance_report_week_$week.pdf';

      // 3. تنفيذ الـ request وتحميل الـ pdf
      Response response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'accessToken': 'accesstoken_${prefs.getString('token')}',
          },
        ),
      );

      // 4. كتابة البيانات إلى ملف
      final File file = File(savePath);
      await file.writeAsBytes(response.data);

      // 5. رجع الملف
      return file;
    } catch (e) {
      print('Error downloading PDF: $e');
      return null;
    }
  }

  Future<void> openPdfFile(File file) async {
    await OpenFile.open(file.path);
  }
}
