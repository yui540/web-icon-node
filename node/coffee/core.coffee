request = require 'request'
url     = require 'url'
icon    = require './icon'

module.exports =
	##
	# アイコンの取得
	# @param _url : URL
	# @param fn   : callback
	##
	get: (_url, fn) ->
		_url = url.parse _url
		_url = _url.protocol + '//' + _url.host

		request _url, (err, res, body) ->
			# Error
			if err
				fn 
					"apple-touch-icon" : []
					"shortcut icon"    : []
					"icon"             : []

			# OK
			else
				list = icon.get _url, body
				fn list