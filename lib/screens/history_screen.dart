import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/typography/text_style.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const stageTitles = [
    'Arc de Triomphe',
    'Colosseum',
    'The Great Pyramid of Giza'
  ];

  static const descriptions = [
    "The Arc de Triomphe de l'Étoile is one of the most famous monuments in Paris, France, standing at the western end of the Champs-Élysées at the centre of Place Charles de Gaulle, formerly named Place de l'Étoile—the étoile or 'star' of the juncture formed by its twelve radiating avenues. The location of the arc and the plaza is shared between three arrondissements, 16th (south and west), 17th (north), and 8th (east). The Arc de Triomphe honours those who fought and died for France in the French Revolutionary and Napoleonic Wars, with the names of all French victories and generals inscribed on its inner and outer surfaces. Beneath its vault lies the Tomb of the Unknown Soldier from World War I.",
    "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age. Construction began under the emperor Vespasian and was completed in 80 AD under his successor and heir, Titus. Further modifications were made during the reign of Domitian The three emperors that were patrons of the work are known as the Flavian dynasty, and the amphitheatre was named the Flavian Amphitheatre by later classicists and archaeologists for its association with their family name.",
    "The Great Pyramid of Giza (also known as the Pyramid of Khufu or the Pyramid of Cheops) is the oldest and largest of the pyramids in the Giza pyramid complex bordering present-day Giza in Greater Cairo, Egypt. It is the oldest of the Seven Wonders of the Ancient World, and the only one to remain largely intact. Egyptologists conclude that the pyramid was built as a tomb for the Fourth Dynasty Egyptian pharaoh Khufu and estimate that it was built in the 26th century BC during a period of around 27 years.",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(stageTitles[value.stage - 1]),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) => Image.asset(
                      'assets/images/puzzles/complete/${value.stage}.jpeg',
                      height: MediaQuery.of(context).size.height / 2.5),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  stageTitles[value.stage - 1],
                  style: PuzzleTextStyle.headline4,
                )),
            Text(
              descriptions[value.stage - 1],
              style: PuzzleTextStyle.bodySmall,
            ),
          ],
        ),
      );
    });
  }
}
