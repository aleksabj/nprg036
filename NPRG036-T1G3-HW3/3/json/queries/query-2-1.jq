# input: 3/json/data/data-2.jsonld
# run:    jq -f 3/json/queries/query-2-1.jq 3/json/data/data-2.jsonld
.people
| map(select(.roles | index("Actor")))
| map({name: .name, films: ((.actsIn // []) | length)})
| sort_by(.films) | reverse
