module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    #TODO: clean this up to use CSS.  Currently you have to wrap this with a div tag of the height and width, should be able to clean this up to take the shape of whatever it is wrapping.
    def video_frame_around(html)
      "<div style=\"       background: url('/images/frame_horizontal_top.png')    repeat-x top left;    width: 100%; height: 100%; position: relative;\">
          <div style=\"    background: url('/images/frame_horizontal_bottom.png') repeat-x bottom left; width: 100%; height: 100%; position: relative;\">
            <div style=\"  background: url('/images/frame_vertical.png')          repeat-y top left;    width: 100%; height: 100%; position: relative;\">
              <div style=\"background: url('/images/frame_vertical.png')          repeat-y top right;   width: 100%; height: 100%; position: relative;\">
                <div style='position: relative;width: 100%; height: 100%;'>
                  <span style=\"background: url('/images/corner_top_left.png')     no-repeat; position: absolute; width: 22px; height: 22px; top: 0;    left: 0;\"> </span>
                  <span style=\"background: url('/images/corner_top_right.png')    no-repeat; position: absolute; width: 22px; height: 22px; top: 0;    right: 0;\"></span>
                  <span style=\"background: url('/images/corner_bottom_left.png')  no-repeat; position: absolute; width: 22px; height: 22px; bottom: 0; left: 0;\"> </span>
                  <span style=\"background: url('/images/corner_bottom_right.png') no-repeat; position: absolute; width: 22px; height: 22px; bottom: 0; right: 0;\"></span>
                  <div style='height: 100%; width: 100%; padding: 10px'>
        "+html+"

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>"
    end
  end
end
