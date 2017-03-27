url  = require 'url'
path = require 'path'

checkIcon = (type, _url, body) ->
	link = null
	_url = url.parse _url

	# link tag
	if type is 'apple-touch-icon'
		link = body.match /<link.*?rel=\"apple-touch-icon\".*?>/
	else if type is 'shortcut icon'
		link = body.match /<link.*?rel=\"shortcut icon\".*?>/
	else 
		link = body.match /<link.*?rel=\"icon\".*?>/

	if not link
		return false
	link = link[0]

	# href
	href = link.match /href=\".*?\"/
	if not href
		return false
	href = href[0].replace /(href=|\")/g, ''

	# icon
	icon = path.join _url.host, href
	icon = _url.protocol + '//' + icon
	return icon

module.exports =
	##
	# iconの取得
	# @param _url : URL
	# @param body : response body
	##
	get: (_url, body) ->
		icon = {}
		rel  = ['apple-touch-icon', 'shortcut icon', 'icon']

		for _rel in rel
			_icon = checkIcon _rel, _url, body
			icon[_rel] = _icon

		return icon

