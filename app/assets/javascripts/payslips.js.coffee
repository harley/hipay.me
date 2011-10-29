# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("a#add_item").click =>
    elem = $("ul.invoice_items li").last().wrap("<div>").html()
    new_id = parseInt(elem.match(/invoice_items_attributes_(\d+)_amount/)[1]) + 1
    new_elem = elem.replace(/invoice_items_attributes_(\d+)_/g, "invoice_items_attributes_" + new_id + "_").
                    replace(/invoice\[items_attributes\]\[(\d+)\]/g, "invoice\[items_attributes\]\[" + new_id + "\]")
    #console.log "elem is: ", new_elem
    $("ul.invoice_items").append("<li class='invoice_item'>" + new_elem + "</li>")
    false
  $("a.remove_item").live 'click', ->
    $(this).parents('li.invoice_item').remove()
    false
  $("input.item_amount").live 'change', ->
    total = 0
    $("input.item_amount").each (index) ->
      #console.log index, $(this)
      amt = $(this).val()
      total += parseFloat(amt) || 0
      #console.log amt, ", ", total
    $("#computed_total_amount").val(total)


