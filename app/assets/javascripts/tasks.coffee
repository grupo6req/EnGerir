updateByAjax = (taskId, newValue, updateTarget) ->
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


updateLocaly = (newValue, updateTarget) ->
  updateTarget.html "#{newValue}%"
  $("#task_status").val newValue


contentLoaded = ->
  $(".add-new-task-status li a").on "click", ->
    newValue = this.text.replace /\%/, ""
    taskId = $(this).parent().parent().attr('data-id')
    updateTarget = $(this).parent().parent().parent().find('.current-task-status')
    sendAjax = JSON.parse $(this).parent().parent().attr('data-send-ajax')

    if sendAjax
      updateByAjax taskId, newValue, updateTarget
    else
      updateLocaly newValue, updateTarget


$(document).ready contentLoaded
$(document).on "page:load", contentLoaded
