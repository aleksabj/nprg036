# input: 3/json/data/data-1.jsonld
# run:    jq -f 3/json/queries/query-1-3.jq 3/json/data/data-1.jsonld
def title($iri): (.movies[] | select(.iri==$iri) | .name);

(.awards // [])
| map(select(.prizeMoney > 3000))
| map({award: .name, movie: title(.movieRef.iri), prize: .prizeMoney})
