import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/service_card.dart';

class ServiceList extends StatelessWidget {
  final int sectionIndex;

  const ServiceList(this.sectionIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> services;
    switch (sectionIndex) {
      case 0:
        services = [
          S.of(context).AudioEffects,
          S.of(context).AudiobookRecording,
          S.of(context).Dubbing,
          S.of(context).MusicProduction,
          S.of(context).SoundtrackComposing,
          S.of(context).MusicMixing,
          S.of(context).MusicOrchestration,
          S.of(context).voiceover,
          S.of(context).IVR,
          S.of(context).RadioPodcast,
        ];
        break;
      case 1:
        services = [
          S.of(context).Photography,
          S.of(context).VideoRecording,
          S.of(context).Montage,
          S.of(context).Lighting,
          S.of(context).MotionGraphics,
          S.of(context).TVPrograms,
          S.of(context).GraphicDesigns,
          S.of(context).TVAdvertisements,
          S.of(context).DocumentsAndFilms
        ];
        break;
      case 2:
        services = [
          S.of(context).ScenarioWriting,
          S.of(context).StoryCrafting,
          S.of(context).PoetryAndThoughts,
          S.of(context).Autobiographies,
          S.of(context).AdWriting
        ];
        break;
      case 3:
        services = [
          S.of(context).MusicTitel,
        ];
        break;
      case 4:
        services = [
          S.of(context).Preparation,
          S.of(context).PublicSpeaking,
          S.of(context).Presentation,
          S.of(context).Editing,
          S.of(context).SoundEngineering,
          S.of(context).Directing
        ];
        break;
      default:
        services = [];
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.r,
        crossAxisSpacing: 10.r,
        mainAxisSpacing: 10.r,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceCard(services[index]);
      },
    );
  }
}
