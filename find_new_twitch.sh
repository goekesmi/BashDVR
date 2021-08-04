cat *twitch/URL | sort > twitch_urls.known
cat location_twitch_url | sort | uniq > twitch_urls.listed
diff -u twitch_urls.known twitch_urls.listed

