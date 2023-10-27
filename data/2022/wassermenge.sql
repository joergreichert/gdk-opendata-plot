select
  t.id,
  t.lat,
  t.lng,
  t.artdtsch,
  t.artbot,
  t.gattung as gattungdeutsch,
  t.strname,
  t.pflanzjahr,
  2022-t.pflanzjahr as standalter,
  t.bezirk,
  t.standortnr,
  max(w.amount::int) as wassermenge,
  sum(w.amount::int) as wassersumme,
  count(w) as anzahlg
from trees t join trees_watered w on t.id = w.tree_id
where w.timestamp >= '20220301' and w.timestamp < '20221001'
group by t.id