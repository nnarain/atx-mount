include <NopSCADlib/lib.scad>
use <parts/psu-mount.scad>
use <parts/drive-mount.scad>
include <vitamins/motherboards.scad>

motherboard_type = ATX;

show_mother_board = true;
show_psu_assembly = true;
show_drive_assembly = true;

//! TODO: Assembly instructions
module main_assembly()
assembly("main") {
    if (show_mother_board)
        motherboard(motherboard_type);
    if (show_psu_assembly)
        psu_assembly();
    if (show_drive_assembly)
        translate([motherboard_width(motherboard_type) - drive_cage_width(), drive_cage_length(), 0])
            rotate(-90)
                drive_assembly();
}

if($preview)
    main_assembly();
