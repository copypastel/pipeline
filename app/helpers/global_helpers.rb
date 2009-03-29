module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def video_frame_around(html)
      # TODO: GET ECIN TO LOOK AT THIS!!!  For some reason the frame spans all the way to the right for the thumnails
      # I haven't tried with multiple soundtracks added, just 1.  Also I did update it for our versions of merb so pulling should work off the bat.  -Dai
      "<div style=\"       background: url('images/frame_horizontal_top.png')    repeat-x top left;    width: 100%; height: 100%; position: relative;\">
          <div style=\"    background: url('images/frame_horizontal_bottom.png') repeat-x bottom left; width: 100%; height: 100%; position: relative;\">
            <div style=\"  background: url('images/frame_vertical.png')          repeat-y top left;    width: 100%; height: 100%; position: relative;\">
              <div style=\"background: url('images/frame_vertical.png')          repeat-y top right;   width: 100%; height: 100%; position: relative;\">
                <div style='position: relative;width: 100%; height: 100%;'>
                  <span style=\"background: url('images/corner_top_left.png')     no-repeat; position: absolute; width: 22px; height: 22px; top: 0;    left: 0;\"> </span>
                  <span style=\"background: url('images/corner_top_right.png')    no-repeat; position: absolute; width: 22px; height: 22px; top: 0;    right: 0;\"></span>
                  <span style=\"background: url('images/corner_bottom_left.png')  no-repeat; position: absolute; width: 22px; height: 22px; bottom: 0; left: 0;\"> </span>
                  <span style=\"background: url('images/corner_bottom_right.png') no-repeat; position: absolute; width: 22px; height: 22px; bottom: 0; right: 0;\"></span>
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
