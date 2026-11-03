<div class="agent-player __CLS__" id="__UID__" data-trace="__DATA__"
     data-prevent-swipe style="height:__H__px">
<style>
.agent-player{display:flex;flex-direction:column;gap:10px;font-size:20px;
  line-height:1.3;text-align:left;font-family:inherit;position:relative}
.agent-player .ap-bar{height:4px;background:#e2e8f0;border-radius:2px;
  overflow:hidden}
.agent-player .ap-bar i{display:block;height:100%;width:0;
  background:#2563eb;transition:width .35s}
.agent-player .ap-q{display:flex;gap:10px;align-items:baseline}
.agent-player .ap-tag{font-weight:800;font-size:15px;letter-spacing:.06em;
  text-transform:uppercase;color:#7c3aed;white-space:nowrap}
.agent-player .qt{font-weight:600;color:#0f172a}
.agent-player .ap-body{display:flex;gap:16px;flex:1;min-height:0}
.agent-player .ap-side{flex:0 0 250px;display:flex;flex-direction:column;
  gap:10px}
.agent-player svg{width:250px;height:250px}
.agent-player .nd rect{fill:#fff;stroke:#cbd5e1;stroke-width:2.5;
  transition:all .3s}
.agent-player .nd text{font-size:18px;font-weight:800;fill:#334155;
  text-anchor:middle;dominant-baseline:middle}
.agent-player .nd.on rect{stroke-width:4;animation:apPulse 1.2s ease infinite}
.agent-player .nd.llm.on rect{fill:#dbeafe;stroke:#2563eb}
.agent-player .nd.tool.on rect{fill:#fef3c7;stroke:#f59e0b}
.agent-player .nd.obs.on rect{fill:#d1fae5;stroke:#10b981}
.agent-player .ar{stroke:#cbd5e1;stroke-width:2.5;fill:none;
  transition:stroke .3s}
.agent-player .ar.flow{stroke:#7c3aed;stroke-width:3.5;
  stroke-dasharray:8 7;animation:apFlow .6s linear infinite}
.agent-player .al{font-size:14px;fill:#94a3b8;text-anchor:middle;
  font-family:"JetBrains Mono",Consolas,monospace}
.agent-player .stats{display:grid;grid-template-columns:1fr 1fr 1fr;gap:6px}
.agent-player .st{background:#f8fafc;border:1px solid #e2e8f0;
  border-radius:10px;padding:4px 0;text-align:center}
.agent-player .st b{display:block;font-size:24px;color:#0f172a;
  font-weight:800;line-height:1.1}
.agent-player .st span{font-size:12px;color:#64748b;text-transform:uppercase;
  letter-spacing:.05em}
.agent-player .st.err b{color:#dc2626}
.agent-player .ap-log{flex:1;overflow-y:auto;border:1px solid #e2e8f0;
  border-radius:12px;padding:10px 12px;background:#fff;
  box-shadow:0 4px 18px rgba(15,23,42,.05)}
.agent-player .ev{border-left:5px solid #94a3b8;padding:4px 10px;
  margin:0 0 7px 0;border-radius:6px;animation:apIn .3s ease;display:flex;
  gap:10px}
.agent-player .ev b{flex:0 0 118px;font-size:16px;text-transform:uppercase;
  letter-spacing:.04em;padding-top:2px}
.agent-player .ev code{font-size:16.5px;background:none;white-space:pre-wrap;
  word-break:break-word;font-family:"JetBrains Mono",Consolas,monospace}
.agent-player .ev.thought{border-color:#2563eb;background:#eff6ff}
.agent-player .ev.thought b{color:#1d4ed8}
.agent-player .ev.call{border-color:#f59e0b;background:#fffbeb}
.agent-player .ev.call b{color:#b45309}
.agent-player .ev.obs{border-color:#10b981;background:#ecfdf5}
.agent-player .ev.obs b{color:#047857}
.agent-player .ev.error{border-color:#dc2626;background:#fef2f2}
.agent-player .ev.error b{color:#b91c1c}
.agent-player .ev.final{border-color:#7c3aed;background:#f5f3ff;
  font-weight:700;box-shadow:0 0 0 3px #ede9fe}
.agent-player .ev.final b{color:#6d28d9}
.agent-player .ev.stopped{border-color:#ea580c;background:#fff7ed;
  font-weight:700;box-shadow:0 0 0 3px #ffedd5}
.agent-player .ev.stopped b{color:#c2410c}
.agent-player .ap-ctl{display:flex;gap:8px;align-items:center}
.agent-player button{font-size:17px;padding:6px 16px;border-radius:999px;
  border:1px solid #cbd5e1;background:#fff;cursor:pointer;font-family:inherit;
  font-weight:600;color:#334155}
.agent-player button.pri{background:#2563eb;color:#fff;border:none}
.agent-player button:disabled{opacity:.35;cursor:default}
.agent-player .ap-src{margin-left:auto;color:#64748b;font-size:14px}
.agent-player.halt .ap-log{box-shadow:0 0 0 3px #fdba74}
.agent-player.notools .nd.tool,.agent-player.notools .nd.obs,
.agent-player.notools .ar,.agent-player.notools .al{opacity:.18}
.agent-player .nt{display:none;font-size:13px;font-weight:800;
  letter-spacing:.06em;text-transform:uppercase;color:#64748b;
  background:#f1f5f9;border-radius:999px;padding:2px 10px;margin-left:auto}
.agent-player.notools .nt{display:inline-block}
.agent-player .ev.bare{border-color:#64748b;background:#f8fafc;
  font-weight:600}
.agent-player .ev.bare b{color:#475569}
@keyframes apIn{from{opacity:0;transform:translateY(8px)}to{opacity:1}}
@keyframes apFlow{to{stroke-dashoffset:-15}}
@keyframes apPulse{50%{stroke-width:7}}
</style>
<div class="ap-bar"><i></i></div>
<div class="ap-q"><span class="ap-tag">Task</span><span class="qt"></span>
<span class="nt">No tools connected</span></div>
<div class="ap-body">
<div class="ap-side">
<svg viewBox="0 0 250 250" aria-label="Agent loop: the LLM decides, the tool
 runs, the result is read back by the LLM">
 <defs><marker id="__UID__-m" viewBox="0 0 10 10" refX="8" refY="5"
  markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M0,0L10,5L0,10z" fill="#94a3b8"/></marker></defs>
 <path class="ar decide" d="M168,62 Q232,100 205,168"
  marker-end="url(#__UID__-m)"/>
 <path class="ar run" d="M155,205 L97,205" marker-end="url(#__UID__-m)"/>
 <path class="ar read" d="M45,168 Q18,100 82,62"
  marker-end="url(#__UID__-m)"/>
 <text class="al" x="226" y="112">decide</text>
 <text class="al" x="126" y="232">run</text>
 <text class="al" x="24" y="112">read</text>
 <g class="nd llm"><rect x="78" y="14" width="94" height="48" rx="12"/>
  <text x="125" y="39">LLM</text></g>
 <g class="nd tool"><rect x="158" y="168" width="86" height="48" rx="12"/>
  <text x="201" y="193">Tool</text></g>
 <g class="nd obs"><rect x="6" y="168" width="86" height="48" rx="12"/>
  <text x="49" y="193">Result</text></g>
</svg>
<div class="stats">
 <div class="st"><b class="c-turn">0</b><span>LLM turns</span></div>
 <div class="st"><b class="c-call">0</b><span>Tool calls</span></div>
 <div class="st err"><b class="c-err">0</b><span>Errors</span></div>
</div>
</div>
<div class="ap-log" aria-live="polite"></div>
</div>
<div class="ap-ctl">
 <button class="pri nx">Next step &#9654;</button>
 <button class="all">Run all</button>
 <button class="rs">Reset</button>
 <span class="ap-src"></span>
</div>
<script>
(function(){
  const root = document.getElementById("__UID__");
  const d = JSON.parse(root.dataset.trace);
  const $ = s => root.querySelector(s);
  const log = $(".ap-log"), nx = $(".nx"), all = $(".all");
  const label = {thought:"Thinks", call:"Calls tool", obs:"Result",
    error:"Error", final:"✓ Answer", bare:"Answer",
    stopped:"■ Stopped"};
  const arrow = {call:"decide", obs:"run", error:"run"};
  let i = 0, timer = null, typing = null, prev = null;
  $(".qt").textContent = d.q;
  $(".ap-src").textContent = "Model turns: " + d.src;
  function light(n, a){
    root.querySelectorAll(".nd").forEach(g =>
      g.classList.toggle("on", g.classList.contains(n)));
    root.querySelectorAll(".ar").forEach(p =>
      p.classList.toggle("flow", p.classList.contains(a)));
  }
  function stats(){
    const seen = d.ev.slice(0, i), c = k => seen.filter(e => k.includes(e.kind)).length;
    $(".c-turn").textContent = c(["call", "final", "bare"]);
    $(".c-call").textContent = c(["call"]);
    $(".c-err").textContent = c(["error"]);
    $(".ap-bar i").style.width = (100 * i / d.ev.length) + "%";
    nx.disabled = all.disabled = i >= d.ev.length;
  }
  function type(el, text){
    if (typing) typing();
    let k = 0, id = setInterval(() => {
      el.textContent = text.slice(0, k += 2);
      log.scrollTop = log.scrollHeight;
      if (k >= text.length) done();
    }, 14);
    function done(){ clearInterval(id); el.textContent = text; typing = null; }
    typing = done;
  }
  function step(){
    if (i >= d.ev.length) { clearInterval(timer); return; }
    const e = d.ev[i++], div = document.createElement("div");
    div.className = "ev " + e.kind;
    const b = document.createElement("b"); b.textContent = label[e.kind];
    const code = ["call", "obs", "error"].includes(e.kind);
    const body = document.createElement(code ? "code" : "span");
    div.append(b, body); log.append(div);
    if (code) body.textContent = e.text; else type(body, e.text);
    log.scrollTop = log.scrollHeight;
    const a = arrow[e.kind] || (e.kind === "thought" && prev ? "read" : "");
    light(e.node, a); prev = e.kind;
    root.classList.toggle("halt", e.kind === "stopped");
    stats();
  }
  function reset(){
    clearInterval(timer); if (typing) typing();
    i = 0; prev = null; log.innerHTML = ""; light("none", "");
    root.classList.remove("halt"); stats();
  }
  const on = (el, f) => el.onclick = ev => { f(); ev.currentTarget.blur(); };
  on(nx, step);
  on(all, () => { clearInterval(timer); step(); timer = setInterval(step, 900); });
  on($(".rs"), reset);
  reset();
})();
</script>
</div>
