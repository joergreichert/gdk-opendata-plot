select
  t.id,
  t.lat,
  t.lng,
  t.artdtsch,
  t.artbot,
  t.gattung as gattungdeutsch,
  t.strname,
  t.pflanzjahr,
  2025-t.pflanzjahr as standalter,
  t.bezirk,
  t.standortnr,
  max(w.amount::int) as wassermenge,
  sum(w.amount::int) as wassersumme,
  count(w) as anzahlg
from trees t join trees_watered w on t.id = w.tree_id
where w.timestamp >= '20250301' and w.timestamp < '20251001'
and w.uuid not like 'auth0|6681c5602377db44e1694211'
group by t.id