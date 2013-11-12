defaultConfig = 
	isValue: false
	style: {}

$.fn.placeholder = (opts) ->
	opts = $ {}, defaultConfig, opts
	isValue = opts.isValue

	inps = $(@).find 'input[placeholder],textarea[placeholder]'

	# 判断浏览器是否支持placeholder
	supportPlaceholder = `'placeholder' in document.createElement('input')`

	
	if not supportPlaceholder
		# value方式
		if isValue
			inps.each ->
				elem = $ val
				v = elem.val()
				placeholder = elem.attr 'placeholder'

				if val is ''
					elem.val placeholder

				elem.on 'focus', ->
					if elem.val() is placeholder
						elem.val ''
					return
				elem.on 'blur', ->
					v = elem.val()

					if v is '' or val is placeholder
						elem.val placeHolder
					return
				return
		else 
			inps.each ->
				elem = $(@)
				placeholder = elem.attr 'placeholder'
				pid = elem.attr 'id'
				if !pid
					pid = 'placeholder'+ Math.random()
					elem.attr 'id', pid
				width = elem.width()
				height = elem.height()
				top = elem.position().top
				left = elem.position().left
				pl = elem.css 'padding-left'
				pt = elem.css 'padding-top'
				lh = if elem[0].nodeName.toLowerCase() is 'textarea' then '' else height
				cssObj = $.extend {}, 
					position: "absolute"
					top: top
					left: left
					display: 'inline-block'
					color: "#ACA899"
					cursor: "text"
					fontFamily: elem.css 'font-family'
					fontSize: elem.css 'font-size'
					paddingLeft: pl
					paddingTop: pt
					width: width
					height: height
					lineHeight: lh + 'px'
					zIndex: 0
				, opts.style
				# 状态初始化
				elementLabel = $("<small for=\"#{pid}\"></small>").css(cssObj).insertBefore elem
				if not $.trim elem.val()
					elementLabel.text placeholder
				elementLabel.click ->
					elem.trigger 'focus'
				elem.bind
					"focus": ->
						elementLabel.html ""
						return
					"blur": ->
						if $(@).val() is ""
							elementLabel.html placeholder
						return
				return
	return
