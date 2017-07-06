import json
from collections import namedtuple
data = '{"head": {"vars": ["label"]},"results": {"bindings": [{"label": {"xml:lang": "en","type": "literal","value": "absent"}},{"label": {"xml:lang": "de","type": "literal","value": "absent abwesend"}},{"label": {"xml:lang": "es","type": "literal","value": "ausente"}},{"label": {"xml:lang": "pt","type": "literal","value": "ausente"}},{"label": {"xml:lang": "zh-hans","type": "literal","value": "缺席"}},{"label": {"xml:lang": "zh-hant","type": "literal","value": "缺席"}}]}}'
x = json.loads(data, object_hook=lambda d: namedtuple('X', d.keys(), rename=True)(*d.values()))
print(x.results.bindings[2].label._0, x.results.bindings[2].label.value)