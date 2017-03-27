http = require './http'
icon = require './icon'

module.exports =
	##
	# アイコンの取得
	# @param _url : URL
	# @param fn   : callback
	##
	get: (_url, fn) =>
		http.request _url, (res) ->

			# redirect
			if res.status is 301
				_url = res.header.location

				http.request _url, arguments.callee

			# error
			else if res is false
				fn 
					"apple-touch-icon" : false
					"shortcut icon"    : false
					"icon"             : false

			# OK
			else
				list = icon.get _url, res.body
				fn list