import { execSync } from 'child_process';

async function resetDinesh() {
  const token = execSync('gcloud auth print-access-token', { encoding: 'utf-8' }).trim();
  const projectId = 'maratha-shivmudra';
  const baseUrl = `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents`;
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json'
  };

  console.log('--- Step 1: Fetching Dinesh document ---');
  const dineshRes = await fetch(`${baseUrl}/members/8605474474`, { headers });
  const dineshDoc = await dineshRes.json();
  console.log('Current member_id:', dineshDoc.fields?.member_id);
  console.log('Current is_card_issued:', dineshDoc.fields?.is_card_issued);
  console.log('Current is_profile_complete:', dineshDoc.fields?.is_profile_complete);

  console.log('--- Step 2: Resetting Dinesh to PENDING and removing card fields ---');
  const dineshUpdate = {
    update: {
      name: `projects/${projectId}/databases/(default)/documents/members/8605474474`,
      fields: {
        member_id: { stringValue: 'PENDING' },
        is_card_issued: { booleanValue: false },
        is_profile_complete: { booleanValue: false },
      }
    },
    updateMask: {
      fieldPaths: ['member_id', 'is_card_issued', 'is_profile_complete']
    }
  };

  // Also remove card_issued_date and serial_number via updateMask delete or document patch
  // In Firestore REST, omitting fields in update with updateMask that doesn't include them leaves them,
  // but if we want to delete fields, we send empty field or patch with updateMask
  const dineshPatchRes = await fetch(`${baseUrl}/members/8605474474?updateMask.fieldPaths=member_id&updateMask.fieldPaths=is_card_issued&updateMask.fieldPaths=is_profile_complete&updateMask.fieldPaths=card_issued_date&updateMask.fieldPaths=serial_number`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify({
      fields: {
        member_id: { stringValue: 'PENDING' },
        is_card_issued: { booleanValue: false },
        is_profile_complete: { booleanValue: false }
      }
    })
  });

  if (!dineshPatchRes.ok) {
    console.error('Failed to update Dinesh doc:', dineshPatchRes.status, await dineshPatchRes.text());
    process.exit(1);
  }
  console.log('Successfully reset Dinesh doc to PENDING!');

  console.log('--- Step 3: Updating counters/district_counters.PUN to 19 ---');
  const counterPatchRes = await fetch(`${baseUrl}/counters/district_counters?updateMask.fieldPaths=PUN`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify({
      fields: {
        PUN: { integerValue: '19' }
      }
    })
  });

  if (!counterPatchRes.ok) {
    console.error('Failed to update district_counters.PUN:', counterPatchRes.status, await counterPatchRes.text());
    process.exit(1);
  }
  console.log('Successfully set district_counters.PUN to 19!');

  console.log('--- Step 4: Verification ---');
  const verifyDineshRes = await fetch(`${baseUrl}/members/8605474474`, { headers });
  const verifyDinesh = await verifyDineshRes.json();
  console.log('Verified Dinesh:', {
    member_id: verifyDinesh.fields?.member_id,
    is_card_issued: verifyDinesh.fields?.is_card_issued,
    is_profile_complete: verifyDinesh.fields?.is_profile_complete,
    serial_number: verifyDinesh.fields?.serial_number,
    card_issued_date: verifyDinesh.fields?.card_issued_date,
  });

  const verifyCounterRes = await fetch(`${baseUrl}/counters/district_counters`, { headers });
  const verifyCounter = await verifyCounterRes.json();
  console.log('Verified PUN Counter:', verifyCounter.fields?.PUN);
}

resetDinesh().catch(console.error);
