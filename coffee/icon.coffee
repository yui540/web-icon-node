class Icon
	constructor: ->
		@url  = require 'url'
		@path = require 'path'
		@reg  = 
			"apple-touch-icon" : /<link rel=\"apple-touch-icon\".*?>/g
			"shortcut icon"    : /<link rel=\"shortcut icon\".*?>/g
			"fluid-icon"       : /<link rel=\"fluid-icon\".*?>/g
			"icon"             : /<link rel=\"icon\".*?>/g

	##
	# アイコンの取得
	# @param url  : URL
	# @param body : Response Body
	## 
	get: (url, body) ->
		list = {}
		for key, _reg of @reg
			list[key] = @checkIcon _reg, url, body

		return list

	##
	# アイコンのチェック
	# @param reg  : 正規表現
	# @param url  : URL
	# @param body : Response Body
	## 
	checkIcon: (reg, url, body) ->
		list = []
		link = null
		url  = @url.parse url

		# link tag
		link = body.match reg
		if not link
			link = []

		for _link in link
			href = _link.match /href=\".*?\"/

			# href attribute
			if href
				href = href[0].replace /(href=|\")/g, ''
				if not href.match /(http:|https:)/
					href = @path.join url.host, href
					href = url.protocol + '//' + href

				list.push href

		return list

module.exports = new Icon()