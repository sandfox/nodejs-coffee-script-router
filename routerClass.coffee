url  = require 'url'
util = require 'util'

class routerClass

	routes : []
	

	addRoute  : (method, path, callback) -> 
		route = {
			method
			path
			callback
		}
		console.log route
		@routes.push route
		true


	get : (path, handler) ->
		@addRoute "GET", path, handler

	post : (path, handler) ->
		@addRoute "POST", path, handler

	put : (path, handler) ->
		@addRoute "PUT", path, handler

	head : (path, handler) ->
		@addRoute "HEAD", path, handler

	delete : (path, handler) ->
		@addRoute "DELETE", path, handler
		
	options : (path, handler) ->
		@addRoute "OPTIONS", path, handler

	setFallbackHandler : (@fallbackHandler) ->

	setErrorHandler : (@errorHandler) ->
 
	routeRequest : (request, response) =>
		console.time pathname
		try
			pathname = url.parse(request.url).pathname
			console.time pathname
			for route in @routes
				if (request.method is route.method and pathname is route.path)
					route.callback request, response
					routed = true

			if not routed
				@fallbackHandler request, response
		catch err
			@errorHandler request, response
			
		console.timeEnd pathname
		true


module.exports = routerClass