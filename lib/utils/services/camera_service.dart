import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:sadamov/model/exception/business_exception.dart';
import 'package:sadamov/utils/secure_logger.dart';

class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> capturePhoto() async {
    try {
      // Solicitar permissão
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        throw BusinessException(
          'Permissão de câmera negada. Por favor, habilite nas configurações.',
        );
      }

      // Capturar foto
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image == null) return null;

      // Converter para bytes
      final file = File(image.path);
      final bytes = await file.readAsBytes();
      
      SecureLogger.debug('Foto capturada: ${bytes.length} bytes');
      return bytes;
    } catch (e) {
      SecureLogger.error('Erro ao capturar foto: ', e);
      rethrow;
    }
  }

  Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }
}

