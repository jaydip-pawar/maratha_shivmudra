import { execSync } from 'child_process';

const DISTRICT_CODES = [
  'AHI', 'AKL', 'AMR', 'CSN', 'BEE', 'BHA', 'BUL', 'CHA',
  'DHU', 'DHA', 'GAD', 'GON', 'HIN', 'JAL', 'JLN', 'KOL',
  'LAT', 'MMC', 'MMS', 'NAG', 'NED', 'NDB', 'NSK', 'PLG',
  'PRB', 'PUN', 'RAI', 'RAT', 'SAN', 'SAT', 'SND', 'SOL',
  'THA', 'WRD', 'WAS', 'YAV'
];

async function run() {
  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const url = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents/counters/district_counters`;

  const fields = {};
  for (const code of DISTRICT_CODES) {
    fields[code] = { integerValue: '0' };
  }

  console.log(`Resetting counters for ${DISTRICT_CODES.length} districts in counters/district_counters to 0...`);

  const res = await fetch(url, {
    method: 'PATCH',
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ fields }),
  });

  if (!res.ok) {
    const errorText = await res.text();
    throw new Error(`Failed to update district_counters: ${res.status} ${errorText}`);
  }

  const result = await res.json();
  console.log('Successfully reset counters/district_counters to 0:');
  for (const [k, v] of Object.entries(result.fields || {})) {
    console.log(`  ${k}: ${v.integerValue}`);
  }
}

run().catch(console.error);
