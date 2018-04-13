xquery version "3.1";

let $photos := fn:collection('chapman')/photos/photo

return tokenize($photos[6]/tags/text()," ")