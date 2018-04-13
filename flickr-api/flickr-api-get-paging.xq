declare function local:query-endpoint($endpoint,$query)
{
(: Default response is XML, Accept header can be specified explicitly as below.  Use "application/json" for JSON. :)
let $acceptType := "application/xml"
let $encoded := $endpoint||"?"||$query
let $request := <http:request href='{$encoded}' method='get'><http:header name='Accept' value='{$acceptType}'/></http:request>
return
  http:send-request($request)
};

declare function local:get-page($userID,$consumerKey,$page,$endpoint)
{
let $query := 'method=flickr.people.getPhotos&amp;extras=license,media,original_format,description,date_taken,geo,tags,machine_tags,url_t,url_o&amp;per_page=500&amp;page='||$page||'&amp;user_id='||$userID||'&amp;oauth_consumer_key='||$consumerKey
let $response := local:query-endpoint($endpoint,$query)

for $photo in $response[2]/rsp/photos/photo
return 
<photo>
    <id>{data($photo/@id)}</id>
    <title>{data($photo/@title)}</title>
    <license>{data($photo/@license)}</license>
    <dateTaken>{data($photo/@datetaken)}</dateTaken>
    <tags>{data($photo/@tags)}</tags>
    <machineTags>{data($photo/@machine_tags)}</machineTags>
    <format>{data($photo/@originalformat)}</format>
    <latitude>{data($photo/@latitude)}</latitude>
    <longitude>{data($photo/@longitude)}</longitude>
    <accuracy>{data($photo/@accuracy)}</accuracy>
    <placeId>{data($photo/@place_id)}</placeId>
    <woeid>{data($photo/@woeid)}</woeid>
    <media>{data($photo/@media)}</media>
    <thumbUrl>{data($photo/@url_t)}</thumbUrl>
    <thumbHeight>{data($photo/@height_t)}</thumbHeight>
    <thumbWidth>{data($photo/@width_t)}</thumbWidth>
    <originalUrl>{data($photo/@url_o)}</originalUrl>
    <originalHeight>{data($photo/@height_o)}</originalHeight>
    <originalWidth>{data($photo/@width_o)}</originalWidth>
    {$photo/description}
</photo>
};

(: The initial query is just to determine the number of results :)
let $userID := '32005048@N06'  (: Arthur Chapman :)
let $consumerKey := '[insert API key here]'
let $query := 'method=flickr.people.getPhotos&amp;per_page=1&amp;page=1&amp;user_id='||$userID||'&amp;oauth_consumer_key='||$consumerKey
let $endpoint := 'https://api.flickr.com/services/rest/'
let $response := local:query-endpoint($endpoint,$query)

let $numberOfResults := number(data($response[2]/rsp/photos/@total))
let $pages := ($numberOfResults idiv 500) + 1 (: max records allowed per page is 500 :)

return (file:write("c:\test\flickr\chapman.xml",

<photos>{
for $page in (1 to $pages) 
  return local:get-page($userID,$consumerKey,$page,$endpoint)
}</photos>

))