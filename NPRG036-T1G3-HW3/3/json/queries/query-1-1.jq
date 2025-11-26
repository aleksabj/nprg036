# input: 3/json/data/data-1.jsonld
# run:    jq -n --slurpfile d2 3/json/data/data-2.jsonld -f 3/json/queries/query-1-1.jq 3/json/data/data-1.jsonld
def people: $d2[0].people;
(.movies // [])
| map(select(.durationMinutes > 120))
| map({
    movie: .name,
    directors: ( people
                 | map(select(.directed? and (.directed | index(.iri))))
                 | map(.name) )
  })
