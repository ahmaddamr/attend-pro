import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectAndJoinSession(
      String groupId, Function(dynamic data) onStudentCheckIn) {
    socket = IO.io(
      'https://attend-pro.onrender.com', // No http://https://!
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
      socket.emit('join-session', groupId); // ✅ Room name must match backend

      socket.on('student-check-in', (data) {
        log('🎯 Student Checked In: $data');
        onStudentCheckIn(data); // Pass data back to screen
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
