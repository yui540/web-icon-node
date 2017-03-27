http = require 'http'
url  = require 'url'

module.exports = 
	##
	# http request
	# @param _url : URL
	# @param fn   : callback
	##
	request: (_url, fn) ->
		_url = url.parse(_url)
		html = ''
		opts = 
			host : _url.host
			port : _url.port

		http.get opts, (res) ->

			# data
			res.on 'data', (chunk) ->
				html += chunk

			# end
			res.on 'end', ->
				fn
					status : res.statusCode
					header : res.headers
					body   : html

		# error
		.on 'error', (err) ->
			fn false