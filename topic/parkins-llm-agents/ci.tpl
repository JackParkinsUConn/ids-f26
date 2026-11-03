<div class="ci-x" id="cix" data-prevent-swipe>
<style>
.ci-x{font-size:20px;text-align:left;display:flex;flex-direction:column;
  gap:10px}
.ci-x .row{display:flex;align-items:center;gap:14px}
.ci-x label{flex:0 0 300px;font-weight:600}
.ci-x input[type=range]{flex:1}
.ci-x .v{flex:0 0 120px;text-align:right;font-weight:700;
  font-family:monospace}
.ci-x svg{width:100%;height:120px}
.ci-x .tick{font-size:15px;fill:#555;text-anchor:middle;font-family:monospace}
.ci-x .out{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.ci-x .box{border:1px solid #ccc;border-radius:6px;padding:8px 12px}
.ci-x .k{font-size:15px;color:#555}
.ci-x .big{font-size:26px;font-weight:700}
.ci-x .note{font-size:15px;color:#555}
</style>
<div class="row"><label>Number of test tasks, <i>n</i></label>
 <input class="n" type="range" min="0" max="6" value="2"
  aria-label="Number of test tasks">
 <span class="v vn"></span></div>
<div class="row"><label>Tasks passed, <i>k</i></label>
 <input class="k" type="range" min="0" max="20" value="17"
  aria-label="Tasks passed">
 <span class="v vk"></span></div>
<svg viewBox="0 0 1000 120" aria-label="Observed pass rate and its 95
 percent Wilson interval on a 0 to 100 percent axis, with a dashed line at
 an illustrative 70 percent threshold">
 <line x1="40" x2="960" y1="70" y2="70" stroke="#999" stroke-width="2"/>
 <g class="ticks"></g>
 <line class="base" y1="20" y2="85" stroke="#b45309" stroke-width="3"
  stroke-dasharray="7 6"/>
 <text class="tick bl" y="14" fill="#b45309">70% (illustrative threshold)</text>
 <rect class="ci" y="58" height="24" rx="4" fill="#2563eb" opacity=".35"/>
 <circle class="pt" cy="70" r="9" fill="#2563eb"/>
</svg>
<div class="out">
 <div class="box"><div class="k">Observed rate and 95% Wilson interval</div>
  <div class="big civ"></div><div class="note verdict"></div></div>
 <div class="box"><div class="k">Plug-in estimate that
  <input class="m" type="range" min="1" max="10" value="5"
   style="width:110px;vertical-align:middle" aria-label="Number of runs">
  <span class="mv"></span> independent runs all pass</div>
  <div class="big pk"></div><div class="note pki"></div></div>
</div>
<script>
(function(){
  const r = document.getElementById("cix"), $ = s => r.querySelector(s);
  const NS = [5, 10, 20, 30, 50, 100, 200];
  const x = v => 40 + v * 920;
  const tg = $(".ticks");
  for (let t = 0; t <= 100; t += 10) {
    tg.insertAdjacentHTML("beforeend",
      `<line x1="${x(t/100)}" x2="${x(t/100)}" y1="64" y2="76" stroke="#999"/>
       <text class="tick" x="${x(t/100)}" y="106">${t}%</text>`);
  }
  $(".base").setAttribute("x1", x(.7)); $(".base").setAttribute("x2", x(.7));
  $(".bl").setAttribute("x", x(.7));
  function wilson(k, n, z = 1.96){
    const p = k / n, d = 1 + z*z/n;
    const m = (p + z*z/(2*n)) / d;
    const h = z * Math.sqrt(p*(1-p)/n + z*z/(4*n*n)) / d;
    return [Math.max(0, m - h), Math.min(1, m + h)];
  }
  const pct = v => (100 * v).toFixed(1) + "%";
  let rate = 17 / 20;
  function draw(fromN){
    const n = NS[$(".n").value], ks = $(".k");
    ks.max = n;
    if (fromN) ks.value = Math.round(rate * n);
    const k = +ks.value, p = k / n, m = +$(".m").value;
    rate = p;
    const [lo, hi] = wilson(k, n);
    $(".vn").textContent = "n = " + n;
    $(".vk").textContent = "k = " + k;
    $(".ci").setAttribute("x", x(lo));
    $(".ci").setAttribute("width", Math.max(2, x(hi) - x(lo)));
    $(".pt").setAttribute("cx", x(p));
    $(".civ").textContent = k + "/" + n + " = " + pct(p) +
      ", CI " + pct(lo) + " to " + pct(hi);
    $(".verdict").textContent = lo > .7
      ? "The whole interval is above the 70% threshold."
      : "The interval includes rates at or below 70%.";
    $(".mv").textContent = m;
    $(".pk").textContent = pct(p ** m);
    $(".pki").textContent = "Using the interval endpoints instead: " +
      pct(lo ** m) + " to " + pct(hi ** m);
  }
  $(".n").oninput = () => draw(true);
  $(".k").oninput = () => draw(false);
  $(".m").oninput = () => draw(false);
  r.querySelectorAll("input").forEach(el => el.onchange = () => el.blur());
  draw(true);
})();
</script>
</div>
