$ ->
  "use strict"

  $selectables = $('a.selectable')

  changeCurrentBox = ($obj) ->
    $selectables.removeClass('selected')
    $obj.addClass('selected')

  (->
    if $.support.pjax
      $.pjax.enable()

      $pjaxContainer = $('#container')
      $indicator = $('.indicator')

      selectContainer = (options) ->
        if options && ('container' in options)
          "#{options.container}"
        else
          '#container'

      $(document).on 'click', 'a[data-pjax]', (e) ->
        console.log 'pjax:click'
        $container = if $(this).data('container')
          $($(this).data('container'))
        else
          $pjaxContainer
        console.log "container: #{$container.attr('id')}"
        $.pjax.click(e, {container: $container})
        e.preventDefault()

      $(document).on 'submit', 'form[data-pjax]', (e) ->
        console.log 'pjax:submit'
        $container = if $(this).data('container')
          $($(this).data('container'))
        else
          $pjaxContainer
        console.log "container: #{$container.attr('id')}"
        $.pjax.submit(e, $container)
        e.preventDefault()

      $(document).on 'pjax:start', (e, options) ->
        console.log "pjax:start #{selectContainer(options)}"
        $(selectContainer(options)).hide()
        $indicator.removeClass('hidden')
        e.preventDefault()

      $(document).on 'pjax:end', (e, options) ->
        console.log "pjax:end #{selectContainer(options)}"
        $indicator.addClass('hidden')
        $(selectContainer(options)).show('slide', {direction: 'left'}, 200)
        e.preventDefault()

      $(document).on 'pjax:timeout', (e) ->
        console.log 'pjax:timeout'
        e.preventDefault()

      $(document).on 'pjax:popstate', (e) ->
        console.log 'pjax:popstate'
        $currentBox = $selectables.filter("a[href='#{e.state.url}']")
        changeCurrentBox($currentBox)
  )()

  (->
    $(document).on 'click', 'a.selectable', ->
      $self = $(this)
      changeCurrentBox($self)
  )()