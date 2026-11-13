const test = require('node:test');
const assert = require('node:assert');
const path = require('node:path');

process.env.NODE_ENV = 'test';
process.env.JWT_SECRET = 'test-secret-key-123456';

// Substitui banco, logger e Gemini antes de carregar o controlador.
let state = { premium: 0, total: 0, generated: 0 };
const stub = (rel, exports) => {
  const id = require.resolve(path.join('..', 'src', rel));
  require.cache[id] = { id, filename: id, loaded: true, exports };
};
stub('config/db', {
  execute: async (sql) => (/FROM usuarios/.test(sql) ? [[{ premium: state.premium }]] : [[{ total: state.total }]])
});
const events = [];
stub('services/loggerService', { logFromReq: (_req, e) => events.push(e), logAuditEvent: () => {}, extractIp: () => '127.0.0.1' });
stub('services/storageService', { uploadBuffer: async () => null, uploadAvatar: async () => null, removeAvatar: async () => {} });
stub('services/geminiService', {
  generatePost: async () => { state.generated++; throw Object.assign(new Error('stop'), { status: 502 }); }
});
const { generatePostAI } = require('../src/controllers/postController');

function call() {
  return new Promise((resolve) => {
    const res = { code: 200, status(c) { this.code = c; return this; }, json(b) { resolve({ code: this.code, body: b }); } };
    generatePostAI({ userId: 7, body: { tema: 'carboidratos' } }, res);
  });
}

test('plano gratuito com 3 gerações no mês é bloqueado com 403 antes de chamar o Gemini', async () => {
  state = { premium: 0, total: 3, generated: 0 };
  const r = await call();
  assert.strictEqual(r.code, 403);
  assert.strictEqual(r.body.codigo, 'limite_gratuito_atingido');
  assert.strictEqual(state.generated, 0);
  assert.strictEqual(events.at(-1).action, 'limite_gratuito_atingido');
});

test('plano gratuito abaixo do limite segue para a geração', async () => {
  state = { premium: 0, total: 2, generated: 0 };
  await call();
  assert.strictEqual(state.generated, 1);
});

test('usuário premium não é limitado', async () => {
  state = { premium: 1, total: 50, generated: 0 };
  await call();
  assert.strictEqual(state.generated, 1);
});
