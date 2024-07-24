import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/section_form.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SectionTabs extends StatelessWidget {
  const SectionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Gap(10),
          SectionForm(
              title: S.of(context).homeAudio,
              isSelected: provider.selectedSectionIndex == 0,
              onTap: () {
                provider.showLoading();
                provider.updateSelectedSection(0, S.of(context).homeAudio);
              }),
          const Gap(10),
          SectionForm(
            title: S.of(context).homeVideo,
            isSelected: provider.selectedSectionIndex == 1,
            onTap: () =>
                provider.updateSelectedSection(1, S.of(context).homeVideo),
          ),
          const Gap(10),
          SectionForm(
            title: S.of(context).homewriting,
            isSelected: provider.selectedSectionIndex == 2,
            onTap: () =>
                provider.updateSelectedSection(2, S.of(context).homewriting),
          ),
          const Gap(10),
          SectionForm(
            title: S.of(context).homeMusic,
            isSelected: provider.selectedSectionIndex == 3,
            onTap: () =>
                provider.updateSelectedSection(3, S.of(context).homeMusic),
          ),
          const Gap(10),
          SectionForm(
            title: S.of(context).homeMedia,
            isSelected: provider.selectedSectionIndex == 4,
            onTap: () =>
                provider.updateSelectedSection(4, S.of(context).homeMedia),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
