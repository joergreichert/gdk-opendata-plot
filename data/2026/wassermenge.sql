select
  t.id,
  t.lat,
  t.lng,
  t.art_dtsch,
  t.art_bot,
  t.gattung as gattungdeutsch,
  t.strname,
  t.pflanzjahr,
  2026-t.pflanzjahr as standalter,
  t.bezirk,
  t.standortnr,
  max(w.amount::int) as wassermenge,
  sum(w.amount::int) as wassersumme,
  count(w) as anzahlg
from trees t join trees_watered w on t.id = w.tree_id
where w.timestamp >= '20260301' and w.timestamp < '20261001'
and w.uuid not like '9d617de9-930f-414e-b539-2a91695f30d1'
group by 1,2,3,4,5,6,7,8,9,10,11 