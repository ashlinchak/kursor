jQuery ->

  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 200/280
      setSelect: [0,0,600,600]
      onSelect: @update
      onChange: @update
  update: (coords) =>
    $('#profile_crop_x').val(coords.x)
    $('#profile_crop_y').val(coords.y)
    $('#profile_crop_w').val(coords.w)
    $('#profile_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
      width: Math.round(200/coords.w * $('#cropbox').width()) + 'px'
      height: Math.round(280/coords.h * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(200/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(280/coords.h * coords.y) + 'px'