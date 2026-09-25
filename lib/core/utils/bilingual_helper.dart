import 'dart:async';
import 'package:maratha_shivmudra/core/utils/google_transliteration_client.dart';

abstract class BilingualHelper {
  static bool isDevanagari(String text) {
    return RegExp(r'[\u0900-\u097F]').hasMatch(text);
  }

  static final Map<String, String> _transliterationCache = {};

  /// Comprehensive dictionary of frequent Marathi words, names, places, and terms
  static final Map<String, String> _dictionary = {
    // Brand & Core Movement
    'maratha': 'मराठा',
    'shivmudra': 'शिवमुद्रा',
    'shivaji': 'शिवाजी',
    'chhatrapati': 'छत्रपती',
    'maharashtra': 'महाराष्ट्र',
    'swarajya': 'स्वराज्य',
    'namaste': 'नमस्ते',
    'prashant': 'प्रशांत',
    'krishna': 'कृष्ण',
    'sanjay': 'संजय',
    'sandip': 'संदिप',
    'sandeep': 'संदीप',
    'jaydip': 'जयदिप',
    'jaydeep': 'जयदीप',
    'deepak': 'दीपक',
    'dipak': 'दिपक',
    'kumar': 'कुमार',
    'poonam': 'पूनम',
    'punam': 'पुनम',
    'anand': 'आनंद',
    'sant': 'संत',
    'swami': 'स्वामी',
    'dnyan': 'ज्ञान',
    'dnyaneshwar': 'ज्ञानेश्वर',
    'vidya': 'विद्या',
    'satya': 'सत्य',
    'dharma': 'धर्म',
    'dharm': 'धर्म',
    'karma': 'कर्म',
    'karm': 'कर्म',
    'karya': 'कार्य',
    'surya': 'सूर्य',
    'bharat': 'भारत',
    'shree': 'श्री',
    'shri': 'श्री',
    'om': 'ओम',
    'ram': 'राम',
    'sita': 'सीता',
    'lakshman': 'लक्ष्मण',
    'hanuman': 'हनुमान',
    'ganesh': 'गणेश',
    'antar': 'अंतर',
    'sanghatan': 'संघटन',
    'pramukh': 'प्रमुख',
    'adhyaksh': 'अध्यक्ष',
    'karyakarini': 'कार्यकारिणी',
    'sadasya': 'सदस्य',
    'pradesh': 'प्रदेश',
    'vibhag': 'विभाग',
    'jilha': 'जिल्हा',
    'taluka': 'तालुका',
    'shakha': 'शाखा',
    'sampark': 'संपर्क',
    'seva': 'सेवा',
    'mitra': 'मित्र',
    'mandal': 'मंडळ',
    'samiti': 'समिती',
    'sangh': 'संघ',
    'sanghatana': 'संघटना',
    'shakti': 'शक्ती',
    'bhakti': 'भक्ती',
    'mukt': 'मुक्त',
    'mukti': 'मुक्ती',
    'shabd': 'शब्द',
    'samapt': 'समाप्त',
    'pustak': 'पुस्तक',
    'rasta': 'रस्ता',
    'kalyan': 'कल्याण',
    'krupa': 'कृपा',
    'pooja': 'पूजा',
    'puja': 'पूजा',
    'aarti': 'आरती',
    'mandir': 'मंदिर',
    'vishvas': 'विश्वास',
    'vishwas': 'विश्वास',
    'patra': 'पत्र',
    // Surnames
    'pawar': 'पवार',
    'pawaar': 'पवार',
    'patil': 'पाटील',
    'deshmukh': 'देशमुख',
    'kadam': 'कदम',
    'jadhav': 'जाधव',
    'bhosale': 'भोसले',
    'chavan': 'चव्हाण',
    'gaikwad': 'गायकवाड',
    'shinde': 'शिंदे',
    'more': 'मोरे',
    'jagtap': 'जगतप',
    'raut': 'राऊत',
    'sawant': 'सावंत',
    'salunkhe': 'साळुंखे',
    'mohite': 'मोहिते',
    'mane': 'माने',
    'thorat': 'थोरात',
    'ghatge': 'घाटगे',
    'shirke': 'शिर्के',
    'mahadik': 'महाडिक',
    'gujar': 'गुजर',
    'nalawade': 'नलवडे',
    'shelar': 'शेलार',
    'dhawale': 'ढवळे',
    'dhumal': 'धुमाळ',
    // Districts & Major Cities
    'mumbai': 'मुंबई',
    'pune': 'पुणे',
    'thane': 'ठाणे',
    'nashik': 'नाशिक',
    'nagpur': 'नागपूर',
    'sambhajinagar': 'संभाजीनगर',
    'kolhapur': 'कोल्हापूर',
    'satara': 'सातारा',
    'sangli': 'सांगली',
    'solapur': 'सोलापूर',
    'amravati': 'अमरावती',
    'nanded': 'नांदेड',
    'jalgaon': 'जळगाव',
    'akola': 'अकोला',
    'latur': 'लातूर',
    'dhule': 'धुळे',
    'ahmednagar': 'अहमदनगर',
    'chandrapur': 'चंद्रपूर',
    'parbhani': 'परभणी',
    'jalna': 'जालना',
    'beed': 'बीड',
    'raigad': 'रायगड',
    'ratnagiri': 'रत्नागिरी',
    'sindhudurg': 'सिंधुदुर्ग',
    'wardha': 'वर्धा',
    'washim': 'वाशिम',
    'hingoli': 'हिंगोली',
    'gadchiroli': 'गडचिरोली',
    'bhandara': 'भंडारा',
    'gondia': 'गोंदिया',
    'buldhana': 'बुलढाणा',
    'nandurbar': 'नंदुरबार',
    'palghar': 'पालघर',
    'dharashiv': 'धाराशिव',
  };

  /// Live transliteration querying Google Transliteration API with strict
  /// ऱ्हस्व vs दीर्घ candidate re-ranking and instant algorithmic fallback.
  static Future<String> transliterateLive(String input) async {
    if (input.trim().isEmpty) return input;
    // If text contains NO Latin letters, it's already Devanagari or numbers
    if (!RegExp(r'[a-zA-Z]').hasMatch(input)) return input.trim();

    final words = input.trim().split(RegExp(r'\s+'));
    final results = <String>[];

    for (final word in words) {
      if (word.isEmpty) continue;
      if (!RegExp(r'[a-zA-Z]').hasMatch(word)) {
        results.add(word);
        continue;
      }

      final lowerWord = word.toLowerCase();
      if (_dictionary.containsKey(lowerWord)) {
        results.add(_dictionary[lowerWord]!);
        continue;
      }
      if (_transliterationCache.containsKey(lowerWord)) {
        results.add(_transliterationCache[lowerWord]!);
        continue;
      }

      final candidates =
          await GoogleTransliterationClient.getCandidates(word);
      if (candidates.isNotEmpty) {
        final chosen = _reRankCandidates(candidates, word);
        _transliterationCache[lowerWord] = chosen;
        results.add(chosen);
      } else {
        // Fallback to pure algorithmic Indic transliterator
        final converted = _phoneticLatinToMarathi(lowerWord);
        _transliterationCache[lowerWord] = converted;
        results.add(converted);
      }
    }

    return results.join(' ');
  }

  /// Synchronous fallback transliteration when async is not feasible
  static String transliterateToMarathi(String input) {
    if (input.isEmpty) return input;
    if (!RegExp(r'[a-zA-Z]').hasMatch(input)) return input;

    return input.replaceAllMapped(RegExp(r'[a-zA-Z]+'), (match) {
      return _phoneticLatinToMarathi(match.group(0)!.toLowerCase());
    });
  }

  /// Re-ranks Google Transliteration candidates according to strict
  /// Marathi grammar rules:
  /// - 'i' -> पहिली वेलांटी (ि) / सुरुवातीला इ
  /// - 'ee' -> दुसरी वेलांटी (ी) / सुरुवातीला ई
  /// - 'u' -> पहिला उकार (ु) / सुरुवातीला उ
  /// - 'oo' -> दुसरा उकार (ू) / सुरुवातीला ऊ
  /// - 'antar' -> अंतर (A without kaana)
  static String _reRankCandidates(List<String> candidates, String rawWord) {
    final lower = rawWord.toLowerCase();

    // 1. Antar (without kaana)
    if (lower.startsWith('antar')) {
      for (final c in candidates) {
        if (c.startsWith('अंतर')) return c;
      }
    }

    // 2. 'dip' vs 'deep'
    if (lower.contains('dip') && !lower.contains('deep')) {
      for (final c in candidates) {
        if (c.contains('दिप')) return c;
      }
    }
    if (lower.contains('deep')) {
      for (final c in candidates) {
        if (c.contains('दीप')) return c;
      }
    }

    // 3. 'u' vs 'oo'
    if (lower.contains('u') && !lower.contains('oo')) {
      for (final c in candidates) {
        if (c.contains('ु') && !c.contains('ू')) return c;
      }
    }
    if (lower.contains('oo')) {
      for (final c in candidates) {
        if (c.contains('ू')) return c;
      }
    }

    // 4. General 'i' vs 'ee'
    if (lower.contains('i') && !lower.contains('ee')) {
      for (final c in candidates) {
        if (c.contains('ि') && !c.contains('ी')) return c;
      }
    }

    // Default to Google's first recommendation
    return candidates.first;
  }

  /// Pure algorithmic Indic phonetic transliteration engine.
  /// Comprehensive support for:
  /// - Jodakshars (जोडाक्षरे / conjuncts with Halant '्')
  /// - Kaana ('ा'), Velanti ('ि'/'ी'), Ukar ('ु'/'ू'), Matra ('े'/'ै', 'ो'/'ौ')
  /// - Anusvara / Timb ('ं')
  /// - Rukar ('ृ')
  static String _phoneticLatinToMarathi(String lower) {
    if (lower.isEmpty) return lower;

    if (_dictionary.containsKey(lower)) {
      return _dictionary[lower]!;
    }
    if (_transliterationCache.containsKey(lower)) {
      return _transliterationCache[lower]!;
    }

    const multiConsonants = <String, String>{
      'shhr': 'ष्र',
      'chhh': 'च्छ',
      'shtr': 'ष्ट्र',
      'ndr': 'न्द्र',
      'ksh': 'क्ष',
      'kxy': 'क्ष्य',
      'dny': 'ज्ञ',
      'jny': 'ज्ञ',
      'gny': 'ज्ञ',
      'shr': 'श्र',
      'chh': 'छ',
      'shh': 'ष',
      'thh': 'ठ',
      'dhh': 'ढ',
      'cch': 'च्छ',
      'kht': 'ख्त',
      'gdh': 'ग्ध',
      'kh': 'ख',
      'gh': 'घ',
      'ch': 'च',
      'jh': 'झ',
      'th': 'थ',
      'dh': 'ध',
      'ph': 'फ',
      'bh': 'भ',
      'sh': 'श',
      'wh': 'व्ह',
      'rh': 'ऱ्ह',
      'ng': 'ङ',
      'ny': 'ञ',
      'gy': 'ज्ञ',
      'ld': 'ळ',
      'zh': 'झ',
    };

    const singleConsonants = <String, String>{
      'k': 'क', 'g': 'ग', 'c': 'क', 'j': 'ज', 'z': 'झ',
      't': 'त', 'd': 'द', 'n': 'न',
      'p': 'प', 'f': 'फ', 'b': 'ब', 'm': 'म',
      'y': 'य', 'r': 'र', 'l': 'ल', 'v': 'व', 'w': 'व',
      's': 'स', 'h': 'ह', 'x': 'क्ष', 'q': 'क',
    };

    const initialVowels = <String, String>{
      'aa': 'आ', 'a': 'अ', 'ee': 'ई', 'ii': 'ई', 'i': 'इ',
      'oo': 'ऊ', 'uu': 'ऊ', 'u': 'उ',
      'ai': 'ऐ', 'e': 'ए', 'au': 'औ', 'ou': 'औ', 'o': 'ओ',
      'ru': 'ऋ', 'ri': 'ऋ',
    };

    const vowelMatras = <String, String>{
      'aa': 'ा', 'ee': 'ी', 'ii': 'ी', 'i': 'ि',
      'oo': 'ू', 'uu': 'ू', 'u': 'ु',
      'ai': 'ै', 'e': 'े', 'au': 'ौ', 'ou': 'ौ', 'o': 'ो',
      'ru': 'ृ', 'ri': 'ृ',
    };

    final buffer = StringBuffer();
    int i = 0;
    bool afterConsonant = false;
    String? lastConsonant;

    // Check initial vowel
    if (i < lower.length) {
      if (i + 2 <= lower.length &&
          initialVowels.containsKey(lower.substring(i, i + 2))) {
        buffer.write(initialVowels[lower.substring(i, i + 2)]);
        i += 2;
        afterConsonant = false;
      } else if (initialVowels.containsKey(lower[i])) {
        // Special check: 'a' followed by 'n' or 'm' before consonant (e.g. antar -> अंतर, anand -> आनंद)
        if (lower[i] == 'a' && i + 2 < lower.length) {
          final nextC = lower[i + 1];
          final afterNext = lower[i + 2];
          final isNextConsonant = singleConsonants.containsKey(afterNext) ||
              multiConsonants.keys.any((k) => lower.substring(i + 2).startsWith(k));
          if ((nextC == 'n' || nextC == 'm') && isNextConsonant) {
            if (lower.startsWith('antar')) {
              buffer.write('अं');
            } else if (lower.startsWith('anand')) {
              buffer.write('आ');
            } else {
              buffer.write('अं');
            }
            i += 2;
            afterConsonant = false;
          } else {
            buffer.write(initialVowels[lower[i]]);
            i += 1;
            afterConsonant = false;
          }
        } else {
          buffer.write(initialVowels[lower[i]]);
          i += 1;
          afterConsonant = false;
        }
      }
    }

    while (i < lower.length) {
      // 1. Check for Timb / Anusvara ('ं')
      // 'n' or 'm' after consonant or vowel, preceding another consonant
      if ((lower[i] == 'n' || lower[i] == 'm') && i + 1 < lower.length) {
        final nextChar = lower[i + 1];
        // If not geminate 'nn' or 'mm'
        if (nextChar != lower[i]) {
          final isNextConsonant = singleConsonants.containsKey(nextChar) ||
              multiConsonants.keys.any((k) => lower.substring(i + 1).startsWith(k));
          if (isNextConsonant && nextChar != 'h' && nextChar != 'y') {
            buffer.write('ं');
            i += 1;
            afterConsonant = false;
            continue;
          }
        }
      }

      // 2. Check for Consonants (Multi-char first, then single-char)
      String? matchedConsonant;
      int consumedConsonant = 0;

      for (int len = 4; len >= 2; len--) {
        if (i + len <= lower.length) {
          final sub = lower.substring(i, i + len);
          if (multiConsonants.containsKey(sub)) {
            matchedConsonant = multiConsonants[sub];
            consumedConsonant = len;
            break;
          }
        }
      }

      if (matchedConsonant == null && singleConsonants.containsKey(lower[i])) {
        matchedConsonant = singleConsonants[lower[i]];
        consumedConsonant = 1;
      }

      if (matchedConsonant != null) {
        // If another consonant immediately preceded this without an intervening vowel:
        // INSERT HALANT ('्') TO FORM JODAKSHAR!
        // Note: 'य' (y) in Marathi functions as a syllable coda / semivowel and does not form
        // a preceding halant conjunct (e.g. jayd -> जयद, jayshree -> जयश्री, jaywant -> जयवंत).
        if (afterConsonant && lastConsonant != 'य') {
          buffer.write('\u094D');
        }

        buffer.write(matchedConsonant);
        lastConsonant = matchedConsonant;
        i += consumedConsonant;
        afterConsonant = true;

        // Check if immediately followed by vowel matra
        if (i < lower.length) {
          // 2-character matra (aa, ee, oo, ai, au, ru, ri...)
          if (i + 2 <= lower.length &&
              vowelMatras.containsKey(lower.substring(i, i + 2))) {
            buffer.write(vowelMatras[lower.substring(i, i + 2)]);
            i += 2;
            afterConsonant = false;
            continue;
          }

          // Single char matra (i, u, e, o)
          if (lower[i] == 'i' ||
              lower[i] == 'u' ||
              lower[i] == 'e' ||
              lower[i] == 'o') {
            buffer.write(vowelMatras[lower[i]]);
            i += 1;
            afterConsonant = false;
            continue;
          }

          // 'a' handling:
          if (lower[i] == 'a') {
            i += 1;
            // If explicit 'aa':
            if (i < lower.length && lower[i] == 'a') {
              buffer.write('ा');
              i += 1;
              afterConsonant = false;
              continue;
            }

            // Word-final 'a' after consonant in words of >=3 letters:
            // Checks if this ending should take kaana 'ा' (e.g. maratha, shivmudra, rasta, vidya)
            // or remain halant-less tatkama (e.g. patra, mitra, karya, dharma, karma, sarva, satya)
            if (i >= lower.length && lower.length >= 3) {
              final isTatkamaConjunctEnd = lower.endsWith('tra') ||
                  lower.endsWith('rya') ||
                  lower.endsWith('rma') ||
                  lower.endsWith('rva') ||
                  lower.endsWith('tya') ||
                  lower.endsWith('shya') ||
                  lower.endsWith('stra');

              final takesKaana = lower.endsWith('tha') ||
                  lower.endsWith('dra') ||
                  lower.endsWith('sta') ||
                  lower.endsWith('dya') ||
                  lower.endsWith('dnya') ||
                  lower.endsWith('ksha') ||
                  lower.endsWith('ta') ||
                  lower.endsWith('pa') ||
                  lower.endsWith('ja') ||
                  lower.endsWith('na');

              if (!isTatkamaConjunctEnd && takesKaana) {
                buffer.write('ा');
              }
            }
            afterConsonant = false;
            continue;
          }
        }
        continue;
      }

      // 3. Standalone independent vowel in middle
      if (i + 2 <= lower.length &&
          initialVowels.containsKey(lower.substring(i, i + 2))) {
        buffer.write(initialVowels[lower.substring(i, i + 2)]);
        i += 2;
        afterConsonant = false;
        continue;
      } else if (initialVowels.containsKey(lower[i])) {
        buffer.write(initialVowels[lower[i]]);
        i += 1;
        afterConsonant = false;
        continue;
      }

      // 4. Pass-through for non-alphabet characters
      final ch = lower[i];
      if (isDevanagari(ch) || RegExp(r'[\s\-()0-9.,!?]').hasMatch(ch)) {
        buffer.write(ch);
      }
      afterConsonant = false;
      i++;
    }

    final result = buffer.toString();
    _transliterationCache[lower] = result;
    return result;
  }

  /// Generate search tokens for fast Firestore querying
  static List<String> generateSearchTokens({
    required String nameEn,
    required String nameMr,
    required String phone,
    required String memberId,
    String? district,
    String? taluka,
  }) {
    final Set<String> tokens = {};

    void addTokenParts(String text) {
      final clean = text.trim().toLowerCase();
      if (clean.isEmpty) return;
      tokens.add(clean);
      final parts = clean.split(RegExp(r'[\s\-_,()]+'));
      for (final part in parts) {
        if (part.isNotEmpty) {
          tokens.add(part);
          for (int i = 2; i <= part.length; i++) {
            tokens.add(part.substring(0, i));
          }
        }
      }
    }

    addTokenParts(nameEn);
    addTokenParts(nameMr);
    addTokenParts(phone);
    addTokenParts(memberId);
    if (district != null) addTokenParts(district);
    if (taluka != null) addTokenParts(taluka);

    return tokens.toList();
  }
}
