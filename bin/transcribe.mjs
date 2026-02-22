#!/usr/bin/env node
/**
 * Transcribe audio using AssemblyAI
 * Usage: node bin/transcribe.mjs <file_or_url>
 */

import { readFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';

const API_KEY = '2b5698ed9d4d426cb65b1f5bcf33c257';
const API_BASE = 'https://api.assemblyai.com/v2';

async function upload(filePath) {
  console.log('⬆️  Uploading...');
  const fileData = await readFile(filePath);
  
  const response = await fetch(`${API_BASE}/upload`, {
    method: 'POST',
    headers: {
      'authorization': API_KEY,
      'content-type': 'application/octet-stream',
    },
    body: fileData,
  });
  
  const data = await response.json();
  if (!data.upload_url) {
    throw new Error(`Upload failed: ${JSON.stringify(data)}`);
  }
  return data.upload_url;
}

async function transcribe(audioUrl) {
  console.log('🎯 Transcribing...');
  
  const response = await fetch(`${API_BASE}/transcript`, {
    method: 'POST',
    headers: {
      'authorization': API_KEY,
      'content-type': 'application/json',
    },
    body: JSON.stringify({
      audio_url: audioUrl,
      speaker_labels: true,
    }),
  });
  
  const data = await response.json();
  if (!data.id) {
    throw new Error(`Failed to create transcript: ${JSON.stringify(data)}`);
  }
  return data.id;
}

async function poll(transcriptId) {
  while (true) {
    const response = await fetch(`${API_BASE}/transcript/${transcriptId}`, {
      headers: { 'authorization': API_KEY },
    });
    
    const data = await response.json();
    
    if (data.status === 'completed') {
      return data;
    } else if (data.status === 'error') {
      throw new Error(`Transcription failed: ${data.error}`);
    }
    
    await new Promise(r => setTimeout(r, 2000));
  }
}

function formatOutput(data) {
  if (data.utterances && data.utterances.length > 0) {
    return data.utterances.map(u => `[${u.speaker}]: ${u.text}`).join('\n');
  }
  return data.text || '';
}

async function main() {
  const input = process.argv[2];
  
  if (!input) {
    console.error('Usage: node bin/transcribe.mjs <file_or_url>');
    process.exit(1);
  }
  
  console.log(`📁 ${input}`);
  
  let audioUrl;
  
  if (input.startsWith('http://') || input.startsWith('https://')) {
    // Direct URL
    audioUrl = input;
  } else if (existsSync(input)) {
    // Local file - upload first
    audioUrl = await upload(input);
  } else {
    console.error(`Error: File not found: ${input}`);
    process.exit(1);
  }
  
  const transcriptId = await transcribe(audioUrl);
  const result = await poll(transcriptId);
  const output = formatOutput(result);
  
  console.log('✅ Done\n');
  console.log(output);
}

main().catch(err => {
  console.error('Error:', err.message);
  process.exit(1);
});
