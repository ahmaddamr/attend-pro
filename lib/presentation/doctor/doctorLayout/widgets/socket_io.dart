import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectAndJoinSession(
    String groupId,
    Function(dynamic data) onStudentCheckIn,
    Function(dynamic data) onStudentCheckOut,
  ) {
    socket = IO.io(
      'https://attend-pro.onrender.com',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'reconnection': true,
        'reconnectionAttempts': 5,
        'reconnectionDelay': 1000,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      log('✅ Connected to Socket.IO server');
      socket.emit('join-session', groupId);

      // ✅ Listen for student check-in
      socket.on('student-check-in', (data) {
        log('🎯 Student Checked In: $data');
        onStudentCheckIn(data);
      });

      // ✅ Listen for student check-out
      socket.on('student-check-out', (data) {
        log('🔁 Student Checked Out: $data');
        onStudentCheckOut(data);
      });
    });

    socket.onDisconnect((_) {
      log('❌ Disconnected from socket');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
