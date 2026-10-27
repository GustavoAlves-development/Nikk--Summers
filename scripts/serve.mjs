import net from "node:net";
import { spawn } from "node:child_process";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const mode = process.argv[2] ?? "dev";
const args = process.argv.slice(3);
const portIndex = args.findIndex((arg) => arg === "--port" || arg === "-p");
const preferred = Number(portIndex >= 0 ? args[portIndex + 1] : process.env.PORT ?? 3011);
if (!Number.isInteger(preferred) || preferred < 1024 || preferred > 65535) {
  throw new Error("Escolha uma porta entre 1024 e 65535.");
}
if (portIndex >= 0) args.splice(portIndex, 2);
if (!["dev", "start"].includes(mode)) throw new Error("Use dev ou start.");

function isFree(port) {
  return new Promise((resolve, reject) => {
    const probe = net.createServer();
    probe.once("error", (error) => {
      if (["EADDRINUSE", "EACCES"].includes(error.code)) resolve(false);
      else reject(error);
    });
    probe.listen({ port, host: "127.0.0.1", exclusive: true }, () => probe.close(() => resolve(true)));
  });
}

let child;
let stopping = false;
for (const signal of ["SIGINT", "SIGTERM"]) {
  process.on(signal, () => { stopping = true; child?.kill(signal); });
}
for (let port = preferred; port <= Math.min(preferred + 99, 65535); port++) {
  if (!(await isFree(port))) {
    console.log(`[Nikk Summers] Porta ${port} ocupada. Tentando a próxima…`);
    continue;
  }
  console.log(`[Nikk Summers] Prévia local: http://127.0.0.1:${port}`);
  let collision = false;
  child = spawn(process.execPath, [require.resolve("next/dist/bin/next"), mode, "--hostname", "127.0.0.1", "--port", String(port), ...args], {
    stdio: ["inherit", "pipe", "pipe"], windowsHide: true, env: process.env,
  });
  child.stdout.on("data", (data) => process.stdout.write(data));
  child.stderr.on("data", (data) => {
    if (data.toString().includes("EADDRINUSE")) collision = true;
    process.stderr.write(data);
  });
  const code = await new Promise((resolve, reject) => {
    child.once("error", reject);
    child.once("exit", resolve);
  });
  if (!collision || stopping) process.exit(code ?? 0);
}
throw new Error("Nenhuma porta livre encontrada. Use --port.");
