import 'package:app_template/app/initializers/dependencies_initializer.dart';
import 'package:app_template/ui/extensions/build_context_extension.dart';
import 'package:app_template/ui/screens/body_age/cubit/body_age_screen_cubit.dart';
import 'package:app_template/ui/screens/body_age/cubit/body_age_screen_state.dart';
import 'package:app_template/ui/styles/app_text_style.dart';
import 'package:app_template/ui/utils/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAgeScreen extends StatelessWidget {
  const BodyAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BodyAgeCubit(getIt()),
      child: const _BodyAgeView(),
    );
  }
}

class _BodyAgeView extends StatelessWidget {
  const _BodyAgeView();

  @override
  Widget build(BuildContext context) {
    final greenColor = context.appColors.positive;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Health & Fitness',
          style: AppTextStyle.w700(20).colorOnSurface(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<BodyAgeCubit, BodyAgeState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            AppAlert.error(context, error: state.error);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // วงกลม Neumorphic ตรงกลาง
              _buildCentralDisplay(context, greenColor, backgroundColor),
              const SizedBox(height: 60),
              // ปุ่ม Sync
              _buildAnalyzeButton(context, greenColor, backgroundColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCentralDisplay(
    BuildContext context,
    Color greenColor,
    Color backgroundColor,
  ) {
    const double circleSize = 240;

    return BlocBuilder<BodyAgeCubit, BodyAgeState>(
      builder: (context, state) {
        final isLoading = state.status.isLoading;

        return Stack(
          alignment: Alignment.center,
          children: [
            // วงกลมพื้นหลัง Neumorphic
            Container(
              width: circleSize,
              height: circleSize,
              decoration: _neumorphicDecoration(
                backgroundColor,
                isCircle: true,
              ),
              alignment: Alignment.center,
              child: _buildCircleContent(context, state, greenColor),
            ),

            // วงแหวน Loading สีเขียว
            if (isLoading)
              SizedBox(
                width: circleSize + 16,
                height: circleSize + 16,
                child: CircularProgressIndicator(
                  color: greenColor,
                  strokeWidth: 4,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCircleContent(
    BuildContext context,
    BodyAgeState state,
    Color greenColor,
  ) {
    if (state.status.isLoading) {
      return Text(
        'Analyzing...',
        style: AppTextStyle.w500(20).copyWith(color: greenColor),
      );
    } else if (state.status.isSuccess && state.bodyAge != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BODY AGE',
            style: AppTextStyle.w600(16).colorOnSurfaceVariant(context),
          ),
          Text(
            '${state.bodyAge}',
            style: AppTextStyle.w900(72).copyWith(
              color: greenColor,
              shadows: [
                Shadow(
                  color: greenColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          Text(
            'YEARS',
            style: AppTextStyle.w600(16).colorOnSurfaceVariant(context),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.monitor_heart_outlined,
            size: 48,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to\nScan',
            textAlign: TextAlign.center,
            style: AppTextStyle.w600(20).colorOnSurfaceVariant(context),
          ),
        ],
      );
    }
  }

  Widget _buildAnalyzeButton(
    BuildContext context,
    Color greenColor,
    Color backgroundColor,
  ) {
    return BlocBuilder<BodyAgeCubit, BodyAgeState>(
      builder: (context, state) {
        final isLoading = state.status.isLoading;

        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  context.read<BodyAgeCubit>().syncAndCalculate(
                    chronologicalAge: 26,
                  );
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: _neumorphicDecoration(backgroundColor, radius: 30),
            child: Text(
              isLoading ? 'PROCESSING...' : 'SYNC HEALTH DATA',
              style: AppTextStyle.w800(16).copyWith(
                color: isLoading
                    ? context.colorScheme.onSurfaceVariant
                    : greenColor,
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _neumorphicDecoration(
    Color color, {
    bool isCircle = false,
    double radius = 20,
  }) {
    return BoxDecoration(
      color: color,
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isCircle ? null : BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6), // เงาดำฝั่งขวาล่าง
          offset: const Offset(8, 8),
          blurRadius: 16,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.04), // แสงตกกระทบจางๆ
          offset: const Offset(-8, -8),
          blurRadius: 16,
        ),
      ],
    );
  }
}
