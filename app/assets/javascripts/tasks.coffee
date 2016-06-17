contentLoaded = ->
  $(".add-new-task-status li a").on "click", ->
    newValue = this.text.replace /\%/, ""
    taskId = $(this).parent().parent().attr('data-id')
    updateTarget = $(this).parent().parent().parent().find('.current-task-status')

    $.ajax
      url: "/tasks/set-task-status"
      data:
        id: taskId,
        status: newValue
      type: "PUT"
      success: (response) ->
        if response
          updateTarget.html "#{newValue}%"
        else
          alert "ERROR !, recarregue a página e tente novamente"


$(document).ready contentLoaded
$(document).on "page:load", contentLoaded
