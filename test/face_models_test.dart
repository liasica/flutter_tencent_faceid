import 'package:flutter_tencent_faceid/faceid.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FaceVerifyRequest', () {
    test('保留后端返回的最优接入域名', () {
      final FaceVerifyRequest request =
          FaceVerifyRequest.fromJson(const <String, dynamic>{
            'appId': 'app-id',
            'faceId': 'face-id',
            'licence': 'licence',
            'nonce': 'nonce',
            'orderNo': 'order-no',
            'sign': 'sign',
            'userId': 'user-id',
            'version': '1.0.0',
            'optimalDomain': 'kyc.tencentcloudapi.com',
          });

      expect(request.toJson()['optimalDomain'], 'kyc.tencentcloudapi.com');
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
