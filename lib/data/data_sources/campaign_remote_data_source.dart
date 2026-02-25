import 'package:jenosize/data/models/campaign.dart';

class CampaignRemoteDataSource {
  Future<List<Campaign>> getCampaigns() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return const [
      Campaign(
        id: 'c1',
        title: 'Summer Coffee Fiesta',
        description: 'Buy 1 Get 1 Free on all iced beverages.',
        imageUrl:
            'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&q=80&w=800',
        pointsReward: 50,
      ),
      Campaign(
        id: 'c2',
        title: 'Refer a Friend Bonus',
        description: 'Invite your friends and earn massive points.',
        imageUrl:
            'https://images.unsplash.com/photo-1528605248644-14dd04022da1?auto=format&fit=crop&q=80&w=800',
        pointsReward: 100,
      ),
      Campaign(
        id: 'c3',
        title: 'Weekend Bakery Treat',
        description: '20% off all pastries this weekend.',
        imageUrl:
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&q=80&w=800',
        pointsReward: 30,
      ),
      Campaign(
        id: 'c4',
        title: 'Double Points Tuesday',
        description: 'Earn double points on all your purchases today.',
        imageUrl:
            'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&q=80&w=800',
        pointsReward: 20,
      ),
      Campaign(
        id: 'c5',
        title: 'Healthy Salad Bowl',
        description: 'Buy 2 salad bowls and get a free detox smoothie.',
        imageUrl:
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&q=80&w=800',
        pointsReward: 40,
      ),
      Campaign(
        id: 'c6',
        title: 'Tech Gadget Upgrade',
        description: 'Get an exclusive 10% discount on wireless headphones.',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800',
        pointsReward: 150,
      ),
      Campaign(
        id: 'c7',
        title: 'Midnight Movie Madness',
        description:
            'Claim a free large popcorn with any midnight movie ticket.',
        imageUrl:
            'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&q=80&w=800',
        pointsReward: 25,
      ),
      Campaign(
        id: 'c8',
        title: 'Gym Warrior Challenge',
        description:
            'Check-in at the gym 5 times this week to unlock this badge.',
        imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=800',
        pointsReward: 200,
      ),
      Campaign(
        id: 'c9',
        title: 'Eco-Friendly Shopper',
        description: 'Bring your own reusable bag and get instant points.',
        imageUrl:
            'https://images.unsplash.com/photo-1611288875783-c0d16c747cf3?auto=format&fit=crop&q=80&w=800',
        pointsReward: 15,
      ),
      Campaign(
        id: 'c10',
        title: 'Birthday Month Surprise',
        description: 'Celebrate your birthday month with a massive point drop!',
        imageUrl:
            'https://images.unsplash.com/photo-1558636508-e0db3814bd1d?auto=format&fit=crop&q=80&w=800',
        pointsReward: 500,
      ),
    ];
  }

  Future<void> joinCampaign(String campaignId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
