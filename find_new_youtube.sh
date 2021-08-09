cat *youtube/URL | sort > youtube_urls.known
cat location_youtube_url | sort | uniq > youtube_urls.listed
diff -u youtube_urls.known youtube_urls.listed

