{% if page.comments %}
	<div class="comments" id="comments"></div>
	<script src="/static/iDisqus.min.js"></script>
	<script>
		var disq = new iDisqus('comments', {
			forum: 'thickheadedx',
			api: 'https://www.yumumu.space/disqus-proxy',
			mode: 1,
			timeout: 3000,
			init: true
		});
	</script>
	<link rel="stylesheet" href="/static/iDisqus.min.css">
{% endif %}