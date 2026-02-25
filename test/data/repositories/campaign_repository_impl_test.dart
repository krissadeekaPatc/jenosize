import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/data/repositories/campaign_repository_impl.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late CampaignRepositoryImpl repository;
  late MockCampaignRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCampaignRemoteDataSource();
    repository = CampaignRepositoryImpl(mockDataSource);
  });

  group('CampaignRepositoryImpl Unit Tests', () {
    const tCampaigns = [
      Campaign(id: '1', title: 'Campaign 1'),
      Campaign(id: '2', title: 'Campaign 2'),
    ];
    const tCampaignId = '1';
    final tException = Exception('Server Error');

    group('getCampaigns', () {
      test(
        'should return Success with list of campaigns when data source call is successful',
        () async {
          when(
            () => mockDataSource.getCampaigns(),
          ).thenAnswer((_) async => tCampaigns);

          final result = await repository.getCampaigns();

          expect(result, equals(const Success(tCampaigns)));
          verify(() => mockDataSource.getCampaigns()).called(1);
        },
      );

      test(
        'should return Failure when data source call throws an exception',
        () async {
          when(() => mockDataSource.getCampaigns()).thenThrow(tException);

          final result = await repository.getCampaigns();

          expect(result, isA<Failure>());
          verify(() => mockDataSource.getCampaigns()).called(1);
        },
      );
    });

    group('joinCampaign', () {
      test(
        'should return Success(Unit) when join campaign is successful',
        () async {
          when(
            () => mockDataSource.joinCampaign(any()),
          ).thenAnswer((_) async => {});

          final result = await repository.joinCampaign(tCampaignId);

          expect(result, equals(Success(Unit())));
          verify(() => mockDataSource.joinCampaign(tCampaignId)).called(1);
        },
      );

      test(
        'should return Failure when join campaign throws an exception',
        () async {
          when(() => mockDataSource.joinCampaign(any())).thenThrow(tException);

          final result = await repository.joinCampaign(tCampaignId);

          expect(result, isA<Failure>());
          verify(() => mockDataSource.joinCampaign(tCampaignId)).called(1);
        },
      );
    });
  });
}
