class App.Views.SaveImageView extends Backbone.View

  el: '.card-view'

  events:
    'click .generate-image': 'generateImage'

  initialize: ->
    @ui =
      genButton: @$el.find('button')
      saveButton: @$el.find('a')
    @model.on('change', @resetButton)

  resetButton: =>
    if @model.isNeutralIdentity()
      @ui.genButton.addClass('disabled')
    else
      @ui.genButton.removeClass('disabled')
    @ui.saveButton.addClass('disabled').attr(href: null)

  ## RENDER IMAGE
  generateImage: (ev) =>
    @model.save()
    html2canvas @$el.find('.card'),
      allowTaint: true
      onrendered: (canvas) =>
        imageData = canvas.toDataURL("image/png");
        cardname = @model.get('name').replace(/[^a-z0-9]/gi, '_').toLowerCase()
        @ui.saveButton.attr(href :imageData, download: "netrunner-#{cardname}.png").removeClass('disabled')
    ga('send', 'event', 'generate-image', 'name', @model.get('name'));

