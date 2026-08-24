import 'package:flutter/services.dart';
import 'package:flutter_tencent_faceid/faceid.dart';
import 'package:flutter_tencent_faceid/src/method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FaceVerifyRequest', () {
    test('使用标准 license 并保留后端返回的最优接入域名', () {
      final FaceVerifyRequest request =
          FaceVerifyRequest.fromJson(const <String, dynamic>{
            'appId': 'app-id',
            'faceId': 'face-id',
            'license': 'license',
            'nonce': 'nonce',
            'orderNo': 'order-no',
            'sign': 'sign',
            'userId': 'user-id',
            'version': '1.0.0',
            'optimalDomain': 'kyc.tencentcloudapi.com',
          });

      expect(request.toJson()['optimalDomain'], 'kyc.tencentcloudapi.com');
      expect(request.toJson(), containsPair('license', 'license'));
      expect(request.toJson(), isNot(contains('licence')));
    });
  });

  group('MethodChannelFaceId', () {
    test('仅在原生通道边界转换为 licence', () async {
      final MethodChannelFaceId platform = MethodChannelFaceId();
      Map<Object?, Object?>? arguments;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(platform.methodChannel, (
            MethodCall call,
          ) async {
            arguments = call.arguments as Map<Object?, Object?>?;
            return <String, dynamic>{'isSuccess': true};
          });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(platform.methodChannel, null);
      });

      await platform.verify(
        const FaceVerifyRequest(
          appId: 'app-id',
          faceId: 'face-id',
          license: 'license',
          nonce: 'nonce',
          optimalDomain: 'kyc.tencentcloudapi.com',
          orderNo: 'order-no',
          sign: 'sign',
          userId: 'user-id',
          apiVersion: '1.0.0',
        ),
      );

      expect(arguments, containsPair('licence', 'license'));
      expect(arguments, isNot(contains('license')));
    });
  });

  group('FaceVerifyResult', () {
    test('保留 SDK 的结构化错误信息', () {
      final FaceVerifyResult result =
          FaceVerifyResult.fromJson(const <String, dynamic>{
            'isSuccess': false,
            'sign': '',
            'liveRate': '',
            'similarity': '',
            'errorDomain': 'WBFaceErrorDomainCompareServer',
            'errorCode': '41000',
            'errorDescription': '比对失败',
            'errorReason': '权威库照片不匹配',
          });

      expect(
        result.toJson(),
        containsPair('errorDomain', 'WBFaceErrorDomainCompareServer'),
      );
      expect(result.toJson(), containsPair('errorCode', '41000'));
      expect(result.toJson(), containsPair('errorDescription', '比对失败'));
      expect(result.toJson(), containsPair('errorReason', '权威库照片不匹配'));
    });
  });
}
