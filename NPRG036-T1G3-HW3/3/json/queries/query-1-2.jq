# input: 3/json/data/data-1.jsonld
# run:    jq -f 3/json/queries/query-1-2.jq 3/json/data/data-1.jsonld
def placeName($iri): (.places[] | select(.iri==$iri) | .label);

(.screenings // [])
| map(select((.startDate >= "2025-05-20T00:00:00Z") and (.startDate <= "2025-05-22T23:59:59Z")))
| map({
    screening: .iri,
    film: .movieRef.iri,
    place: placeName(.locationRef.iri),
    startDate: .startDate
  })
