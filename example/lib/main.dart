import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tencent_faceid/faceid.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FaceIdExamplePage());
  }
}

class FaceIdExamplePage extends StatefulWidget {
  const FaceIdExamplePage({super.key});

  @override
  State<FaceIdExamplePage> createState() => _FaceIdExamplePageState();
}

class _FaceIdExamplePageState extends State<FaceIdExamplePage> {
  static const _encoder = JsonEncoder.withIndent('  ');

  final _faceId = TencentFaceId();
  final _ocrParamsController = TextEditingController();
  final _faceParamsController = TextEditingController();

  String _output = '请粘贴后端为本次请求生成的临时参数。';
  bool _busy = false;

  @override
  void dispose() {
    _ocrParamsController.dispose();
    _faceParamsController.dispose();
    super.dispose();
  }

  Future<void> _runOcr() async {
    await _run(() async {
      final params = _decodeParams(_ocrParamsController.text);
      final result = await _faceId.ocr(OcrRequest.fromJson(params));
      if (result == null) {
        return 'OCR 未返回结果。';
      }

      final output = result.toJson();
      output['frontCrop'] = _describeImage(result.frontCrop);
      output['backCrop'] = _describeImage(result.backCrop);
      return _encoder.convert(output);
    });
  }

  Future<void> _runFace() async {
    await _run(() async {
      final params = _decodeParams(_faceParamsController.text);
      final result = await _faceId.verify(FaceVerifyRequest.fromJson(params));
      return result == null ? '人脸核验未返回结果。' : _encoder.convert(result.toJson());
    });
  }

  Future<void> _run(Future<String> Function() operation) async {
    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      _showMessage('请先授予相机权限。');
      return;
    }

    setState(() {
      _busy = true;
    });

    try {
      final output = await operation();
      if (mounted) {
        setState(() {
          _output = output;
        });
      }
    } on FormatException catch (error) {
      _showMessage('参数 JSON 格式错误：${error.message}');
    } catch (error) {
      _showMessage('调用失败：$error');
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
        });
      }
    }
  }

  Map<String, dynamic> _decodeParams(String source) {
    if (source.trim().isEmpty) {
      throw const FormatException('请先粘贴后端返回的参数');
    }

    final value = jsonDecode(source);
    if (value is! Map<String, dynamic>) {
      throw const FormatException('顶层必须是 JSON 对象');
    }
    return value;
  }

  String? _describeImage(String? value) {
    return value == null ? null : '<base64: ${value.length} chars>';
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter_tencent_faceid')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '签名、nonce、orderNo 等参数必须由业务后端按腾讯云规则临时生成，'
            '不要将密钥或长期凭据写入客户端。',
          ),
          const SizedBox(height: 16),
          _ParamsField(controller: _ocrParamsController, label: 'OCR 参数 JSON'),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _busy ? null : _runOcr,
            child: const Text('调起身份证 OCR'),
          ),
          const SizedBox(height: 24),
          _ParamsField(controller: _faceParamsController, label: '人脸核验参数 JSON'),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _busy ? null : _runFace,
            child: const Text('调起活体人脸核验'),
          ),
          const SizedBox(height: 24),
          const Text('调用结果'),
          const SizedBox(height: 8),
          SelectableText(_output),
        ],
      ),
    );
  }
}

class _ParamsField extends StatelessWidget {
  const _ParamsField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 5,
      maxLines: 10,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        alignLabelWithHint: true,
      ),
    );
  }
}
