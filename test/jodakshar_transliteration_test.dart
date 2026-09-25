import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';

void main() {
  group('Indic Jodakshar & Phonetic Transliteration Tests', () {
    test('Jodakshars (joint words with halant) are generated correctly', () {
      // st -> स्त
      expect(BilingualHelper.transliterateToMarathi('namaste'), equals('नमस्ते'));
      expect(BilingualHelper.transliterateToMarathi('rasta'), equals('रस्ता'));
      expect(BilingualHelper.transliterateToMarathi('pustak'), equals('पुस्तक'));

      // pr -> प्र
      expect(BilingualHelper.transliterateToMarathi('prashant'), equals('प्रशांत'));
      expect(BilingualHelper.transliterateToMarathi('pramod'), equals('प्रमोद'));

      // dr -> द्र
      expect(BilingualHelper.transliterateToMarathi('shivmudra'), equals('शिवमुद्रा'));
      expect(BilingualHelper.transliterateToMarathi('mudra'), equals('मुद्रा'));

      // tr -> त्र
      expect(BilingualHelper.transliterateToMarathi('patra'), equals('पत्र'));
      expect(BilingualHelper.transliterateToMarathi('chhatrapati'), equals('छत्रपती'));

      // sw -> स्व
      expect(BilingualHelper.transliterateToMarathi('swami'), equals('स्वामी'));
      expect(BilingualHelper.transliterateToMarathi('swarajya'), equals('स्वराज्य'));

      // dny -> ज्ञ
      expect(BilingualHelper.transliterateToMarathi('dnyaneshwar'), equals('ज्ञानेश्वर'));
      expect(BilingualHelper.transliterateToMarathi('dnyan'), equals('ज्ञान'));

      // kt -> क्त
      expect(BilingualHelper.transliterateToMarathi('bhakti'), equals('भक्ती'));
      expect(BilingualHelper.transliterateToMarathi('mukt'), equals('मुक्त'));
      expect(BilingualHelper.transliterateToMarathi('shakti'), equals('शक्ती'));

      // shv -> श्व
      expect(BilingualHelper.transliterateToMarathi('vishvas'), equals('विश्वास'));

      // krishna -> कृष्ण
      expect(BilingualHelper.transliterateToMarathi('krishna'), equals('कृष्ण'));

      // maharashtra -> महाराष्ट्र
      expect(BilingualHelper.transliterateToMarathi('maharashtra'), equals('महाराष्ट्र'));

      // Tatkama words ending in inherent a
      expect(BilingualHelper.transliterateToMarathi('satya'), equals('सत्य'));
      expect(BilingualHelper.transliterateToMarathi('karya'), equals('कार्य'));
      expect(BilingualHelper.transliterateToMarathi('surya'), equals('सूर्य'));
      expect(BilingualHelper.transliterateToMarathi('dharma'), equals('धर्म'));
      expect(BilingualHelper.transliterateToMarathi('karma'), equals('कर्म'));
    });

    test('Kaana, Ukar, Matra, and Timb (Anusvara) are generated correctly', () {
      // Kaana
      expect(BilingualHelper.transliterateToMarathi('maratha'), equals('मराठा'));
      expect(BilingualHelper.transliterateToMarathi('vidya'), equals('विद्या'));

      // Timb (Anusvara)
      expect(BilingualHelper.transliterateToMarathi('sanjay'), equals('संजय'));
      expect(BilingualHelper.transliterateToMarathi('shinde'), equals('शिंदे'));
      expect(BilingualHelper.transliterateToMarathi('sant'), equals('संत'));
      expect(BilingualHelper.transliterateToMarathi('mumbai'), equals('मुंबई'));
      expect(BilingualHelper.transliterateToMarathi('anand'), equals('आनंद'));

      // Ukar & Matra
      expect(BilingualHelper.transliterateToMarathi('kumar'), equals('कुमार'));
      expect(BilingualHelper.transliterateToMarathi('bhosale'), equals('भोसले'));
    });
  });
}
