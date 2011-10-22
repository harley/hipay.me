module InvoicesHelper
  def clippy(text, bgcolor='#FFFFFF')
    elem_id = "clippy_#{rand(10000)}"
    #TODO add tooltip support for this
    html = <<-EOF
      <span style="display:none" id="#{elem_id}" class="clippy-text">#{text}</span>
      <span id="clippy_tooltip_#{elem_id}" class="tipsy_tooltip" data-gravity="s" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="14" height="14" class="clippy" id="clippy">
      <param name="movie" value="/assets/clippy.swf">
      <param name="allowScriptAccess" value="always">
      <param name="quality" value="high">
      <param name="scale" value="noscale">
      <param name="FlashVars" value="id=clippy_659&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#{bgcolor}">
      <param name="wmode" value="opaque">
      <embed src="/assets/clippy.swf" width="14" height="14" name="clippy" quality="high" allowscriptaccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=#{elem_id}&amp;copied=copied!&amp;copyto=copy to clipboard" bgcolor="#FFFFFF" wmode="opaque">
      </object>
    </span>
    <script>
function clippyCopiedCallback(a) {
    var b = $("#clippy_tooltip_" + a);
    b.length != 0 && (b.attr("title", "copied!").twipsy("show"), setTimeout(function() {
        b.attr("title", "copy to clipboard")
    }, 500))
}
    </script>

    EOF
    html.html_safe
  end

end
