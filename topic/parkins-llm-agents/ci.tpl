<div class="ci-x" id="cix" data-prevent-swipe>
<style>
.ci-x{font-size:21px;text-align:left;display:flex;flex-direction:column;
  gap:14px}
.ci-x .row{display:flex;align-items:center;gap:16px}
.ci-x label{flex:0 0 260px;font-weight:700;color:#334155}
.ci-x input[type=range]{flex:1;accent-color:#7c3aed;height:6px}
.ci-x .v{flex:0 0 110px;text-align:right;font-weight:800;color:#0f172a;
  font-family:"JetBrains Mono",Consolas,monospace}
.ci-x svg{width:100%;height:150px}
.ci-x .tick{font-size:15px;fill:#64748b;text-anchor:middle;
  font-family:"JetBrains Mono",Consolas,monospace}
.ci-x .out{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.ci-x .box{border:1px solid #e2e8f0;border-radius:14px;padding:12px 16px;
  box-shadow:0 4px 18px rgba(15,23,42,.05)}
.ci-x .box .k{font-size:14px;text-transform:uppercase;letter-spacing:.06em;
  color:#64748b;font-weight:700}
.ci-x .box .big{font-size:30px;font-weight:800;color:#0f172a}
.ci-x .verdict{font-weight:800}
.ci-x .yes{color:#047857}.ci-x .no{color:#c2410c}
.ci-x .bar{height:12px;border-radius:6px;background:#f1f5f9;margin-top:8px;
  overflow:hidden}
.ci-x .bar i{display:block;height:100%;
  background:linear-gradient(90deg,#2563eb,#7c3aed);transition:width .2s}
</style>
<div class="row"><label>Observed pass rate</label>
 <input class="p" type="range" min="50" max="99" value="85">
 <span class="v vp"></span></div>
<div class="row"><label>Number of test tasks</label>
 <input class="n" type="range" min="0" max="10" value="2">
 <span class="v vn"></span></div>
<svg viewBox="0 0 1000 150" aria-label="Confidence interval on a 40 to 100
 percent axis with a dashed 70 percent baseline">
 <line x1="40" x2="960" y1="90" y2="90" stroke="#cbd5e1" stroke-width="2"/>
 <g class="ticks"></g>
 <line class="base" y1="30" y2="100" stroke="#f59e0b" stroke-width="3"
  stroke-dasharray="7 6"/>
 <text class="tick bl" y="22" fill="#b45309">70% baseline</text>
 <rect class="ci" y="74" height="32" rx="16" fill="url(#cixg)"
  opacity=".9" style="transition:all .25s"/>
 <circle class="pt" cy="90" r="11" fill="#fff" stroke="#0f172a"
  stroke-width="4" style="transition:all .25s"/>
 <defs><linearGradient id="cixg"><stop offset="0" stop-color="#2563eb"/>
  <stop offset="1" stop-color="#7c3aed"/></linearGradient></defs>
</svg>
<div class="out">
 <div class="box"><div class="k">95% Wilson interval</div>
  <div class="big civ"></div><div class="verdict"></div></div>
 <div class="box"><div class="k">Chance all
  <input class="kk" type="range" min="1" max="10" value="5"
   style="width:120px;vertical-align:middle;accent-color:#7c3aed">
  <span class="kv"></span> runs pass</div>
  <div class="big pk"></div><div class="bar"><i></i></div></div>
</div>
<script>
(function(){
  const r = document.getElementById("cix"), $ = s => r.querySelector(s);
  const NS = [5, 10, 20, 30, 50, 75, 100, 150, 200, 300, 500];
  const x = v => 40 + (v - 0.4) / 0.6 * 920;
  const tg = $(".ticks");
  for (let t = 40; t <= 100; t += 10) {
    tg.insertAdjacentHTML("beforeend",
      `<line x1="${x(t/100)}" x2="${x(t/100)}" y1="84" y2="96" stroke="#94a3b8"/>
       <text class="tick" x="${x(t/100)}" y="130">${t}%</text>`);
  }
  $(".base").setAttribute("x1", x(.7)); $(".base").setAttribute("x2", x(.7));
  $(".bl").setAttribute("x", x(.7));
  function wilson(p, n, z = 1.96){
    const m = (p + z*z/(2*n)) / (1 + z*z/n);
    const h = z * Math.sqrt(p*(1-p)/n + z*z/(4*n*n)) / (1 + z*z/n);
    return [m - h, m + h];
  }
  function draw(){
    const p = $(".p").value / 100, n = NS[$(".n").value], k = +$(".kk").value;
    const [lo, hi] = wilson(p, n), f = v => (100*v).toFixed(1) + "%";
    $(".vp").textContent = Math.round(p*100) + "%";
    $(".vn").textContent = "n = " + n;
    const L = x(Math.max(lo, .4)), R = x(Math.min(hi, 1));
    $(".ci").setAttribute("x", L); $(".ci").setAttribute("width", R - L);
    $(".pt").setAttribute("cx", x(p));
    $(".civ").textContent = f(lo) + " to " + f(hi);
    const v = $(".verdict"), win = lo > .7;
    v.textContent = win ? "Clearly beats the 70% baseline"
                        : "Can't rule out 70% or worse";
    v.className = "verdict " + (win ? "yes" : "no");
    $(".kv").textContent = k;
    $(".pk").textContent = (100 * p**k).toFixed(0) + "%";
    $(".bar i").style.width = (100 * p**k) + "%";
  }
  r.querySelectorAll("input").forEach(el => {
    el.oninput = draw; el.onchange = () => el.blur(); });
  draw();
})();
</script>
</div>
